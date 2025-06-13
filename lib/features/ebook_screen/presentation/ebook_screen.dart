import 'package:aviation_app/core/constant/padding.dart';

import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/ebook_screen/data/dummy_data.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/e_book_model.dart';

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

            /*Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: EbookList.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = EbookList[index];
                  EBook book = EBook.fromJson(data);

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 150,  // Fixed height
                            width: double.infinity,  // Full width
                            child: Image.network(
                              book.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child; // Image loaded successfully
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            book.bookTitle,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(book.bookId),
                              Spacer(),
                              LinearProgressIndicator(
                                value: book.progress,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation(Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
