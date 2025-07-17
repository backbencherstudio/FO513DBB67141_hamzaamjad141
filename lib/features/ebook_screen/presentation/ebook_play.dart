import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/core/utils/utils.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../data/riverpod/ebook_riverpod.dart';

class EbookPlay extends ConsumerWidget {
  final String ebookId;

  const EbookPlay({super.key, required this.ebookId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ebook = ref.watch(ebookByIdProvider(ebookId));
    TextTheme textTheme = Theme.of(context).textTheme;

    return CreateScreen(
      child: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            children: [
              // App Bar Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: CommonWidget.secondaryButton(
                      child: SvgPicture.asset(AppIcons.backIcon),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Check for eBook data
              ebook != null
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ebook.bookTitle,
                              style: textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            SizedBox(height: 5.h, width: double.infinity),

                            Text(
                              Utils.dateFormat(date: ebook.publishDate),
                              style: textTheme.labelSmall,
                            ),

                            SizedBox(height: 15.h),

                            SizedBox(
                              height: 600.h, // Adjust as needed
                              child: SfPdfViewer.network(
                                'https://freetestdata.com/wp-content/uploads/2023/07/260KB.pdf',
                                canShowScrollHead: true,
                                canShowScrollStatus: true,
                                enableDoubleTapZooming: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
