
import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel{
  final String code;
  final String time;
  final String flightRules;
  final String temperature;
  final String dewPoint;
  final String visibility;
  final String wind;
  final String clouds;
  final String rawMetar;
  WeatherModel({
    required this.code,
    required this.time,
    required this.flightRules,
    required this.temperature,
    required this.dewPoint,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.rawMetar,
});

  factory WeatherModel.fromJson(Map<String,dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

}