import '../model/weather_model.dart';

class WeatherState {
  final int selectedTab;
  final List<WeatherModel>? weatherList;
  final List<WeatherModel> favouriteWeatherList;
  final WeatherModel? searchedWeather;
  final String? searchCommand;
  final bool isWeatherFound;
  WeatherState({
    this.weatherList,
    this.searchedWeather,
    this.selectedTab = 0,
    this.searchCommand,
    this.favouriteWeatherList = const [],
    this.isWeatherFound = false,
  });
  WeatherState copyWith({
    List<WeatherModel>? weatherList,
    WeatherModel? searchedWeather,
    int? selectedTab,
    String? searchCommand,
    List<WeatherModel>? favouriteWeatherList,
    bool? isWeatherFound,
  }) {
    return WeatherState(
      weatherList: weatherList ?? this.weatherList,
      searchedWeather: searchedWeather ?? this.searchedWeather,
      selectedTab: selectedTab ?? this.selectedTab,
      searchCommand: searchCommand ?? this.searchCommand,
      favouriteWeatherList: favouriteWeatherList ?? this.favouriteWeatherList,
      isWeatherFound: isWeatherFound ?? this.isWeatherFound,
    );
  }
}
