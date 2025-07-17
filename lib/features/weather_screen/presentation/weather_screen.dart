import 'package:aviation_app/core/constant/padding.dart';
import 'package:aviation_app/features/create_screen/create_screen.dart';
import 'package:aviation_app/features/ebook_screen/presentation/widgets/e_book_app_bar.dart';
import 'package:aviation_app/features/weather_screen/presentation/widgets/get_weather_input_field.dart';
import 'package:aviation_app/features/weather_screen/presentation/widgets/weather_result/weather_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late final FocusNode _focusNode;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CreateScreen(
      child: Padding(
        padding: AppPadding.screenHorizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// App Bar
              EBookAppBar(textTheme: textTheme),
              SizedBox(height: 55.h),

              Text("Aviation Weather", style: textTheme.headlineMedium),
              SizedBox(height: 24.h),
              GetWeatherInputField(
                textEditingController: _textEditingController,
                focusNode: _focusNode,
              ),
              SizedBox(height: 12.h,),
              WeatherResult(),
              SizedBox(height: 145.h,),
            ],
          ),
        ),
      ),
    );
  }
}
