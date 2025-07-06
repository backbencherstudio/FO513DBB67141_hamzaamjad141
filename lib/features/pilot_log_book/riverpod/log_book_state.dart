import '../models/instructor_model.dart';

class LogBookState {
  final bool instructorButtonLoading;
  final InstructorModel? instructor;
  LogBookState({this.instructorButtonLoading = false, this.instructor});
  LogBookState copyWith({bool? instructorButtonLoading, InstructorModel? instructor }) {
    return LogBookState(
      instructorButtonLoading:
          instructorButtonLoading ?? this.instructorButtonLoading,
      instructor: instructor ?? this.instructor
    );
  }
}
