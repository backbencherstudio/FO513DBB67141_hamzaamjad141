import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/book_card.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/riverpod/ebook_api_provider.dart';



class EbookScreen extends ConsumerStatefulWidget {
  const EbookScreen({super.key});

  @override
  ConsumerState<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends ConsumerState<EbookScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Initial load of ebooks
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadEbooks(query: ''); // Default query to load initial ebooks (empty query)
    });

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      final state = ref.read(ebookApiProvider);
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.9 &&
          !state.isFetching &&
          state.hasMore) {
        debugPrint(
          'Scroll reached 90% - Loading more ebooks (page: ${state.currentPage + 1})',
        );
        ref.read(ebookApiProvider.notifier).loadMoreEbooks(limit: 10);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Function to load ebooks based on the search query or initial load
  void loadEbooks({required String query}) {
    ref.read(ebookApiProvider.notifier).resetEbooks(); // Reset previous search results
    ref.read(ebookApiProvider.notifier).loadEbooks(
      page: 1, // First page of ebooks
      limit: 10,
      query: query, // Use the search query
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    final ebookState = ref.watch(ebookApiProvider);
    final ebooks = ebookState.ebooks;

    debugPrint(
      'Building UI: ebooks=${ebooks.length}, isLoading=${ebookState.isLoading}, '
          'error=${ebookState.error}, hasMore=${ebookState.hasMore}, '
          'isFetching=${ebookState.isFetching}, currentPage=${ebookState.currentPage}',
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
                  'E-books',
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
                              loadEbooks(
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
                        loadEbooks(query: searchController.text.trim());
                      },
                      icon: Icon(Icons.search),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                ebookState.isLoading && ebooks.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ebookState.error != null
                    ? Center(
                  child: Column(
                    children: [
                      Text('Error: ${ebookState.error}'),
                      SizedBox(height: 10.h),
                      ElevatedButton(
                        onPressed: () {
                          debugPrint(
                            'Retrying page ${ebookState.currentPage}',
                          );
                          ref.read(ebookApiProvider.notifier).loadEbooks(
                            page: ebookState.currentPage,
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
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.55,
                      ),
                      itemCount: ebooks.length,
                      itemBuilder: (context, index) {
                        final book = ebooks[index];
                        return BookCard(book: book);
                      },
                    ),
                    if (ebookState.isFetching)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
