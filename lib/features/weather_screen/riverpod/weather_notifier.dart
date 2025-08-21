import 'dart:convert';
import 'dart:isolate';
import 'package:aviation_app/core/services/api_services/api_endpoints.dart';
import 'package:aviation_app/core/services/api_services/api_services.dart';
import 'package:aviation_app/features/auth_screens/auth_provider/auth_provider.dart';
import 'package:aviation_app/features/weather_screen/riverpod/weather_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../model/weather_model.dart';

final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((
  ref,
) {
  final userToken = ref.watch(authProvider).userToken ?? "";
  return WeatherNotifier(userToken);
});

class WeatherNotifier extends StateNotifier<WeatherState> {
  final String userToken;
  WeatherNotifier(this.userToken) : super(WeatherState()) {
    getHomeBase();
    getFavouriteWeatherList();
  }


  /// search weather by code
  Future<void> onGetWeather({required String searchCommand}) async {
    try {

      state = state.copyWith(searchButtonLoading: true);


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

  /// add favorite weather
  Future<void> addToFavouriteWeather({required WeatherModel weather}) async {
    try {
      //  BackgroundIsolateBinaryMessenger.ensureInitialized();

      final bool alreadyExist = state.favouriteWeatherList.any(
        (item) => item.station == weather.station,
      );
      if (alreadyExist) {
        Fluttertoast.showToast(
          msg: "Already added to favourite list",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }
      state = state.copyWith(
        favouriteWeatherList: [...state.favouriteWeatherList, weather],
      );

      ReceivePort receivePort = ReceivePort();
      /*     SendPort sendPort = args['sendPort'];
      final location = args['location'];
      final userToken = args['userToken'];
 */
      final Map<String, dynamic> args = {
        "sendPort": receivePort.sendPort,
        "location": weather.station,
        "userToken": userToken,
        "rootIsolateToken":
            RootIsolateToken.instance, // Pass the RootIsolateToken
      };
      await Isolate.spawn(addToFavouriteWeatherInAnotherThread, args);
      receivePort.listen((response) {
        if (response['success'] == true) {
          Fluttertoast.showToast(
            msg: "Successfully added to favourite list",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
        } else {
          Fluttertoast.showToast(
            msg: "Something went wrong",
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          final favouriteWeatherList = state.favouriteWeatherList;
          favouriteWeatherList.removeWhere(
            (item) => item.station == weather.station,
          );
          state = state.copyWith(favouriteWeatherList: favouriteWeatherList);
        }
      });
    } catch (e) {
      throw Exception("Exception while adding to favourite : $e\n");
    }
  }

  /// get favorite weather list with pagination
  Future<void> getFavouriteWeatherList({int page = 1, int limit = 10, bool loadMore = false}) async {
    try {
      if (loadMore) {
        state = state.copyWith(favouriteIsLoadingMore: true);
      } else {
        state = state.copyWith(
          favouriteIsLoading: true, 
          favouriteCurrentPage: 1, 
          favouriteHasMoreData: true
        );
      }

      final response = await ApiServices.instance.getData(
        endPoint: ApiEndPoints.getFavouriteWeatherListWithPagination(page: page, limit: limit),
        headers: {"Authorization": userToken},
      );
      
      if (response['success'] == true) {
        final List<WeatherModel> newFavouriteWeatherList =
            (response['data'] as List<dynamic>)
                .map((item) => WeatherModel.fromJson(item['weatherData']))
                .toList();
        
        List<WeatherModel> updatedList;
        if (loadMore) {
          // Append new data to existing list
          updatedList = [...state.favouriteWeatherList, ...newFavouriteWeatherList];
        } else {
          // Replace with new data (first load or refresh)
          updatedList = newFavouriteWeatherList;
        }
        
        // Check if there's more data available
        final hasMoreData = newFavouriteWeatherList.length == limit;
        
        state = state.copyWith(
          favouriteWeatherList: updatedList,
          favouriteCurrentPage: page,
          favouriteHasMoreData: hasMoreData,
          favouriteIsLoading: false,
          favouriteIsLoadingMore: false,
        );
      } else {
        debugPrint("\n Failed to fetch favourite weather list\n");
        state = state.copyWith(
          favouriteIsLoading: false,
          favouriteIsLoadingMore: false,
          favouriteHasMoreData: false,
        );
      }
    } catch (error) {
      state = state.copyWith(
        favouriteIsLoading: false,
        favouriteIsLoadingMore: false,
      );
      throw Exception('Exception while fetching favourite list : $error');
    }
  }

  /// Load more favorite weather
  Future<void> loadMoreFavouriteWeather() async {
    if (state.favouriteHasMoreData && !state.favouriteIsLoadingMore) {
      await getFavouriteWeatherList(page: state.favouriteCurrentPage + 1, loadMore: true);
    }
  }

  /// on expand weather card
  void onExpand(int index) {
    if (state.expandedIndex == index) {
      state = state.copyWith(expandedIndex: -1);
      return;
    }
    state = state.copyWith(expandedIndex: index);
  }

  /// set home base location
  Future<void> setHomeBase({required String homeBaseCode}) async {
    try {
      if (state.homeBase == homeBaseCode) {
        Fluttertoast.showToast(
          msg: "Home base already set",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return;
      }
      state = state.copyWith(homeBaseButtonLoading: true);
      debugPrint("\n setting home base  : $homeBaseCode\n");
      final response = await ApiServices.instance.postData(
        endPoint: ApiEndPoints.setHomeBase,
        body: {"location": homeBaseCode.toString()},
        headers: {
          "Authorization": userToken,
          "Content-Type": "application/json",
        },
      );
      if (response['success']) {
        state = state.copyWith(
          homeBase: homeBaseCode,
          homeBaseButtonLoading: false,
        );
        Fluttertoast.showToast(
          msg: "Home base set successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else {
        state = state.copyWith(homeBase: "", homeBaseButtonLoading: false);
        Fluttertoast.showToast(
          msg: "Something went wrong",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (error) {
      state = state.copyWith(homeBaseButtonLoading: false);
      throw Exception('\nError while setting Home Base : $error\n');
    }
  }

  /// get home base weather
  Future<void> getHomeBase() async {
    try {
      final response = await ApiServices.instance.getData(
        endPoint: ApiEndPoints.getHomeBase,
        headers: {"Authorization": userToken},
      );
      if (response['success'] == true) {
        state = state.copyWith(
          searchedWeather: WeatherModel.fromJson(
            response['data']['weatherData'],
          ),
          isWeatherFound: true,
          searchCommand: response['data']['location'],
          homeBase: response['data']['location'],
        );
      }
    } catch (error) {
      throw Exception('\nException while getting home-base : $error\n');
    }
  }
}

Future<void> addToFavouriteWeatherInAnotherThread(
  Map<String, dynamic> args,
) async {
  try {
    SendPort sendPort = args['sendPort'];
    final location = args['location'];
    final userToken = args['userToken'];
    final body = {"location": location};
    final rootIsolateToken = args['rootIsolateToken'] as RootIsolateToken?;
    if (rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    }
    final response = await post(
      Uri.parse('${ApiEndPoints.baseUrl}/${ApiEndPoints.addToFavoriteWeather}'),
      body: jsonEncode(body),
      headers: {"Authorization": userToken, "Content-Type": "application/json"},
    );
    sendPort.send(jsonDecode(response.body));
  } catch (e) {
    throw Exception("Exception while adding to favourite : $e\n");
  }
}
