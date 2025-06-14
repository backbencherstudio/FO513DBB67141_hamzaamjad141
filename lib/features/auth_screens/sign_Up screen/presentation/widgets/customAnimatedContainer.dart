import 'package:aviation_app/features/auth_screens/sign_Up%20screen/Riverpod/dropdown_Notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAnimatedContainer extends ConsumerWidget {
  final String text;
  final String hintext;
  final String icons;
  final bool? isobscure;
  final TextEditingController controller;
  final List<String> dropdownItems;

  const CustomAnimatedContainer({
    super.key,
    required this.text,
    required this.icons,
    required this.hintext,
    required this.controller,
    this.isobscure,
    required this.dropdownItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownState = ref.watch(dropdownProvider);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 327.w,
      height: dropdownState.isExpanded ? 320.h : 82.h, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Color(0xff161721),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 13.h),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Color(0xff777980),
                    ),
              ),
            ),
            SizedBox(height: 2.h),
            Flexible(
              child: TextFormField(
                obscureText: isobscure ?? false,
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintext,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      ref.read(dropdownProvider.notifier).toggleExpansion();
                    },
                    child: SvgPicture.asset(icons),
                  ),
                ),
              ),
            ),
            if (dropdownState.isExpanded)
              Container(
                padding: EdgeInsets.only(top: 3.h),
                child: Column(
                  children: dropdownItems.map((item) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(dropdownProvider.notifier).selectItem(item);
                        controller.text = item;
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6.h), 
                        width: double.infinity,
                        child: Text(
                          item,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
