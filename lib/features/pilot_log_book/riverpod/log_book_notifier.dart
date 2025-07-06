import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/pilot_log_book/models/instructor_model.dart';
import 'package:aviation_app/features/pilot_log_book/riverpod/log_book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

final logBookProvider = StateNotifierProvider<LogBookNotifier, LogBookState>((
  ref,
) {
  final userToken = ref.watch(authProvider).userToken ?? "";
  return LogBookNotifier(userToken);
});

class LogBookNotifier extends StateNotifier<LogBookState> {
  final String userToken;
  LogBookNotifier(this.userToken) : super(LogBookState()) {
    getDefaultInstructor();
  }

  final List<Map<String, dynamic>> userLogBookSummaryList = const [
    {"title": "Total Flights", "quantity": 16, "iconPath": AppIcons.airplane},
    {
      "title": "Total Hours",
      "quantity": 56,
      "iconPath": AppIcons.clockRectangle,
    },
    {"title": "PIC Hours", "quantity": 22, "iconPath": AppIcons.picHours},
    {"title": "Day Hours", "quantity": 33, "iconPath": AppIcons.sun},
    {"title": "Night Hours", "quantity": 10, "iconPath": AppIcons.moon},
    {
      "title": "Total Take Offs",
      "quantity": 20,
      "iconPath": AppIcons.airplaneTakeOffFill,
    },
    {
      "title": "Total Landings",
      "quantity": 16,
      "iconPath": AppIcons.airplaneLanding,
    },
    {"title": "IFR Hours", "quantity": 10, "iconPath": AppIcons.ifrHours},
  ];

  /// set default instructor
  Future<bool?> setDefaultInstructor({required String email}) async {
    try {
      state = state.copyWith(instructorButtonLoading: true);

      final instructorFindResponse = await ApiServices.instance.getData(
        endPoint: "${ApiEndPoints.findInstructor}$email",
        headers: {"Authorization": userToken},
      );
      if (instructorFindResponse["success"] &&
          instructorFindResponse["data"].isNotEmpty) {
        final String instructorId = instructorFindResponse["data"][0]["id"];
        final instructorSetResponse = await ApiServices.instance.postData(
          endPoint: "${ApiEndPoints.setInstructor}$instructorId",
          body: {},
          headers: {"Authorization": userToken},
        );
        if (instructorSetResponse['success'] == true) {
          state = state.copyWith(instructorButtonLoading: false);
          Fluttertoast.showToast(
            msg: "Request send successfully",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          return true;
        }
      }

      Fluttertoast.showToast(
        msg: "Instructor not found",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      state = state.copyWith(instructorButtonLoading: false);
      return null;
    } catch (error) {
      state = state.copyWith(instructorButtonLoading: false);
      return null;
    }
  }

  Future<void> getDefaultInstructor() async {
    try {
      final response = await ApiServices.instance.getData(
        endPoint: ApiEndPoints.getInstructor,
        headers: {"Authorization": userToken},
      );
      if (response['success'] == true) {
        final InstructorModel instructor = InstructorModel.fromJson(
          response['data'],
        );
        state = state.copyWith(instructor: instructor);
      }
    } catch (error) {
      throw Exception('Failed to get default instructor: $error');
    }
  }
}
