class WeatherData {
  Location? location;
  Current? current;
  WeatherData({required this.location, required this.current});
  WeatherData.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json);
    current = Current.fromJson(json);
  }
}

class Location {
  String? name;
  String? region;
  String? country;
  double? lat;
  double? lon;
  Location.fromJson(Map<String, dynamic> json) {
    country = json["location"]["country"];
    name = json["location"]["name"];
    region = json["location"]["region"];
    lat = json["location"]["lat"];
    lon = json["location"]["lon"];
  }
}

class Current {
  String? lastUpdated;
  double? tempC;
  double? tempF;
  bool? isDay;

  double? windKph;
  int? windDegree;
  String? windDir;
  double? pressureMb;

  int? humidity;
  int? cloud;
  double? feelslikeC;
  double? feelslikeF;
  double? uv;
  Condtion? condtion;
  Current.fromJson(Map<String, dynamic> json) {
    feelslikeC = json["current"]["feelsike_c"];
    feelslikeF = json["current"]["feelslike_f"];
    humidity = json["current"]["humidity"];
    isDay = json["current"]["is_day"] == 0 ? false : true;
    lastUpdated = json["current"]["last_update"];
    pressureMb = json["current"]["pressure_mb"];
    tempC = json["current"]["temp_c"];
    tempF = json["current"]["temp_f"];
    uv = json["current"]["uv"];
    windDegree = json["current"]["wind_degree"];
    windDir = json["current"]["wind_dir"];
    windKph = json["current"]["wind_kph"];
    condtion = Condtion.fromJson(json);
  }
}

class Condtion {
  String? text;
  String? icon;
  int? code;
  Condtion.fromJson(Map<String, dynamic> json) {
    code = json["current"]["condition"]["code"];
    icon = json["current"]["condition"]["icon"];
    text = json["current"]["condition"]["text"];
  }
}
