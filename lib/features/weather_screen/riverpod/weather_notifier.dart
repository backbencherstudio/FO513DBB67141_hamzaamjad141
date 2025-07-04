import 'dart:convert';

import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/weather_screen/data/dummy_weather_list.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../model/weather_model.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref)  {
    final userToken = ref.watch(authProvider).userToken ?? "";
    return WeatherNotifier(userToken);
    },
);

class WeatherNotifier extends StateNotifier<WeatherState> {
  final String userToken;
  WeatherNotifier(this.userToken) : super(WeatherState());

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
  
  Future<void> setHomeBase({required String homeBaseCode}) async {
    try{
      state = state.copyWith(homeBaseButtonLoading: true);
      debugPrint("\nhome base  : $homeBaseCode\n");
      final response = await ApiServices.instance.postData(
          endPoint: ApiEndPoints.setHomeBase,
          body: {"location":homeBaseCode.toString()},
          headers: {
            "Authorization": userToken,
            "Content-Type": "application/json"
          }
      );
      debugPrint("\nset Home base response : $response\n");
      if(response['success']){
        state = state.copyWith(homeBase: homeBaseCode,homeBaseButtonLoading: false);
        Fluttertoast.showToast(msg: "Home base set successfully",backgroundColor: Colors.green,textColor: Colors.white);
      }
      else{
        state = state.copyWith(homeBase: "", homeBaseButtonLoading: false);
        Fluttertoast.showToast(msg: "Something went wrong"
            ,backgroundColor: Colors.red,textColor: Colors.white);
      }

    }catch(error){
      state = state.copyWith(homeBaseButtonLoading: false);
      throw Exception('\nError while setting Home Base : $error\n');
    }
  }
}
