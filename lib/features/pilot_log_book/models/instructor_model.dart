
import 'package:json_annotation/json_annotation.dart';

part 'instructor_model.g.dart';

@JsonSerializable()
class InstructorModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  InstructorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });
  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorModelFromJson(json);
  Map<String, dynamic> toJson() => _$InstructorModelToJson(this);
}
