import 'package:aviation_app/features/weather_screen/presentation/widgets/weather_card/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../riverpod/weather_notifier.dart';

class FavouriteWeathersList extends ConsumerStatefulWidget {
  const FavouriteWeathersList({super.key});

  @override
  ConsumerState<FavouriteWeathersList> createState() => _FavouriteWeathersListState();
}

class _FavouriteWeathersListState extends ConsumerState<FavouriteWeathersList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      // Load more when user scrolls to 80% of the list
      ref.read(weatherProvider.notifier).loadMoreFavouriteWeather();
    }
  }

  @override
  Widget build(BuildContext context) {
    final weatherState = ref.watch(weatherProvider);

    if (weatherState.favouriteIsLoading && weatherState.favouriteWeatherList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (weatherState.favouriteWeatherList.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      itemCount: weatherState.favouriteWeatherList.length + (weatherState.favouriteIsLoadingMore ? 1 : 0),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        // Show loading indicator at the end when loading more
        if (index == weatherState.favouriteWeatherList.length) {
          return Padding(
            padding: EdgeInsets.all(16.r),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final weather = weatherState.favouriteWeatherList[index];

        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          child: GestureDetector(
            onTap: () => ref.read(weatherProvider.notifier).onExpand(index),
            child: WeatherCard(
              weather: weather, 
              isExpand: weatherState.expandedIndex == index,
            ),
          ),
        );
      },
    );
  }
}
