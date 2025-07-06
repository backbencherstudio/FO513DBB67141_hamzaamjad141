import 'package:aviation_app/features/pilot_log_book/models/log_request_model.dart';

import '../models/instructor_model.dart';

class LogBookState {
  final bool instructorButtonLoading;
  final bool addLogButtonLoading;
  final InstructorModel? instructor;
  final List<LogRequestModel>? logRequestList;
  LogBookState({
    this.instructorButtonLoading = false,
    this.instructor,
    this.addLogButtonLoading = false,
    this.logRequestList,
  });
  LogBookState copyWith({
    bool? instructorButtonLoading,
    InstructorModel? instructor,
    bool? addLogButtonLoading,
    List<LogRequestModel>? logRequestList,
  }) {
    return LogBookState(
      instructorButtonLoading:
          instructorButtonLoading ?? this.instructorButtonLoading,
      instructor: instructor ?? this.instructor,
      addLogButtonLoading: addLogButtonLoading ?? this.addLogButtonLoading,
      logRequestList: logRequestList ?? this.logRequestList,
    );
  }
}
