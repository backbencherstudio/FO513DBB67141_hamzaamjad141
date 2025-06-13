import 'package:aviation_app/core/constant/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrVector extends StatelessWidget {
  const OrVector({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(AppIcons.left),
        SizedBox(width: 16.w),
        Text("Or", style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: Color(0xff919EAB),
          fontWeight: FontWeight.w400,
        ),),
        SizedBox(width: 16.w),
        SvgPicture.asset(AppIcons.right),
      ],
    );
  }
}
