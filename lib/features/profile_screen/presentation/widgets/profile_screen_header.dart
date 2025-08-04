import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/profile_screen/riverpod/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constant/padding.dart';
import '../../../../core/utils/common_widget/common_widget.dart';

class ProfileScreenHeader extends StatelessWidget {
  const ProfileScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      children: [

        /// Back button
        Padding(
          padding: AppPadding.screenHorizontal,
          child: Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: CommonWidget.secondaryButton(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),

        /// Profile Picture
        SizedBox(
          width: 108.w,
          height: 111.h,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Consumer(
                builder: (_, ref, _) {
                  final userImage = ref.watch(authProvider).user!.image;
                  final temporaryImage = ref.watch(profileProvider).temporaryProfilePicture;
                  return   ClipOval(
                    child: temporaryImage != null ?

                     Image.file(
                       temporaryImage,
                    fit: BoxFit.cover,
                  )
                    :
                    Image.network(
                      userImage?? "",
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
                        // Fallback widget in case of error
                        return Center(
                          child: Icon(Icons.image_not_supported_outlined,  size: 40.sp),
                        );
                      },
                    ),
                  );
                }
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Consumer(
                  builder: (_ ,ref, _) {
                    return GestureDetector(
                      onTap: () async {
                       await ref.read(profileProvider.notifier).pickFromGallery();
                      },
                      child: SvgPicture.asset(AppIcons.edit),
                    );
                  }
                ),
              ),
            ],
          ),
        ),

        /// User Name
        Consumer(
            builder: (_, ref, _) {
              final userName= ref.watch(authProvider).user!.name;
            return Text(userName,style:Theme.of(context).textTheme.headlineSmall);
          }
        ),

        Divider(color: AppColors.secondaryTextColor.withValues(alpha: 0.4),)
      ],
    );
  }
}
