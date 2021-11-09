import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/tools/api_data.dart';
import 'package:weather_app/tools/weather_data.dart';
import 'package:weather_icons/weather_icons.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  Position? position;

  static WeatherCubit get(context) => BlocProvider.of(context);

  WeatherData? weatherData;

  getCurrentPosition() {
    var geolocatorPlatform = GeolocatorPlatform.instance;
    emit(WeatherLocationLoadingState());

    geolocatorPlatform
        .getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    )
        .then((position) {
      this.position = position;
      emit(WeatherLocationSuccessState());
      dioData("${position.latitude},${position.longitude}");
    });
  }

  dioData(var data) async {
    emit(WeatherLoadingState());
    Response response;
    var dio = Dio();
    response = await dio.get(ApiData.apiLink,
        queryParameters: {"q": data, "days": "3", "lang": "en"});

    if (response.statusCode == 200) {
      weatherData = WeatherData.fromJson(response.data);
      print(response.data["forecast"]["forecastday"][0]);
      print(weatherData!.forecastData!.forecastDay![0].dayHourData!.dayHour[1]
          .dayHourCondition!.text!);
      print(weatherData!.forecastData!.forecastDay!.length);
      print(weatherData!.forecastData!.forecastDay![0].astro!.moonIllumination);
      emit(WeatherSuccessState());
    }
  }

  String? getImage(int weatherCode) {
    if (weatherData!.current!.isDay! == true) {
      switch (weatherCode) {
        case 1000:
          return "assets/images/sunny.jpeg";
        case 1003:
          return "assets/images/partly-cloudy-sky.jpg";
        case 1030:
          return "assets/images/mist-fog.jpg";
        case 1009:
          return "assets/images/Overcast.jpg";
      }
      emit(WeatherImageBackgroundChangeSuccess());
    } else {
      switch (weatherCode) {
        case 1000:
          return "assets/images/crescent-moon-with-visible-craters-mountains-natural-clear-sky.jpg";
        case 1003:
          return "assets/images/partly-cloudy-sky.jpg";
        case 1030:
          return "assets/images/mist-fog.jpg";
        case 1009:
          return "assets/images/overcast.jpg";
      }
    }
  }

  IconData? getIcon({required int weatherCode, required bool isDay}) {
    if (isDay == true) {
      switch (weatherCode) {
        case 1000:
          return WeatherIcons.day_sunny;
        case 1003:
          return WeatherIcons.day_cloudy;
        case 1030:
          return WeatherIcons.day_fog;
        case 1009:
          return WeatherIcons.day_cloudy;
      }
      emit(WeatherImageBackgroundChangeSuccess());
    } else {
      switch (weatherCode) {
        case 1000:
          return WeatherIcons.night_clear;
        case 1003:
          return WeatherIcons.night_cloudy;
        case 1030:
          return WeatherIcons.night_fog;
        case 1009:
          return WeatherIcons.night_cloudy;
      }
    }
  }

  List<DayHour> getTodayData() {
    return weatherData!.forecastData!.forecastDay![0].dayHourData!.dayHour
        .where((element) => element.time!.hour >= DateTime.now().hour)
        .toList();
  }

  List<ForecastDay?> getThreeDaysData() {
    return weatherData!.forecastData!.forecastDay!;
  }
}
