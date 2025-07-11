// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_book_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogBookSummaryModel _$LogBookSummaryModelFromJson(Map<String, dynamic> json) =>
    LogBookSummaryModel(
      totalFlights: json['totalFlights'] as num,
      totalHours: json['totalHours'] as num,
      picHours: json['picHours'] as num,
      dayHours: json['dayHours'] as num,
      nightHours: json['nightHours'] as num,
      ifrHours: json['ifrHours'] as num,
      totalTakeoffs: json['totalTakeoffs'] as num,
      totalLandings: json['totalLandings'] as num,
      crossCountry: json['crossCountry'] as num,
    );

Map<String, dynamic> _$LogBookSummaryModelToJson(
  LogBookSummaryModel instance,
) => <String, dynamic>{
  'totalFlights': instance.totalFlights,
  'totalHours': instance.totalHours,
  'picHours': instance.picHours,
  'dayHours': instance.dayHours,
  'nightHours': instance.nightHours,
  'ifrHours': instance.ifrHours,
  'totalTakeoffs': instance.totalTakeoffs,
  'totalLandings': instance.totalLandings,
  'crossCountry': instance.crossCountry,
};
