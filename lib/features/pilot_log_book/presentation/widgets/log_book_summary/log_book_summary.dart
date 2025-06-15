import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';

class LogBookSummary extends StatelessWidget {
  const LogBookSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1))
      ),
      child: GridView.builder(
        itemCount: 8,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18.h,
          crossAxisSpacing: 18.w
        ),
        itemBuilder: (_, index){
          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                width: 139.w,
                height: 122.h,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2
                  ),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.2),
                      offset: Offset(0, 4),
                      spreadRadius: 2.r,
                      blurRadius: 8.r,
                    )
                  ]
                  //image: DecorationImage( image: DecoratedI 'assets/log_book_background.png',)
                ),
              ),
            
            ],
          );
        },
      ),
    );
  }
}
