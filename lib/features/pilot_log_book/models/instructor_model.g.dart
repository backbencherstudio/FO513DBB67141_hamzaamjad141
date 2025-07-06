// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructorModel _$InstructorModelFromJson(Map<String, dynamic> json) =>
    InstructorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$InstructorModelToJson(InstructorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };
