import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:aviation_app/features/podcast_screen/data/dummy_data.dart';
import 'package:aviation_app/features/podcast_screen/model/podcast_model.dart';
import 'package:aviation_app/features/podcast_screen/presentation/widget/podcast_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PodcastScreen extends StatelessWidget {
  const PodcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return CreateScreen(
      child: SafeArea(
        child: SingleChildScrollView(
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
                ListView.builder(
                  itemCount: podcasts.length,
                  shrinkWrap:
                      true, // Add this to allow the ListView to take only the needed space
                  physics:
                      NeverScrollableScrollPhysics(), // Prevents nested scrolling conflicts
                  itemBuilder: (context, index) {
                    final Podcast podcast = Podcast.fromJson(podcasts[index]);
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: PodcastItem(podcast: podcast),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
