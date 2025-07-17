// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_book_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogBookSummaryModel _$LogBookSummaryModelFromJson(Map<String, dynamic> json) =>
    LogBookSummaryModel(
      totalFlights: json['totalFlights'] as num? ?? 0,
      totalHours: json['totalHours'] as num? ?? 0,
      picHours: json['picHours'] as num? ?? 0,
      dayHours: json['dayHours'] as num? ?? 0,
      nightHours: json['nightHours'] as num? ?? 0,
      ifrHours: json['ifrHours'] as num? ?? 0,
      totalTakeoffs: json['totalTakeoffs'] as num? ?? 0,
      totalLandings: json['totalLandings'] as num? ?? 0,
      crossCountry: json['crossCountry'] as num? ?? 0,
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
