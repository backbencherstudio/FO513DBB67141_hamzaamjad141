import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_name.dart';
import '../../model/e_book_model.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book});

  final EBook book;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: (){
        context.push('${RouteName.ebookPlay}/${book.bookId}');
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity,),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: Image.network(
                    book.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.error, color: Colors.red, size: 40),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.bookTitle,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (book.progress == 1.0)
                        SvgPicture.asset(
                          AppIcons.circleCheckBox,
                          height: 16.h,
                          width: 16.w,
                        ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    Utils.dateFormat(date: book.publishDate),
                    style: textTheme.labelLarge!.copyWith(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  if (book.progress > 0.0 && book.progress < 1.0)
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(30),
                      child: LinearProgressIndicator(
                        value: book.progress,
                        backgroundColor: Color(0xff4A4C56),
                        color: Color(0xff777980),
                        minHeight: 6.h,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
