import 'package:aviation_app/features/auth_screens/sign_Up%20screen/Riverpod/dropdown_Notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAnimatedContainer extends ConsumerWidget {
  final String icons;
  final TextEditingController controller;
  final List<String> dropdownItems;

  const CustomAnimatedContainer({
    super.key,
    required this.icons,
    required this.controller,
    required this.dropdownItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownState = ref.watch(dropdownProvider);

    return AnimatedSize(
      duration: Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () {
          ref.read(dropdownProvider.notifier).toggleExpansion();
        },
        child: Container(

          width: 327.w,
         // height: dropdownState.isExpanded ? 320.h : 82.h,
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
                    "Current License",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Color(0xff777980),
                        ),
                  ),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                  enabled: false,
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: controller,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        ref.read(dropdownProvider.notifier).toggleExpansion();
                      },
                      child: dropdownState.isExpanded
                          ?
                      Icon(Icons.keyboard_arrow_up_outlined,size: 35.sp,)
                          :
                      Icon(Icons.keyboard_arrow_down_outlined,size: 35.sp,)
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
        ),
      ),
    );
  }
}
