import 'package:aviation_app/core/constant/icons.dart';
import 'package:aviation_app/core/routes/route_name.dart';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/pilot_log_book/models/instructor_model.dart';
import 'package:aviation_app/features/pilot_log_book/models/log_request_model.dart';
import 'package:aviation_app/features/pilot_log_book/riverpod/log_book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'log_book_summary_provider.dart';

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
    getLogsList();
  }

  Future<void> onRefresh({required WidgetRef ref}) async {
    try {
      await     getDefaultInstructor();
      await  getLogsList();
      ref.refresh(logBookSummaryProvider);
      debugPrint("\nrefresh complete\n");
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to refresh",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw Exception('Failed to refresh : $error');
    }
  }

  /// set default instructor
  Future<bool?> setDefaultInstructor({required String email, required String name, required String phone}) async {
    try {
      state = state.copyWith(instructorButtonLoading: true);

      final instructorFindResponse = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.createInstructor,
        headers: {"Authorization": userToken,
        "Content-Type" :"application/json"
        },
        body: {
          "name" : name,
          "email" : email,
          "phone" : phone,
        }
      );
      if (instructorFindResponse["success"]) {
        final String instructorId = instructorFindResponse["data"]["id"];
        debugPrint("\ninstructor id : $instructorId\n");
        final instructorSetResponse = await ApiServices.instance.postData(
          endPoint: "${ApiEndPoints.setInstructor}$instructorId",
          body: {},
          headers: {"Authorization": userToken,
            "Content-Type" :"application/json"
          },
        );
        if (instructorSetResponse['success'] == true) {
          await getDefaultInstructor();
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
      Fluttertoast.showToast(
        msg: "Instructor save failed",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      debugPrint("\nError while saving instructor : $error\n");
      state = state.copyWith(instructorButtonLoading: false);
      return null;
    }
  }

  /// Get default instructor
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

  /// add log book
  Future<bool?> addLogBook({
    required DateTime date,
    required String from,
    required String to,
    required String aircrafttype,
    required String tailNumber,
    required num flightTime,
    required num pictime,
    required String dualrcv,
    required num daytime,
    required num nightime,
    required num ifrtime,
    required num crossCountry,
    required num takeoffs,
    required num landings,
    required WidgetRef ref, // Add ref here to refresh the provider
  }) async {
    try {
      String formattedDate = date.toUtc().toIso8601String(); // "2025-07-12"

      debugPrint("\nformated date : $formattedDate\n");
      state = state.copyWith(addLogButtonLoading: true);
      final body = {
        "date": formattedDate,
        "from": from,
        "to": to,
        "aircrafttype": aircrafttype,
        "tailNumber": tailNumber,
        "flightTime": flightTime,
        "pictime": pictime,
        "dualrcv": dualrcv,
        "daytime": daytime,
        "nightime": nightime,
        "ifrtime": ifrtime,
        "crossCountry": crossCountry,
        "takeoffs": takeoffs,
        "landings": landings,
      };
      debugPrint("\nadd log body : $body\n");
      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.addLogBook,
        body: body,
        headers: {
          "Authorization": userToken,
          'Content-type': "Application/json",
        },
      );
      state = state.copyWith(addLogButtonLoading: false);
      if (response['success'] == true) {
        // After successful API call, refresh the logBookSummaryProvider
        ref.refresh(logBookSummaryProvider); // Trigger a refresh
        Fluttertoast.showToast(
          msg: response['message'],
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        getLogsList();
        return true;
      }
      Fluttertoast.showToast(
        msg: response['message'],
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      return false;
    } catch (error) {
      state = state.copyWith(addLogButtonLoading: false);
      throw Exception('Failed to add log book: $error');
      return null;
    }
  }

  /// get log request list with pagination
  Future<void> getLogsList({int page = 1, int limit = 10, bool loadMore = false}) async {
    try {
      if (loadMore) {
        state = state.copyWith(isLoadingMore: true);
      } else {
        state = state.copyWith(isLoading: true, currentPage: 1, hasMoreData: true);
      }

      final response = await ApiServices.instance.getData(
        endPoint: ApiEndPoints.getLogRequestListWithPagination(page: page, limit: limit),
        headers: {"Authorization": userToken},
      );
      
      if (response['success'] == true) {
        final List<LogRequestModel> newLogRequestList =
            (response['data']['logs'] as List<dynamic>)
                .map((item) => LogRequestModel.fromJson(item))
                .toList();
        
        List<LogRequestModel> updatedList;
        if (loadMore && state.logRequestList != null) {
          // Append new data to existing list
          updatedList = [...state.logRequestList!, ...newLogRequestList];
        } else {
          // Replace with new data (first load or refresh)
          updatedList = newLogRequestList;
        }
        
        // Check if there's more data available
        final hasMoreData = newLogRequestList.length == limit;
        
        state = state.copyWith(
          logRequestList: updatedList,
          currentPage: page,
          hasMoreData: hasMoreData,
          isLoading: false,
          isLoadingMore: false,
        );
      } else {
        debugPrint("\nLog request list is empty\n");
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          hasMoreData: false,
        );
      }
    } catch (error) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
      );
      throw Exception('Failed to get log request list: $error');
    }
  }

  /// Load more log requests
  Future<void> loadMoreLogs() async {
    if (state.hasMoreData && !state.isLoadingMore) {
      await getLogsList(page: state.currentPage + 1, loadMore: true);
    }
  }

  Future<void> deleteLogRequest({
    required String id,
    required int index,
  }) async {
    try {
      state = state.copyWith(deleteButtonLoadingButtonIndex: index);
      final response = await ApiServices.instance.deleteData(
        endPoint: "${ApiEndPoints.deleteLogRequest}$id",
        headers: {"Authorization": userToken},
      );
      if (response['success'] == true) {
        Fluttertoast.showToast(
          msg: response['message'],
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        final logRequestList = state.logRequestList;
        logRequestList!.removeWhere((element) => element.id == id);
        state = state.copyWith(
          logRequestList: logRequestList,
          deleteButtonLoadingButtonIndex: -1,
        );
      } else {
        Fluttertoast.showToast(
          msg: response['message'],
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        state = state.copyWith(deleteButtonLoadingButtonIndex: -1);
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to delete",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      state = state.copyWith(deleteButtonLoadingButtonIndex: -1);
      throw Exception('Failed to delete log request: $error');
    }
  }
}
