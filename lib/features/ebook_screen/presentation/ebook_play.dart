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

import '../data/riverpod/ebook_riverpod.dart';
import 'widgets/audio_player_widget.dart'
    show AudioPlayerWidget; // Assuming this contains your provider for EBook

class EbookPlay extends ConsumerWidget {
  final String ebookId;

  const EbookPlay({super.key, required this.ebookId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ebook = ref.watch(ebookByIdProvider(ebookId));
    final audioUrl = ebook?.audioUrl;
    TextTheme textTheme = Theme.of(context).textTheme;
    debugPrint('rebuild');
    return CreateScreen(
      child: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  CommonWidget.secondaryButton(
                    child: SvgPicture.asset(
                      'assets/icons/save_icon.svg',
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ebook != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: Image.network(
                            ebook.imageUrl,
                            height: 256.h,
                            width: 256.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          Utils.dateFormat(date: ebook.publishDate),
                          style: textTheme.labelSmall,
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          ebook.bookTitle,
                          style: textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        if (audioUrl != null)
                          AudioPlayerWidget(audioUrl: audioUrl),
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}
