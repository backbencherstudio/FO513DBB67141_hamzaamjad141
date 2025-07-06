// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogRequestModel _$LogRequestModelFromJson(Map<String, dynamic> json) =>
    LogRequestModel(
      id: json['id'] as num,
      date: json['date'] as String,
      from: json['from'] as String,
      to: json['to'] as String,
      aircrafttype: json['aircrafttype'] as String,
      tailNumber: json['tailNumber'] as String,
      flightTime: json['flightTime'] as String,
      pictime: json['pictime'] as String,
      dualrcv: json['dualrcv'] as String,
      daytime: json['daytime'] as String,
      nightime: json['nightime'] as String,
      ifrtime: json['ifrtime'] as String,
      crossCountry: json['crossCountry'] as String,
      takeoffs: json['takeoffs'] as num,
      landings: json['landings'] as num,
      userId: json['userId'] as String,
      status: json['status'] as String,
      action: json['action'] as String,
      updatedAt: json['updatedAt'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$LogRequestModelToJson(LogRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'from': instance.from,
      'to': instance.to,
      'aircrafttype': instance.aircrafttype,
      'tailNumber': instance.tailNumber,
      'flightTime': instance.flightTime,
      'pictime': instance.pictime,
      'dualrcv': instance.dualrcv,
      'daytime': instance.daytime,
      'nightime': instance.nightime,
      'ifrtime': instance.ifrtime,
      'crossCountry': instance.crossCountry,
      'takeoffs': instance.takeoffs,
      'landings': instance.landings,
      'userId': instance.userId,
      'status': instance.status,
      'action': instance.action,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
    };
