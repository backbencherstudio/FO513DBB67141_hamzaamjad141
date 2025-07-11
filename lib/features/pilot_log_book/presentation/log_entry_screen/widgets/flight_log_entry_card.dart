import 'package:aviation_app/core/theme/theme_extension/app_colors.dart';
import 'package:aviation_app/core/utils/common_widget/primary_button/primary_button.dart';
import 'package:aviation_app/features/pilot_log_book/riverpod/log_book_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'flight_log_custom_text_form_field.dart';

class FlightLogEntryCard extends StatefulWidget {
  const FlightLogEntryCard({super.key});

  @override
  State<FlightLogEntryCard> createState() => _FlightLogEntryCardState();
}

class _FlightLogEntryCardState extends State<FlightLogEntryCard> {
  DateTime dateTime = DateTime.now();
  late final TextEditingController dateEditingController;
  late final TextEditingController fromEditingController;
  late final TextEditingController toEditingController;
  late final TextEditingController aircraftTypeEditingController;
  late final TextEditingController tailNumberEditingController;
  late final TextEditingController flightTimeEditingController;
  late final TextEditingController picTimeEditingController;
  late final TextEditingController dualReceivedEditingController;
  late final TextEditingController dayTimeEditingController;
  late final TextEditingController nightTimeEditingController;
  late final TextEditingController ifrTimeEditingController;
  late final TextEditingController crossCountryEditingController;
  late final TextEditingController takeOffsEditingController;
  late final TextEditingController landingsEditingController;

  @override
  void initState() {
    dateEditingController = TextEditingController();
    fromEditingController = TextEditingController();
    toEditingController = TextEditingController();
    aircraftTypeEditingController = TextEditingController();
    tailNumberEditingController = TextEditingController();
    flightTimeEditingController = TextEditingController();
    picTimeEditingController = TextEditingController();
    dualReceivedEditingController = TextEditingController();
    dayTimeEditingController = TextEditingController();
    nightTimeEditingController = TextEditingController();
    ifrTimeEditingController = TextEditingController();
    crossCountryEditingController = TextEditingController();
    takeOffsEditingController = TextEditingController();
    landingsEditingController = TextEditingController();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: [
              Text("Add Flight Log", style: textTheme.titleMedium),
              Consumer(
                builder: (_, ref, _) {
                  return FlightLogCustomTextField(
                    enabled: false,
                    onTap: () async {
                      final datePicker = await showDatePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 50),
                      );
                      if(datePicker!= null){
                        dateTime = datePicker;
                        dateEditingController.text = DateFormat('dd MMM, yyyy').format(datePicker);
                      }
                    },
                    controller: dateEditingController,
                    label: "Date",
                    hint: "mm/dd/yyyy",
                  );
                }
              ),
              FlightLogCustomTextField(
                controller: fromEditingController,
                label: "From",
                hint: "Enter your from",
              ),
              FlightLogCustomTextField(
                controller: toEditingController,
                label: "To",
                hint: "Enter your to",
              ),
              FlightLogCustomTextField(
                controller: aircraftTypeEditingController,
                label: "Aircraft Type",
                hint: "Enter your aircraft type",
              ),
              FlightLogCustomTextField(
                controller: tailNumberEditingController,
                label: "Tail Number",
                hint: "Enter your tail number",
              ),
              FlightLogCustomTextField(
                controller: flightTimeEditingController,
                label: "Flight Time (hrs)",
                hint: "Enter your flight time",
                keyboardType: TextInputType.number,
              ),
              FlightLogCustomTextField(
                controller: picTimeEditingController,
                label: "PIC Time",
                hint: "Enter your PIC time",
                keyboardType: TextInputType.number,
              ),
              FlightLogCustomTextField(
                controller: dualReceivedEditingController,
                label: "Dual Received",
                hint: "Enter your dual received",
              ),
              FlightLogCustomTextField(
                controller: dayTimeEditingController,
                label: "Day Time",
                hint: "Enter your day time",
                keyboardType: TextInputType.number,
              ),
              FlightLogCustomTextField(
                controller: nightTimeEditingController,
                label: "Night Time",
                hint: "Enter your night time",
                keyboardType: TextInputType.number,
              ),
              FlightLogCustomTextField(
                controller: ifrTimeEditingController,
                label: "IFR Time",
                hint: "Enter your IFR time",
                keyboardType: TextInputType.number,
              ),
              FlightLogCustomTextField(
                controller: crossCountryEditingController,
                label: "Cross Country",
                hint: "Enter your cross country",
                keyboardType: TextInputType.number,
              ),
              FlightLogCustomTextField(
                controller: takeOffsEditingController,
                label: "Take Offs",
                hint: "Enter your take offs",
                keyboardType: TextInputType.number,

              ),
              FlightLogCustomTextField(
                controller: landingsEditingController,
                label: "Landings",
                hint: "Enter your landings",
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        SizedBox(height: 18.h),
        Consumer(
          builder: (_, ref, _) {
            final isButtonLoading = ref
                .watch(logBookProvider)
                .addLogButtonLoading;
            return isButtonLoading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    bodyText: "Add Log",
                    onTap: () async {
                      debugPrint("\n date time : $dateTime\n");
                      final success = await ref
                          .read(logBookProvider.notifier)
                          .addLogBook(
                        date: dateTime,
                            from: fromEditingController.text,
                            to: toEditingController.text,
                            aircrafttype: aircraftTypeEditingController.text,
                            tailNumber: tailNumberEditingController.text,
                            flightTime: num.tryParse(flightTimeEditingController.text) ?? 0,
                            pictime: num.tryParse(picTimeEditingController.text) ?? 0 ,
                            dualrcv:  dualReceivedEditingController.text,
                            daytime:  num.tryParse(dayTimeEditingController.text) ?? 0 ,
                            nightime: num.tryParse(nightTimeEditingController.text) ?? 0  ,
                            ifrtime: num.tryParse(ifrTimeEditingController.text) ?? 0  ,
                            crossCountry: num.tryParse( crossCountryEditingController.text) ?? 0  ,
                            takeoffs:
                                num.tryParse(takeOffsEditingController.text) ??
                                0,
                            landings:
                                num.tryParse(landingsEditingController.text) ??
                                0,
                        ref: ref
                          );
                      if (success == true && context.mounted) {
                        context.pop();
                      }
                    },
                  );
          },
        ),
      ],
    );
  }
}
