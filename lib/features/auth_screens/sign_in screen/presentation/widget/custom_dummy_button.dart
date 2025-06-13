// ignore_for_file: must_be_immutable

import 'package:aviation_app/core/constant/images.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDummyButton extends StatelessWidget {
  void Function()? onTap;
  final String text;
   CustomDummyButton({super.key,
  required this.onTap,
  required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        
        children: [
          
          Padding(
            padding: AppPadding.screenHorizontal,
            child: Image.asset(AppImages.button),
          ),

          Positioned(
            top: 2.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(child: Text(text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: Color(0xffffffff)
            ),
            )),
          ),

      
      ]));
  }
}