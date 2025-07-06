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
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(ebookApiProvider.notifier).loadEbooks(page: 1, limit: 10);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ebookState = ref.watch(ebookApiProvider);
    final textTheme = Theme.of(context).textTheme;

    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
          children: [
            EBookAppBar(textTheme: textTheme),
            Flexible(
              child: ebookState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ebookState.error != null
                  ? Center(child: Text('Error: ${ebookState.error}', style: const TextStyle(color: Colors.red)))
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Text('E-book', style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold)),
                    SizedBox(height: 20.h),
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
                      itemCount: ebookState.ebooks.length,
                      itemBuilder: (context, index) {
                        final book = ebookState.ebooks[index];
                        return BookCard(book: book);
                      },
                    ),
                    if (ebookState.hasMore && !ebookState.isFetching)
                      ElevatedButton(
                        onPressed: () {
                          ref.read(ebookApiProvider.notifier).loadMoreEbooks(limit: 10);
                        },
                        child: const Text('Load More'),
                      ),
                    if (ebookState.isFetching) const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
