import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/common_widget/primary_button/primary_button.dart';

Future<void> onLogDelete({required BuildContext context, required Function onDelete }) async {
  await showDialog(
    context: context,
    useSafeArea: true,
    // isScrollControlled: true,
    // backgroundColor: Colors.transparent,
    builder: (_) {
      final textTheme = Theme.of(context).textTheme;
      return Dialog(
        child: IntrinsicHeight(
          child: Container(
            width: double.infinity,
            //  height: 300.h,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              spacing: 20.h,
              children: [
                Text(
                  "Are You Sure, you want to delete this log?",
                  style: textTheme.titleSmall?.copyWith(
                    //   fontWeight: FontWeight.w700,
                    color: Color(0xff1D1F2C),
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        bodyText: "Cancel",
                        backgroundColor: Colors.white,
                        onTap: () => context.pop(),
                        isSecondary: true,
                        textStyle: textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: PrimaryButton(
                        bodyText: "Delete",
                        onTap: () async {
                          context.pop();
                          await onDelete();
                        },
                        backgroundColor: Colors.red,
                        textStyle: textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}