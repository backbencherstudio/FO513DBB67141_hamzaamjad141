import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constant/icons.dart';
import '../../../core/constant/padding.dart';
import '../../../core/utils/common_widget/common_widget.dart';
import '../../../core/utils/utils.dart';
import '../../create_screen/create_screen.dart';
import 'package:flutter/material.dart';

import '../../ebook_screen/presentation/widgets/audio_player_widget.dart';
import '../data/podcast_provider.dart';


class PodcastPlayerScreen extends ConsumerWidget {
  final String podcastId;
  const PodcastPlayerScreen({super.key, required this.podcastId, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final podcast = ref.watch(podcastByIdProvider(podcastId));
    final audioUrl = podcast?.audioUrl;
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
              podcast != null
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.network(podcast.imageUrl,height: 256.h,width: 256.w,fit: BoxFit.cover,)),
                  SizedBox(height: 24.h,),
                  Text(Utils.dateFormat(date: podcast.publishDate),style: textTheme.labelSmall,),
                  SizedBox(height: 5.h,),
                  Text(podcast.title,style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),),
                  SizedBox(height: 24.h,),
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
