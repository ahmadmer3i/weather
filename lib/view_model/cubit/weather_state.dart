part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherSuccessState extends WeatherState {}

class WeatherLocationLoadingState extends WeatherState {}

class WeatherLocationSuccessState extends WeatherState {}

class WeatherImageBackgroundChangeSuccess extends WeatherState {}

class WeatherGetTodayDataSuccess extends WeatherState {}
