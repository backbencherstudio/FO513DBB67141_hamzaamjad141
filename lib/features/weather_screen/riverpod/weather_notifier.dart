import 'package:aviation_app/features/weather_screen/data/dummy_weather_list.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/weather_model.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(),
);

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState()) {
    fetchWeather();
  }

  /// fetch initial weather list
  Future<void> fetchWeather() async {
    final weatherList = WeatherData.weatherList
        .map((weather) => WeatherModel.fromJson(weather))
        .toList();
    state = state.copyWith(weatherList: weatherList);
  }

  /// search weather by code
  Future<void> onGetWeather({required String searchCommand}) async {
    try {
      debugPrint("Searching...\n");
      final weatherList = state.weatherList ?? [];
      final searchedWeatherList = weatherList.where(
        (weather) => weather.code.toUpperCase() == searchCommand.toUpperCase(),
      );
      late final WeatherModel? searchedWeather;
      if (searchedWeatherList.isNotEmpty) {
        debugPrint("Successfully found weather.\n");
        searchedWeather = searchedWeatherList.first;
      }
      else{
        debugPrint("Could not found weather for $searchCommand.\n");
        searchedWeather = null;
      }

      state = state.copyWith(searchedWeather: searchedWeather,searchCommand: searchCommand);
    } catch (error) {
      throw Exception(
        'Exception while searching weather for $searchCommand. Error : $error',
      );
    }
  }

  /// on Tab change
  void onTabChange(int index) {
    state = state.copyWith(selectedTab: index);
  }
}
