import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../riverpod/log_book_notifier.dart';
import '../../../../riverpod/log_book_summary_provider.dart';
import '../../../../riverpod/log_summary_download_provider.dart';
import 'log_book_summary_card.dart';

class LogBookSummary extends StatelessWidget {
  const LogBookSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Consumer(
      builder: (_, ref, _) {
        final logBookSummary = ref.watch(logBookSummaryProvider);
        return logBookSummary.when(
          data: (summary) => Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                Text("Logbook Summary", style: textTheme.headlineSmall),
                SizedBox(height: 16.h),
                GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18.h,
                    crossAxisSpacing: 18.w,
                  ),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    LogBookSummaryCard(
                      title: "Total Flights",
                      quantity: summary.totalFlights,
                      svgIconPath: AppIcons.airplane,
                    ),
                    LogBookSummaryCard(
                      title: "Total Hours",
                      quantity: summary.totalHours,
                      svgIconPath: AppIcons.clockRectangle,
                    ),
                    LogBookSummaryCard(
                      title: "PIC Hours",
                      quantity: summary.picHours,
                      svgIconPath: AppIcons.picHours,
                    ),
                    LogBookSummaryCard(
                      title: "Day Hours",
                      quantity: summary.dayHours,
                      svgIconPath: AppIcons.sun,
                    ),
                    LogBookSummaryCard(
                      title: "Night Hours",
                      quantity: summary.nightHours,
                      svgIconPath: AppIcons.moon,
                    ),
                    LogBookSummaryCard(
                      title: "Total Take Offs",
                      quantity: summary.totalTakeoffs,
                      svgIconPath: AppIcons.airplaneTakeOffFill,
                    ),
                    LogBookSummaryCard(
                      title: "Total Landings",
                      quantity: summary.totalLandings,
                      svgIconPath: AppIcons.airplaneLanding,
                    ),
                    LogBookSummaryCard(
                      title: "IFR Hours",
                      quantity: summary.ifrHours,
                      svgIconPath: AppIcons.ifrHours,
                    ),
                  ],
                ),

                SizedBox(height: 18.h),
                IntrinsicHeight(
                  child: SizedBox(
                    width: double.infinity,
                    child: Consumer(
                      builder: (_, ref, _) {
                        final logBookSummary = ref.watch(
                          logBookSummaryProvider,
                        );
                        return logBookSummary.when(
                          data: (summary) => LogBookSummaryCard(
                            svgIconPath: AppIcons.global,
                            title: "Cross country",
                            quantity: 00,
                          ),
                          error: (error, stackTrace) => Container(
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              color: AppColors.error,
                            ),
                            child: const SizedBox.shrink(),
                          ),
                          loading: () => const SizedBox.shrink(),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                PrimaryButton(
                  onTap: () {
                     ref.read(logBookDownloadProvider).downloadLogBook(summary);
                  },
                  bodyText: "Download Logs CSV",
                ),
              ],
            ),
          ),
          error: (error, stackTrace) => Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              color: AppColors.error,
            ),
            child: Text("Error to fetch Logbook Summary"),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
