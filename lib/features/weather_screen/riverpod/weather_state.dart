import '../model/weather_model.dart';

class WeatherState{
  final int selectedTab;
  List<WeatherModel>? weatherList;
  WeatherModel? searchedWeather;
  String? searchCommand;
  WeatherState({this.weatherList, this.searchedWeather, this.selectedTab = 0, this.searchCommand});
  WeatherState copyWith({List<WeatherModel>? weatherList, WeatherModel? searchedWeather, int? selectedTab, String? searchCommand}){
    return WeatherState(
      weatherList: weatherList ?? this.weatherList,
      searchedWeather: searchedWeather,
      selectedTab: selectedTab ?? this.selectedTab,
      searchCommand: searchCommand ?? this.searchCommand,
    );
  }
}