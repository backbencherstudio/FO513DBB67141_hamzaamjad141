import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/features/pilot_log_book/riverpod/log_book_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logBookProvider = StateNotifierProvider<LogBookNotifier, LogBookState>((ref)=>LogBookNotifier());

class LogBookNotifier extends StateNotifier<LogBookState>{
  LogBookNotifier() : super(LogBookState());

   final List<Map<String, dynamic>> userLogBookSummaryList = const [
    {
      "title": "Total Flights",
      "quantity":16,
      "iconPath":AppIcons.airplane
    },
     {
       "title": "Total Hours",
       "quantity":56,
       "iconPath":AppIcons.clockRectangle
     },
     {
       "title": "PIC Hours",
       "quantity":22,
       "iconPath":AppIcons.picHours
     },
     {
       "title": "Day Hours",
       "quantity":33,
       "iconPath":AppIcons.sun
     },
     {
       "title": "Night Hours",
       "quantity":10,
       "iconPath":AppIcons.moon
     },
     {
       "title": "Total Take Offs",
       "quantity":20,
       "iconPath":AppIcons.airplaneTakeOffFill
     },
     {
       "title": "Total Landings",
       "quantity":16,
       "iconPath":AppIcons.airplaneLanding
     },
     {
       "title": "IFR Hours",
       "quantity":10,
       "iconPath":AppIcons.ifrHours
     },
  ];

}