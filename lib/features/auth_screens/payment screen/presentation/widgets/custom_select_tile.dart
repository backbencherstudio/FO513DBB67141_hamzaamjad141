// ignore_for_file: deprecated_member_use
import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/features/auth_screens/payment%20screen/Riverpod/payment_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSelectTile extends StatelessWidget {
  final String title;
  final String discription;
  final String img;
  final bool isChecked;
  final void Function()? onTap;
  const CustomSelectTile({super.key,
  required this.title,
  required this.discription,
  required this.img,
  required this.isChecked,
  required this.onTap
  });

  @override
  Widget build(BuildContext context) {
     final style = Theme.of(context).textTheme;
    return Consumer(
      builder: (context,ref,_) {
    final selectedTitle = ref.watch(selectionProvider);
    final isChecked = selectedTitle == title;

        return GestureDetector(
        onTap: () {
          ref.read(selectionProvider.notifier).state = isChecked ? null : title;
        },
          child: Container(
            height: 96.h,
            width: 350.w,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Color(0xff23293D),
            border: Border.all(
            color:isChecked? AppColors.primary: Color(0xffffffff).withOpacity(0.10),
            width: 2.0)),
            child:Padding(
            padding:  EdgeInsets.all(12.0),
            child: Row(
            children: [
            Container(
            height: 44.h,
            width: 44.w,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Color(0xff23293D),
            border: Border.all(
            color: Color(0xffffffff).withOpacity(0.10),
            width: 2.0)),
            child: Padding(
            padding:  EdgeInsets.all(10.0),
            child: SvgPicture.asset(img),
            )),
            SizedBox(width:12.w),
            Flexible(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(title,
            style: style.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
            color: Color(0xffF9FAFB)
            ),
            ),
            SizedBox(height: 4.h,),
            Text(discription,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: style.labelMedium!.copyWith(
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xffA5A5AB)
            ))],)),
            Checkbox(
            shape: CircleBorder(),
            value: isChecked,  onChanged: (value) {
            ref.read(selectionProvider.notifier).state = value! ? title : null;
                
                 }) ],
              ),
            ) ,
          ),
        );
      }
    );
  }
}