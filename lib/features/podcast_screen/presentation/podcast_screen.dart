import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:aviation_app/features/podcast_screen/presentation/widget/podcast_items.dart';
import '../../create_screen/create_screen.dart';
import '../data/riverpod/podcast_repository_provider.dart';

class PodcastScreen extends ConsumerStatefulWidget {
  const PodcastScreen({super.key});

  @override
  PodcastScreenState createState() => PodcastScreenState();
}

class PodcastScreenState extends ConsumerState<PodcastScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initial load of podcasts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadPodcasts(
        query: '',
      ); // Default query to load initial podcasts (empty query)
    });

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          !ref.read(podcastApiProvider).isFetching &&
          ref.read(podcastApiProvider).hasMore) {
        debugPrint(
          'Scroll reached 90% - Loading more podcasts (page: ${ref.read(podcastApiProvider).currentPage + 1})',
        );
        ref.read(podcastApiProvider.notifier).loadMorePodcasts(limit: 10);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to load podcasts based on the search query or initial load
  void loadPodcasts({required String query}) {
    ref
        .read(podcastApiProvider.notifier)
        .resetPodcasts(); // Reset previous search results
    ref
        .read(podcastApiProvider.notifier)
        .loadPodcasts(
          page: 1, // First page of podcasts
          limit: 10,
          query: query, // Use the search query
        );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final podcastState = ref.watch(podcastApiProvider);
    final podcasts = podcastState.podcasts;

    debugPrint(
      'Building UI: podcasts=${podcasts.length}, isLoading=${podcastState.isLoading}, '
      'error=${podcastState.error}, hasMore=${podcastState.hasMore}, '
      'isFetching=${podcastState.isFetching}, currentPage=${podcastState.currentPage}',
    );

    return CreateScreen(
      child: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: AppPadding.screenHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EBookAppBar(textTheme: textTheme),
                SizedBox(height: 20.h),
                Text(
                  'Podcasts',
                  style: textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,

                        decoration: InputDecoration(
                          hintText: 'Search',
                          suffixIcon: searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    searchController.clear();
                                    loadPodcasts(
                                      query: searchController.text.trim(),
                                    );
                                  },
                                  child: Icon(Icons.cancel),
                                )
                              : SizedBox(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 5.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    IconButton(
                      onPressed: () {
                        // Trigger the search with the current input
                        loadPodcasts(query: searchController.text.trim());
                      },
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                podcastState.isLoading && podcasts.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : podcastState.error != null
                    ? Center(
                        child: Column(
                          children: [
                            Text('Error: ${podcastState.error}'),
                            SizedBox(height: 10.h),
                            ElevatedButton(
                              onPressed: () {
                                debugPrint(
                                  'Retrying page ${podcastState.currentPage}',
                                );
                                ref
                                    .read(podcastApiProvider.notifier)
                                    .loadPodcasts(
                                      page: podcastState.currentPage,
                                      limit: 10,
                                    );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          ListView.builder(
                            itemCount:
                                podcasts.length +
                                (podcastState.hasMore && podcastState.isFetching
                                    ? 1
                                    : 0),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (index == podcasts.length &&
                                  podcastState.hasMore &&
                                  podcastState.isFetching) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              final podcast = podcasts[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: PodcastItem(podcast: podcast),
                              );
                            },
                          ),
                          if (!podcastState.isLoading &&
                              podcastState.error == null &&
                              podcasts.isNotEmpty &&
                              !podcastState.hasMore)
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'No more podcasts available',
                                style: textTheme.bodyMedium,
                              ),
                            ),
                        ],
                      ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
