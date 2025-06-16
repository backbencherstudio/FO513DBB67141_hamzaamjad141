import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/utils/common_widget/common_widget.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/pilot_log_book/presentation/log_entry_screen/widgets/flight_log_entry_card.dart';
import 'package:aviation_app/features/pilot_log_book/presentation/log_entry_screen/widgets/instructor_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LogEntryScreen extends StatelessWidget {
  const LogEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: ListView(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: CommonWidget.secondaryButton(
                  onTap: ()=>context.pop(),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            SizedBox(height: 18.h),
            InstructorInfoCard(),
            SizedBox(height: 18.h),
            FlightLogEntryCard(),

            SizedBox(height: 145.h,)
          ],
        ),
      ),
    );
  }
}
