import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constant/icons.dart';
import '../../../../core/theme/theme_extension/app_colors.dart';
import '../../../../core/utils/common_widget/common_widget.dart';



class EBookAppBar extends StatelessWidget {
  const EBookAppBar({super.key, required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.w,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            'https://i.pravatar.cc/150?img=12',
            height: 47.h,
            width: 47.h,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: textTheme.labelLarge!.copyWith(color: AppColors.primary),
            ),
            Text('Ronald Richards'),
          ],
        ),
        const Spacer(),
        CommonWidget.secondaryButton(child: SvgPicture.asset(AppIcons.love)),
      ],
    );
  }
}
