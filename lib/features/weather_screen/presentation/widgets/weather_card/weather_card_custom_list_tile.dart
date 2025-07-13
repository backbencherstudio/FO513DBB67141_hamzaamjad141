import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


Widget customListTile({
  required TextTheme textTheme,
  required String svgIconPath,
  required String title,
  required String body,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 5.w,
    children: [
      SvgPicture.asset(svgIconPath, width: 16.w, height: 16.h),
      Expanded(
        child: RichText(
          text: TextSpan(
            text: title,
            style: textTheme.bodySmall?.copyWith(color: Colors.white),
            children: [
              TextSpan(
                text: ' $body',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}