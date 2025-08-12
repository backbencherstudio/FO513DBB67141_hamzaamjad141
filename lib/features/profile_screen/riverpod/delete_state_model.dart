class DeleteStateModel {
  String? message;
  String? success;
  bool? isLoading;
  DeleteStateModel({this.message, this.success, this.isLoading});

  DeleteStateModel copyWith({String? message, String? success, bool? isLoading}) {
    return DeleteStateModel(
      success: success ?? this.success,
      message: message ?? this.message,
      isLoading: isLoading?? this.isLoading,
    );
  }
}
