import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/pilot_log_book/models/log_book_summary_model/log_book_summary_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logBookSummaryProvider = FutureProvider<LogBookSummaryModel>((ref) async {
  try {
    final userToken = ref.watch(authProvider).userToken ?? "";
    final headers = {"Authorization": userToken};
    final response = await ApiServices.instance.getData(
      endPoint: ApiEndPoints.logBookSummary,
      headers: headers,
    );
    if (response['success'] == true) {
      final data = response['data'];
      final logBookSummary = LogBookSummaryModel.fromJson(data);
      return logBookSummary;
    }
    return LogBookSummaryModel();
  } catch (error) {
    throw Exception('Failed to fetch log book summary');
  }
});


