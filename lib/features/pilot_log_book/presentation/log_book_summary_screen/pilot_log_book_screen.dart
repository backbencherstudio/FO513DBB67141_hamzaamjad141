import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:aviation_app/features/pilot_log_book/presentation/log_book_summary_screen/widgets/flight_log_list.dart';
import 'package:aviation_app/features/pilot_log_book/presentation/log_book_summary_screen/widgets/log_book_summary/log_book_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../log_entry_screen/widgets/flight_log_card.dart';

class PilotLogBookScreen extends StatelessWidget{
  const PilotLogBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(child: Padding(padding: AppPadding.screenHorizontal,
    child: SingleChildScrollView(
      child: Column(
        children: [
          EBookAppBar(textTheme: textTheme),
          SizedBox(height: 30.h,),
          Text("Pilot Logbook",style: textTheme.headlineSmall,),
          SizedBox(height: 30.h,),
          PrimaryButton(bodyText: "+ Add Flight Log", onTap: ()=> context.push(RouteName.logEntryScreen)),
          SizedBox(height: 15.h,),
          PrimaryButton(bodyText: "Set Default Instructor", onTap: ()=> context.push(RouteName.instructorEntryScreen),isSecondary: true,),
          SizedBox(height: 22.h,),
          LogBookSummary(),
          SizedBox(height: 22.h,),
          FlightLogList(),

          SizedBox(height: 145.h,)
        ],
      ),
    ),
    ));
  }
}