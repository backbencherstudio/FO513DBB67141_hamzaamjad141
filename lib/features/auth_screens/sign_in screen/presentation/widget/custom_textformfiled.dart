import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class CustomTextformfiled extends StatelessWidget {
  final String text;
  final String icons;
  final TextEditingController controller;
  const CustomTextformfiled({super.key,
  required this.text,
  required this.icons,
  required this.controller
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327.w,
      height: 82.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xff161721),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 19.w,
          right: 19.w,
          top: 20.h,
          bottom: 20.h,
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: text,
            labelStyle: TextStyle(color: Colors.grey),
            suffixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: SvgPicture.asset(icons),
            ),
          ),
        ),
      ),
    );
  }
}
