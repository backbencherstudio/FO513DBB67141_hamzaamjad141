import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EbookPlay extends StatelessWidget {
  const EbookPlay({super.key, required String ebookId});

  @override
  Widget build(BuildContext context) {
    return CreateScreen(
      child: SafeArea(
        child: Padding(
          padding: AppPadding.screenHorizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonWidget.secondaryButton(
                    child: SvgPicture.asset(AppIcons.backIcon),
                  ),
                  CommonWidget.secondaryButton(
                    child: SvgPicture.asset(
                     'assets/icons/save_icon.svg',
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),

                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
