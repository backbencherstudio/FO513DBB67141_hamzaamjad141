import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogBookSummaryCard extends StatelessWidget{
  final String svgIconPath;
  final String title;
  final int quantity;
  const LogBookSummaryCard({
    super.key,
    required this.svgIconPath,
    required this.title,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2
          ),),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.2),
              offset: Offset(-3, 5),
              spreadRadius: 2.r,
              blurRadius: 3.r,
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.h,
        children: [
          SvgPicture.asset(svgIconPath),
          Text(quantity.toString(),style: textTheme.titleMedium,),
          Expanded(child: Text(title.toString(),style: textTheme.labelMedium,overflow: TextOverflow.ellipsis,)),
        ],
      ),
    );
  }
}