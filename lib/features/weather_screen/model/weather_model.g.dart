// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  name: json['name'] as String,
  isFavorite: json['isFavorite'] as bool? ?? false,
  code: json['code'] as String,
  time: json['time'] as String,
  flightRules: json['flightRules'] as String,
  temperature: json['temperature'] as String,
  dewPoint: json['dewPoint'] as String,
  visibility: json['visibility'] as String,
  wind: json['wind'] as String,
  clouds: json['clouds'] as String,
  rawMetar: json['rawMetar'] as String,
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'isFavorite': instance.isFavorite,
      'code': instance.code,
      'time': instance.time,
      'flightRules': instance.flightRules,
      'temperature': instance.temperature,
      'dewPoint': instance.dewPoint,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'clouds': instance.clouds,
      'rawMetar': instance.rawMetar,
    };
