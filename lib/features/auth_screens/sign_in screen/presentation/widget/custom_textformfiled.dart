import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';


class CustomTextformfiled extends StatelessWidget {
  final String text;
  final String hintext;
  final String icons;
  final bool? isobscure;
  final bool? isVisible;
  final String? toogleIcon;
  final void Function()? onTapToggle;
  final TextEditingController controller;
  const CustomTextformfiled({super.key,
  required this.text,
  required this.icons,
  required this.hintext,
  required this.controller,
   this.isobscure ,
   this.isVisible,
   this.toogleIcon,
   this.onTapToggle
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
        padding:  EdgeInsets.only(left: 19.w, right: 19.w, top: 13.h, bottom: 13.h),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Color(0xff777980),
              ),
              ),
            ),
            SizedBox(height: 2.h,),
            Expanded(
              child: TextFormField(
                style: Theme.of(context).textTheme.bodyMedium,
                obscureText: isobscure ?? false,
                controller: controller,
                decoration: InputDecoration(
               hintText: hintext,

                  suffixIcon: GestureDetector(
                    onTap: onTapToggle,
                    child: Padding(
                      padding:  EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 5),
                      child: isVisible == true? SvgPicture.asset(toogleIcon!): SvgPicture.asset(icons),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
