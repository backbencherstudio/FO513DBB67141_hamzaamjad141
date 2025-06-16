import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../riverpod/log_book_notifier.dart';
import 'log_book_summary_card.dart';

class LogBookSummary extends StatelessWidget {
  const LogBookSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1))
      ),
      child: Column(
        children: [
          Text("Logbook Summary",style: textTheme.headlineSmall,),
          SizedBox(height: 16.h,),
          Consumer(
            builder: (_, ref, _) {
              final logBookSummaryList = ref.read(logBookProvider.notifier).userLogBookSummaryList;
              return GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: logBookSummaryList.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18.h,
                  crossAxisSpacing: 18.w
                ),
                itemBuilder: (_, index){
                  final item = logBookSummaryList[index];
                  return  LogBookSummaryCard(
                      title: item["title"],
                      quantity: item["quantity"],
                      svgIconPath: item["iconPath"],
                    );
                },
              );
            }
          ),
          SizedBox(height: 18.h,),
          IntrinsicHeight(
            child: SizedBox(
              width: double.infinity,
              child: LogBookSummaryCard(
                  svgIconPath: AppIcons.global, title: "Cross country", quantity: 00),
            ),
          ),
          SizedBox(height: 18.h,),
          PrimaryButton(
            onTap: (){
              debugPrint("\nTuki 😉\n");
            },
            bodyText: "Download Logs CSV",
          )

        ],
      ),
    );
  }
}
