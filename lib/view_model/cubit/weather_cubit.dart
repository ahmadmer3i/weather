import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/tools/api_data.dart';
import 'package:weather_app/tools/weather_data.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

  static WeatherCubit get(context) => BlocProvider.of(context);


  WeatherData? weatherData;

  getCurrentPosition() {
    var geolocatorPlatform = GeolocatorPlatform.instance;
    emit(WeatherLocationLoadingState());

    geolocatorPlatform
        .getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    )
        .then((position) {
      emit(WeatherLocationSuccessState());
      dioData("${position.latitude},${position.longitude}");
    });
  }

  dioData(var data) async {
    emit(WeatherLoadingState());
    Response response;
    var dio = Dio();
    response = await dio.get(ApiData.apiLink, queryParameters: {"q": data});

    if (response.statusCode == 200) {
      weatherData = WeatherData.fromJson(response.data);
      emit(WeatherSuccessState());
    }
  }
}
