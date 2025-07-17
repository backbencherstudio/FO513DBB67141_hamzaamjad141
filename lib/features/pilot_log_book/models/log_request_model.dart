import 'package:json_annotation/json_annotation.dart';

part 'log_request_model.g.dart';

@JsonSerializable()
class LogRequestModel {
  final String id;
  final String date;
  final String from;
  final String to;
  final String aircrafttype;
  final String tailNumber;
  final num flightTime;
  final num pictime;
  final String dualrcv;
  final num daytime;
  final num nightime;
  final num ifrtime;
  final num crossCountry;
  final num takeoffs;
  final num landings;
  final String userId;
  final String status;
  final String action;
  final String updatedAt;
  final String createdAt;
  LogRequestModel({
    required this.id,
    required this.date,
    required this.from,
    required this.to,
    required this.aircrafttype,
    required this.tailNumber,
    required this.flightTime,
    required this.pictime,
    required this.dualrcv,
    required this.daytime,
    required this.nightime,
    required this.ifrtime,
    required this.crossCountry,
    required this.takeoffs,
    required this.landings,
    required this.userId,
    required this.status,
    required this.action,
    required this.updatedAt,
    required this.createdAt,
  });
  factory LogRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LogRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$LogRequestModelToJson(this);
}
