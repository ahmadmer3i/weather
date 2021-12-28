import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/iconic_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/services/internet_service.dart';
import 'package:weather_app/tools/api_data.dart';
import 'package:weather_app/tools/weather_data.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  Position? position;
  Response? response;

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

  dioData(data) {
    emit(WeatherLoadingState());
    InternetServices.dioData(
      dataMap: {"q": data, "days": 3},
      url: ApiData.apiLink,
      responseData: weatherData,
    ).then((response) {
      if (response.statusCode == 200) {
        weatherData = WeatherData.fromJson(response.data);
      }
      emit(WeatherSuccessState());
    });
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
          return "assets/images/overcast.jpg";
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
      emit(WeatherImageBackgroundChangeSuccess());
    }
  }

  IconData? getIcon({required int weatherCode, required bool isDay}) {
    if (isDay == true) {
      switch (weatherCode) {
        case 1000:
          return Iconic.sun;
        case 1003:
          return Iconic.cloud;
        case 1030:
          return Iconic.cloud;
        case 1009:
          return Iconic.cloud;
      }
      emit(WeatherImageBackgroundChangeSuccess());
    } else {
      switch (weatherCode) {
        case 1000:
          return Iconic.moon;
        case 1003:
          return Iconic.cloud;
        case 1030:
          return Iconic.cloud;
        case 1009:
          return Iconic.cloud;
      }
      emit(WeatherImageBackgroundChangeSuccess());
    }
  }

  List<DayHour> today = [];
  List<ForecastDay?> threeDays = [];
  getTodayData() {
    today = weatherData!.forecastData!.forecastDay![0].dayHourData!.dayHour
        .where((element) => element.time!.hour >= DateTime.now().hour)
        .toList();
    emit(WeatherGetTodayDataSuccess());
  }

  getThreeDaysData() {
    threeDays = weatherData!.forecastData!.forecastDay!;
    emit(WeatherGetThreeDayDataSuccess());
  }
}
