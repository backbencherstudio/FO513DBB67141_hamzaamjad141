import 'package:json_annotation/json_annotation.dart';

part 'log_book_summary_model.g.dart';

@JsonSerializable()
class LogBookSummaryModel {
  final num totalFlights;
  final num totalHours;
  final num picHours;
  final num dayHours;
  final num nightHours;
  final num ifrHours;
  final num totalTakeoffs;
  final num totalLandings;
  final num crossCountry;

  LogBookSummaryModel({
    this.totalFlights = 0,
    this.totalHours = 0,
     this.picHours = 0,
     this.dayHours = 0,
     this.nightHours = 0,
     this.ifrHours = 0,
     this.totalTakeoffs = 0,
     this.totalLandings = 0,
     this.crossCountry = 0,
  });
  factory LogBookSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$LogBookSummaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$LogBookSummaryModelToJson(this);
}
