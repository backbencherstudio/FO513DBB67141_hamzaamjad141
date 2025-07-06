import 'package:aviation_app/features/pilot_log_book/riverpod/log_book_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../log_entry_screen/widgets/flight_log_card.dart';

class FlightLogList extends StatelessWidget{
  const FlightLogList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final flightLogRequestList = ref.watch(logBookProvider).logRequestList;
        return flightLogRequestList != null && flightLogRequestList.isNotEmpty ?

        ListView.builder(
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: flightLogRequestList.length,
            itemBuilder: (_, index){
            final flightLogRequest = flightLogRequestList[index];
            return FlightLogCard(logRequestModel: flightLogRequest,);
            }
        )
        :
          SizedBox.shrink()
        ;
      }
    );
  }
}