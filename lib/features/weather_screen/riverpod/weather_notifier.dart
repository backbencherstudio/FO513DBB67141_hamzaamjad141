import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/features/weather_screen/data/dummy_weather_list.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/weather_model.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(),
);

class WeatherNotifier extends StateNotifier<WeatherState> {
  WeatherNotifier() : super(WeatherState());

  /// search weather by code
  Future<void> onGetWeather({required String searchCommand}) async {
    try {
      state = state.copyWith(searchButtonLoading: true,);
      final response = await ApiServices.instance.getData(
        endPoint: "${ApiEndPoints.getWeather}/${searchCommand.toUpperCase()}",
      );
      if (response['success']) {
        final WeatherModel weatherModel = WeatherModel.fromJson(
          response['data'],
        );
        state = state.copyWith(
          searchCommand: searchCommand,
          isWeatherFound: true,
          searchedWeather: weatherModel,
          searchButtonLoading: false,
        );
        debugPrint("\nweather : ${response['data']}\n");
      } else {
        state = state.clearWeather(searchCommand: searchCommand);
      }
    } catch (error) {
      state = state.clearWeather(searchCommand: searchCommand);
      throw Exception(
        'Exception while searching weather for $searchCommand. Error : $error',
      );
    }
  }

  /// on Tab change
  void onTabChange(int index) {
    state = state.copyWith(selectedTab: index);
  }

  Future<void> addToFavouriteWeather({required WeatherModel weather}) async {
    try{
      if(state.favouriteWeatherList.map((value)=> value.station == weather.station).toList().isEmpty){
        state = state.copyWith(favouriteWeatherList: [...state.favouriteWeatherList, weather]);
      }
      else{
      //  List<WeatherModel> newFavoriteList = state.favouriteWeatherList.remove((map)=>map.station ==weather.station);
      }

    }catch(e){
      throw Exception("Exception while adding to favourite : $e\n");
    }
  }

  void onExpand(int index) {
    if (state.expandedIndex == index) {
      state = state.copyWith(expandedIndex: -1);
      return;
    }
    state = state.copyWith(expandedIndex: index);
  }
}
