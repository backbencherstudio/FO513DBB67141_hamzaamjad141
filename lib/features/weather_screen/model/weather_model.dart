
import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel{
  final String name;
  bool isFavorite;
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
    required this.name,
    this.isFavorite = false,
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


  WeatherModel copyWith({
    String? name,
    bool? isFavorite,
    String? code,
    String? time,
    String? flightRules,
    String? temperature,
    String? dewPoint,
    String? visibility,
    String? wind,
    String? clouds,
    String? rawMetar,
  }) {
    return WeatherModel(
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      code: code ?? this.code,
      time: time ?? this.time,
      flightRules: flightRules ?? this.flightRules,
      temperature: temperature ?? this.temperature,
      dewPoint: dewPoint ?? this.dewPoint,
      visibility: visibility ?? this.visibility,
      wind: wind ?? this.wind,
      clouds: clouds ?? this.clouds,
      rawMetar: rawMetar ?? this.rawMetar,
    );
  }


}