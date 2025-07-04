// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  altimeter: json['altimeter'] == null
      ? null
      : Altimeter.fromJson(json['altimeter'] as Map<String, dynamic>),
  clouds: (json['clouds'] as List<dynamic>?)
      ?.map((e) => Clouds.fromJson(e as Map<String, dynamic>))
      .toList(),
  density_altitude: json['density_altitude'] as num?,
  dewpoint: json['dewpoint'] == null
      ? null
      : DewPoint.fromJson(json['dewpoint'] as Map<String, dynamic>),
  flight_rules: json['flight_rules'] as String?,
  meta: json['meta'] as Map<String, dynamic>?,
  other: json['other'] as List<dynamic>?,
  pressure_altitude: json['pressure_altitude'] as num?,
  raw: json['raw'] as String?,
  relative_humidity: json['relative_humidity'] as num?,
  remarks: json['remarks'] as String?,
  remarks_info: json['remarks_info'] == null
      ? null
      : RemarksInfo.fromJson(json['remarks_info'] as Map<String, dynamic>),
  runway_visibility: json['runway_visibility'] as List<dynamic>?,
  sanitized: json['sanitized'] as String?,
  station: json['station'] as String?,
  temperature: json['temperature'] == null
      ? null
      : Temperature.fromJson(json['temperature'] as Map<String, dynamic>),
  time: json['time'] == null
      ? null
      : Time.fromJson(json['time'] as Map<String, dynamic>),
  units: json['units'] == null
      ? null
      : Units.fromJson(json['units'] as Map<String, dynamic>),
  visibility: json['visibility'] == null
      ? null
      : Visibility.fromJson(json['visibility'] as Map<String, dynamic>),
  wind_direction: json['wind_direction'] == null
      ? null
      : WindDirection.fromJson(json['wind_direction'] as Map<String, dynamic>),
  wind_gust: json['wind_gust'],
  wind_speed: json['wind_speed'] == null
      ? null
      : WindSpeed.fromJson(json['wind_speed'] as Map<String, dynamic>),
  wind_variable_direction: json['wind_variable_direction'] as List<dynamic>?,
  wx_codes: json['wx_codes'] as List<dynamic>?,
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'altimeter': instance.altimeter,
      'clouds': instance.clouds,
      'density_altitude': instance.density_altitude,
      'dewpoint': instance.dewpoint,
      'flight_rules': instance.flight_rules,
      'meta': instance.meta,
      'other': instance.other,
      'pressure_altitude': instance.pressure_altitude,
      'raw': instance.raw,
      'relative_humidity': instance.relative_humidity,
      'remarks': instance.remarks,
      'remarks_info': instance.remarks_info,
      'runway_visibility': instance.runway_visibility,
      'sanitized': instance.sanitized,
      'station': instance.station,
      'temperature': instance.temperature,
      'time': instance.time,
      'units': instance.units,
      'visibility': instance.visibility,
      'wind_direction': instance.wind_direction,
      'wind_gust': instance.wind_gust,
      'wind_speed': instance.wind_speed,
      'wind_variable_direction': instance.wind_variable_direction,
      'wx_codes': instance.wx_codes,
    };

Altimeter _$AltimeterFromJson(Map<String, dynamic> json) => Altimeter(
  repr: json['repr'] as String?,
  spoken: json['spoken'] as String?,
  value: json['value'] as num?,
);

Map<String, dynamic> _$AltimeterToJson(Altimeter instance) => <String, dynamic>{
  'repr': instance.repr,
  'spoken': instance.spoken,
  'value': instance.value,
};

Clouds _$CloudsFromJson(Map<String, dynamic> json) => Clouds(
  altitude: json['altitude'] as num?,
  modifier: json['modifier'],
  repr: json['repr'] as String?,
  type: json['type'] as String?,
);

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
  'altitude': instance.altitude,
  'modifier': instance.modifier,
  'repr': instance.repr,
  'type': instance.type,
};

DewPoint _$DewPointFromJson(Map<String, dynamic> json) => DewPoint(
  repr: json['repr'] as String?,
  spoken: json['spoken'] as String?,
  value: json['value'] as num?,
);

Map<String, dynamic> _$DewPointToJson(DewPoint instance) => <String, dynamic>{
  'repr': instance.repr,
  'spoken': instance.spoken,
  'value': instance.value,
};

