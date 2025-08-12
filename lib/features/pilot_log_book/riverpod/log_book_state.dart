import 'package:aviation_app/features/pilot_log_book/models/log_request_model.dart';

import '../models/instructor_model.dart';

class LogBookState {
  final bool instructorButtonLoading;
  final bool addLogButtonLoading;
  final InstructorModel? instructor;
  final List<LogRequestModel>? logRequestList;
  final int? deleteButtonLoadingButtonIndex;
  final int currentPage;
  final bool isLoading;
  final bool hasMoreData;
  final bool isLoadingMore;
  
  LogBookState({
    this.instructorButtonLoading = false,
    this.instructor,
    this.addLogButtonLoading = false,
    this.logRequestList,
    this.deleteButtonLoadingButtonIndex,
    this.currentPage = 1,
    this.isLoading = false,
    this.hasMoreData = true,
    this.isLoadingMore = false,
  });
  LogBookState copyWith({
    bool? instructorButtonLoading,
    InstructorModel? instructor,
    bool? addLogButtonLoading,
    List<LogRequestModel>? logRequestList,
    int? deleteButtonLoadingButtonIndex,
    int? currentPage,
    bool? isLoading,
    bool? hasMoreData,
    bool? isLoadingMore,
  }) {
    return LogBookState(
      instructorButtonLoading:
          instructorButtonLoading ?? this.instructorButtonLoading,
      instructor: instructor ?? this.instructor,
      addLogButtonLoading: addLogButtonLoading ?? this.addLogButtonLoading,
      logRequestList: logRequestList ?? this.logRequestList,
      deleteButtonLoadingButtonIndex: deleteButtonLoadingButtonIndex ?? this.deleteButtonLoadingButtonIndex,
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
