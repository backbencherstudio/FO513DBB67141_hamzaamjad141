
import 'package:json_annotation/json_annotation.dart';
part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel{
  final Altimeter? altimeter;
  final List<Clouds>? clouds;
  final num? density_altitude;
  final DewPoint? dewpoint;
  final String? flight_rules;
  final Map<String, dynamic>? meta;
  final List? other;
  final num? pressure_altitude;
  final String? raw;
  final num? relative_humidity;
  final String? remarks;
  final RemarksInfo? remarks_info;
  final List? runway_visibility;
  final String? sanitized;
  final String? station;
  final Temperature? temperature;
  final Time? time;
  final Units? units;
  final Visibility? visibility;
  final WindDirection? wind_direction;
  final dynamic wind_gust;
  final WindSpeed? wind_speed;
  final List? wind_variable_direction;
  final List? wx_codes;
  WeatherModel({
    this.altimeter,
    this.clouds,
    this.density_altitude,
    this.dewpoint,
    this.flight_rules,
    this.meta,
    this.other,
    this.pressure_altitude,
    this.raw,
    this.relative_humidity,
    this.remarks,
    this.remarks_info,
    this.runway_visibility,
    this.sanitized,
    this.station,
    this.temperature,
    this.time,
    this.units,
    this.visibility,
    this.wind_direction,
    this.wind_gust,
    this.wind_speed,
    this.wind_variable_direction,
    this.wx_codes,

});
  factory WeatherModel.fromJson(Map<String,dynamic> json) => _$WeatherModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

}

@JsonSerializable()
class Altimeter{
  final String? repr;
  final String? spoken;
  final num? value;
  Altimeter({
    this.repr,
    this.spoken,
    this.value,
});
  factory Altimeter.fromJson(Map<String,dynamic> json)=> _$AltimeterFromJson(json);
  Map<String, dynamic> toJson()=> _$AltimeterToJson(this);
}

@JsonSerializable()
class Clouds{
  final num? altitude;
  final dynamic modifier;
  final String? repr;
  final String? type;
  Clouds({this.altitude, this.modifier, this.repr,this.type});
  factory Clouds.fromJson(Map<String,dynamic> json)=> _$CloudsFromJson(json);
  Map<String, dynamic> toJson()=> _$CloudsToJson(this);
}

@JsonSerializable()
class DewPoint{
  final String? repr;
  final String? spoken;
  final num? value;
  DewPoint({this.repr, this.spoken, this.value});
  factory DewPoint.fromJson(Map<String,dynamic> json)=> _$DewPointFromJson(json);
  Map<String, dynamic> toJson()=> _$DewPointToJson(this);

}

// @JsonSerializable()
// class Meta{
//   final String? cache-timestamp;
//   final String? stations_updated;
//   final String? timestamp;
//   Meta({this.cache-timestamp, this.stations_updated, this.timestamp});
//   factory Meta.fromJson(Map<String,dynamic> json)=> _$MetaFromJson(json);
//   Map<String, dynamic> toJson()=> _$MetaToJson(this);
// }

@JsonSerializable()
class RemarksInfo{
  final List<Codes>? codes;
  final DewPointDecimal? dewpoint_decimal;
  final dynamic maximum_temperature_24;
  final dynamic maximum_temperature_6;
  final dynamic minimum_temperature_24;
  final dynamic minimum_temperature_6;
  final dynamic precip_24_hours;
  final PreCip36Hours? precip_36_hours;
  final dynamic precip_hourly;
  final dynamic pressure_tendency;
  final SeaLevelPressure? sea_level_pressure;
  final dynamic snowDepth;
  final dynamic sunshine_minutes;
  final TemperatureDecimal? temperature_decimal;
  RemarksInfo({
    this.codes,
    this.dewpoint_decimal,
    this.maximum_temperature_24,
    this.maximum_temperature_6,
    this.minimum_temperature_24,
    this.minimum_temperature_6,
    this.precip_24_hours,
    this.precip_36_hours,
    this.precip_hourly,
    this.pressure_tendency,
    this.sea_level_pressure,
    this.snowDepth,
    this.sunshine_minutes,
    this.temperature_decimal,
  });
  factory RemarksInfo.fromJson(Map<String,dynamic> json)=> _$RemarksInfoFromJson(json);
  Map<String, dynamic> toJson()=> _$RemarksInfoToJson(this);
}