RemarksInfo _$RemarksInfoFromJson(Map<String, dynamic> json) => RemarksInfo(
  codes: (json['codes'] as List<dynamic>?)
      ?.map((e) => Codes.fromJson(e as Map<String, dynamic>))
      .toList(),
  dewpoint_decimal: json['dewpoint_decimal'] == null
      ? null
      : DewPointDecimal.fromJson(
          json['dewpoint_decimal'] as Map<String, dynamic>,
        ),
  maximum_temperature_24: json['maximum_temperature_24'],
  maximum_temperature_6: json['maximum_temperature_6'],
  minimum_temperature_24: json['minimum_temperature_24'],
  minimum_temperature_6: json['minimum_temperature_6'],
  precip_24_hours: json['precip_24_hours'],
  precip_36_hours: json['precip_36_hours'] == null
      ? null
      : PreCip36Hours.fromJson(json['precip_36_hours'] as Map<String, dynamic>),
  precip_hourly: json['precip_hourly'],
  pressure_tendency: json['pressure_tendency'],
  sea_level_pressure: json['sea_level_pressure'] == null
      ? null
      : SeaLevelPressure.fromJson(
          json['sea_level_pressure'] as Map<String, dynamic>,
        ),
  snowDepth: json['snowDepth'],
  sunshine_minutes: json['sunshine_minutes'],
  temperature_decimal: json['temperature_decimal'] == null
      ? null
      : TemperatureDecimal.fromJson(
          json['temperature_decimal'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RemarksInfoToJson(RemarksInfo instance) =>
    <String, dynamic>{
      'codes': instance.codes,
      'dewpoint_decimal': instance.dewpoint_decimal,
      'maximum_temperature_24': instance.maximum_temperature_24,
      'maximum_temperature_6': instance.maximum_temperature_6,
      'minimum_temperature_24': instance.minimum_temperature_24,
      'minimum_temperature_6': instance.minimum_temperature_6,
      'precip_24_hours': instance.precip_24_hours,
      'precip_36_hours': instance.precip_36_hours,
      'precip_hourly': instance.precip_hourly,
      'pressure_tendency': instance.pressure_tendency,
      'sea_level_pressure': instance.sea_level_pressure,
      'snowDepth': instance.snowDepth,
      'sunshine_minutes': instance.sunshine_minutes,
      'temperature_decimal': instance.temperature_decimal,
    };

Codes _$CodesFromJson(Map<String, dynamic> json) =>
    Codes(repr: json['repr'] as String?, value: json['value'] as String?);

Map<String, dynamic> _$CodesToJson(Codes instance) => <String, dynamic>{
  'repr': instance.repr,
  'value': instance.value,
};

DewPointDecimal _$DewPointDecimalFromJson(Map<String, dynamic> json) =>
    DewPointDecimal(
      repr: json['repr'] as String?,
      spoken: json['spoken'] as String?,
      value: json['value'] as num?,
    );

Map<String, dynamic> _$DewPointDecimalToJson(DewPointDecimal instance) =>
    <String, dynamic>{
      'repr': instance.repr,
      'spoken': instance.spoken,
      'value': instance.value,
    };

PreCip36Hours _$PreCip36HoursFromJson(Map<String, dynamic> json) =>
    PreCip36Hours(
      repr: json['repr'] as String?,
      spoken: json['spoken'] as String?,
      value: json['value'] as num?,
    );

Map<String, dynamic> _$PreCip36HoursToJson(PreCip36Hours instance) =>
    <String, dynamic>{
      'repr': instance.repr,
      'spoken': instance.spoken,
      'value': instance.value,
    };

SeaLevelPressure _$SeaLevelPressureFromJson(Map<String, dynamic> json) =>
    SeaLevelPressure(
      repr: json['repr'] as String?,
      spoken: json['spoken'] as String?,
      value: json['value'] as num?,
    );

Map<String, dynamic> _$SeaLevelPressureToJson(SeaLevelPressure instance) =>
    <String, dynamic>{
      'repr': instance.repr,
      'spoken': instance.spoken,
      'value': instance.value,
    };

TemperatureDecimal _$TemperatureDecimalFromJson(Map<String, dynamic> json) =>
    TemperatureDecimal(
      repr: json['repr'] as String?,
      spoken: json['spoken'] as String?,
      value: json['value'] as num?,
    );

Map<String, dynamic> _$TemperatureDecimalToJson(TemperatureDecimal instance) =>
    <String, dynamic>{
      'repr': instance.repr,
      'spoken': instance.spoken,
      'value': instance.value,
    };

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
  repr: json['repr'] as String?,
  spoken: json['spoken'] as String?,
  value: json['value'] as num?,
);

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'repr': instance.repr,
      'spoken': instance.spoken,
      'value': instance.value,
    };

Time _$TimeFromJson(Map<String, dynamic> json) =>
    Time(dt: json['dt'] as String?, repr: json['repr'] as String?);

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
  'dt': instance.dt,
  'repr': instance.repr,
};

Units _$UnitsFromJson(Map<String, dynamic> json) => Units(
  accumulation: json['accumulation'] as String?,
  altimeter: json['altimeter'] as String?,
  altitude: json['altitude'] as String?,
  temperature: json['temperature'] as String?,
  visibility: json['visibility'] as String?,
  wind_speed: json['wind_speed'] as String?,
);

Map<String, dynamic> _$UnitsToJson(Units instance) => <String, dynamic>{
  'accumulation': instance.accumulation,
  'altimeter': instance.altimeter,
  'altitude': instance.altitude,
  'temperature': instance.temperature,
  'visibility': instance.visibility,
  'wind_speed': instance.wind_speed,
};

Visibility _$VisibilityFromJson(Map<String, dynamic> json) => Visibility(
  repr: json['repr'] as String?,
  spoken: json['spoken'] as String?,
  value: json['value'] as num?,
);

Map<String, dynamic> _$VisibilityToJson(Visibility instance) =>
    <String, dynamic>{
      'repr': instance.repr,
      'spoken': instance.spoken,
      'value': instance.value,
    };

WindDirection _$WindDirectionFromJson(Map<String, dynamic> json) =>
    WindDirection(
      repr: json['repr'] as String?,
      spoken: json['spoken'] as String?,
      value: json['value'] as num?,
    );

Map<String, dynamic> _$WindDirectionToJson(WindDirection instance) =>
    <String, dynamic>{
      'repr': instance.repr,
      'spoken': instance.spoken,
      'value': instance.value,
    };

WindSpeed _$WindSpeedFromJson(Map<String, dynamic> json) => WindSpeed(
  repr: json['repr'] as String?,
  spoken: json['spoken'] as String?,
  value: json['value'] as num?,
);

Map<String, dynamic> _$WindSpeedToJson(WindSpeed instance) => <String, dynamic>{
  'repr': instance.repr,
  'spoken': instance.spoken,
  'value': instance.value,
};
