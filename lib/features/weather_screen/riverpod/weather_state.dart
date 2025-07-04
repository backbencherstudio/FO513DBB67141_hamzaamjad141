import '../model/weather_model.dart';

class WeatherState {
  final int selectedTab;
  final List<WeatherModel> favouriteWeatherList;
  final WeatherModel? searchedWeather;
  final String? searchCommand;
  final bool isWeatherFound;
  final int? expandedIndex;
  final bool searchButtonLoading;
  WeatherState({
    this.searchedWeather,
    this.selectedTab = 0,
    this.searchCommand,
    this.favouriteWeatherList = const [],
    this.isWeatherFound = false,
    this.expandedIndex,
    this.searchButtonLoading = false
  });
  WeatherState copyWith({
    List<WeatherModel>? weatherList,
    WeatherModel? searchedWeather,
    int? selectedTab,
    String? searchCommand,
    List<WeatherModel>? favouriteWeatherList,
    bool? isWeatherFound,
    int? expandedIndex,
    bool? searchButtonLoading,
  }) {
    return WeatherState(
      searchedWeather: searchedWeather ?? this.searchedWeather,
      selectedTab: selectedTab ?? this.selectedTab,
      searchCommand: searchCommand ?? this.searchCommand,
      favouriteWeatherList: favouriteWeatherList ?? this.favouriteWeatherList,
      isWeatherFound: isWeatherFound ?? this.isWeatherFound,
      expandedIndex: expandedIndex ?? this.expandedIndex,
      searchButtonLoading: searchButtonLoading ?? this.searchButtonLoading
    );
  }


  WeatherState clearWeather({required String searchCommand}) {
    return WeatherState(
        searchedWeather: searchedWeather,
        selectedTab: selectedTab,
        searchCommand: searchCommand,
        favouriteWeatherList: favouriteWeatherList,
        isWeatherFound: false,
        expandedIndex: expandedIndex,
        searchButtonLoading: false
    );
  }
}