@JsonSerializable()
class Codes{
  final String? repr;
  final String? value;
  Codes({this.repr, this.value});
  factory Codes.fromJson(Map<String,dynamic> json)=> _$CodesFromJson(json);
  Map<String, dynamic> toJson()=> _$CodesToJson(this);
}

@JsonSerializable()
class DewPointDecimal{
  final String? repr;
  final String? spoken;
  final num? value;
  DewPointDecimal({this.repr, this.spoken, this.value});
  factory DewPointDecimal.fromJson(Map<String,dynamic> json)=> _$DewPointDecimalFromJson(json);
  Map<String, dynamic> toJson()=> _$DewPointDecimalToJson(this);
}

@JsonSerializable()
class PreCip36Hours{
  final String? repr;
  final String? spoken;
  final num? value;
  PreCip36Hours({this.repr, this.spoken, this.value});
  factory PreCip36Hours.fromJson(Map<String,dynamic> json)=> _$PreCip36HoursFromJson(json);
}

// @JsonSerializable()
// class PressureTendency{
//   final num? change;
//   final String? repr;
//   final String? tendency;
//   PressureTendency({this.change, this.repr, this.tendency});
//   factory PressureTendency.fromJson(Map<String,dynamic> json)=> _$PressureTendencyFromJson(json);
//   Map<String, dynamic> toJson()=> _$PressureTendencyToJson(this);
// }

@JsonSerializable()
class SeaLevelPressure{
  final String? repr;
  final String? spoken;
  final num? value;
  SeaLevelPressure({this.repr, this.spoken, this.value});
  factory SeaLevelPressure.fromJson(Map<String,dynamic> json)=> _$SeaLevelPressureFromJson(json);
  Map<String, dynamic> toJson()=> _$SeaLevelPressureToJson(this);
}

@JsonSerializable()
class TemperatureDecimal{
  final String? repr;
  final String? spoken;
  final num? value;
  TemperatureDecimal({this.repr, this.spoken, this.value});
  factory TemperatureDecimal.fromJson(Map<String,dynamic> json)=> _$TemperatureDecimalFromJson(json);
  Map<String, dynamic> toJson()=> _$TemperatureDecimalToJson(this);
}

@JsonSerializable()
class Temperature{
  final String? repr;
  final String? spoken;
  final num? value;
  Temperature({this.repr, this.spoken, this.value});
  factory Temperature.fromJson(Map<String,dynamic> json)=> _$TemperatureFromJson(json);
  Map<String, dynamic> toJson()=> _$TemperatureToJson(this);
}

@JsonSerializable()
class Time{
  final String? dt;
  final String? repr;
  Time({this.dt, this.repr});
  factory Time.fromJson(Map<String,dynamic> json)=> _$TimeFromJson(json);
  Map<String, dynamic> toJson()=> _$TimeToJson(this);
}

@JsonSerializable()
class Units{
  final String? accumulation;
  final String? altimeter;
  final String? altitude;
  final String? temperature;
  final String? visibility;
  final String? wind_speed;
  Units({this.accumulation, this.altimeter, this.altitude, this.temperature,this.visibility, this.wind_speed});
  factory Units.fromJson(Map<String,dynamic> json)=> _$UnitsFromJson(json);
  Map<String, dynamic> toJson()=> _$UnitsToJson(this);
}

@JsonSerializable()
class Visibility{
  final String? repr;
  final String? spoken;
  final num? value;
  Visibility({this.repr, this.spoken, this.value});
  factory Visibility.fromJson(Map<String,dynamic> json)=> _$VisibilityFromJson(json);
  Map<String, dynamic> toJson()=> _$VisibilityToJson(this);
}

@JsonSerializable()
class WindDirection{
  final String? repr;
  final String? spoken;
  final num? value;
  WindDirection({this.repr, this.spoken, this.value});
  factory WindDirection.fromJson(Map<String,dynamic> json)=> _$WindDirectionFromJson(json);
  Map<String, dynamic> toJson()=> _$WindDirectionToJson(this);
}

@JsonSerializable()
class WindSpeed{
  final String? repr;
  final String? spoken;
  final num? value;
  WindSpeed({this.repr, this.spoken, this.value});
  factory WindSpeed.fromJson(Map<String,dynamic> json)=> _$WindSpeedFromJson(json);
  Map<String, dynamic> toJson()=> _$WindSpeedToJson(this);
}