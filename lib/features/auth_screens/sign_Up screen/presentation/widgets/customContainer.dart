import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Customcontainer extends StatelessWidget {
  final String text;
  final String img;
  const Customcontainer({super.key,
  required this.text,
  required this.img,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
       height: 56.h,
       width: 327.w,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xff100F1C)
       ),
       child: Padding(
         padding:  EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
         child: Row(
          children: [
            SvgPicture.asset(img),
            SizedBox(width:10.w),
            Text(text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: Color(0xffF9FAFB),
            ),
            )
          ],
         ),
       ),
    );
  }
}