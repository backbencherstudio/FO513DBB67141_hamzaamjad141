import 'package:aviation_app/core/constant/padding.dart';

import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/ebook_screen/data/dummy_data.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/e_book_model.dart';
import 'widgets/book_card.dart';

class EbookScreen extends StatelessWidget {
  const EbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: Column(
          children: [
            EBookAppBar(textTheme: textTheme),
            SizedBox(height: 32.h),
            Text('E-book', style: textTheme.headlineSmall),
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7, // Example constraint
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.55,
                  ),
                  itemCount: EbookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final data = EbookList[index];
                    EBook book = EBook.fromJson(data);

                    return BookCard(book: book);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

