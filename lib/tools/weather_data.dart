class WeatherData {
  ForecastData? forecastData;
  Location? location;
  Current? current;
  WeatherData.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json);
    current = Current.fromJson(json);
    forecastData = ForecastData.fromJson(json);
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
  double? feelsLikeC;
  double? feelsLikeF;
  double? uv;
  WeatherCondition? condition;
  Current.fromJson(Map<String, dynamic> json) {
    feelsLikeC = json["current"]["feelsike_c"];
    feelsLikeF = json["current"]["feelslike_f"];
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
    condition = WeatherCondition.fromJson(json);
  }
}

class WeatherCondition {
  String? text;
  String? icon;
  int? code;
  WeatherCondition.fromJson(Map<String, dynamic> json) {
    code = json["current"]["condition"]["code"];
    icon = json["current"]["condition"]["icon"];
    text = json["current"]["condition"]["text"];
  }
}

class ForecastData {
  List<ForecastDay>? forecastDay;

  ForecastData.fromJson(Map<String, dynamic> json) {
    forecastDay = (json["forecast"]["forecastday"] as List)
        .map((e) => ForecastDay.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class ForecastDay {
  String? date;
  DayData? dayData;
  Astro? astro;
  DayHourData? dayHourData;

  ForecastDay.fromJson(Map<String, dynamic> json) {
    date = json["date"];
    dayData = DayData.fromJson(json);
    astro = Astro.fromJson(json);
    dayHourData = DayHourData.fromJson(json);
  }
}

class Astro {
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonSet;
  String? moonPhase;
  String? moonIllumination;
  Astro.fromJson(Map<String, dynamic> json) {
    sunrise = json["astro"]["sunrise"];
    sunset = json["astro"]["sunset"];
    moonrise = json["astro"]["moonrise"];
    moonSet = json["astro"]["moonset"];
    moonPhase = json["astro"]["moon_phase"];
    moonIllumination = json["astro"]["moon_illumination"];
  }
}

class DayData {
  double? maxTempC;
  double? maxTempF;
  double? minTempC;
  double? minTempF;
  double? avgTempC;
  double? avgTempF;
  double? maxWindMph;
  double? maxWindKph;
  double? totalPreCiPmM;
  double? totalPreCiPIn;
  double? avgVisKm;
  double? avgVisMiles;
  double? avgHumidity;
  int? dailyWillItRain;
  int? dailyChanceOfRain;
  int? dailyWillItSnow;
  int? dailyChanceOfSnow;
  double? uv;
  DayCondition? dayCondition;
  DayData.fromJson(Map<String, dynamic> json) {
    maxTempC = json["day"]["maxtemp_c"];
    maxTempF = json["day"]["maxtemp_f"];
    minTempC = json["day"]["mintemp_c"];
    minTempF = json["day"]["mintemp_f"];
    avgTempC = json["day"]["avgtemp_c"];
    avgTempF = json["day"]["avgtemp_f"];
    maxWindMph = json["day"]["maxwind_mph"];
    maxWindKph = json["day"]["maxwind_kph"];
    totalPreCiPmM = json["day"]["totalprecip_mm"];
    totalPreCiPIn = json["day"]["totalprecip_in"];
    avgVisKm = json["day"]["avgvis_km"];
    avgVisMiles = json["day"]["avgvis_miles"];
    avgHumidity = json["day"]["avghumidity"];
    uv = json["day"]["uv"];
    dailyChanceOfRain = json["day"]["daily_chance_of_rain"];
    dailyChanceOfSnow = json["day"]["daily_chance_of_snow"];
    dailyWillItRain = json["day"]["daily_will_it_rain"];
    dailyWillItSnow = json["day"]["daily_will_it_rain"];
    dayCondition = DayCondition.fromJson(json);
  }
}

class DayCondition {
  String? text;
  String? icon;
  int? code;
  DayCondition.fromJson(Map<String, dynamic> json) {
    code = json["day"]["condition"]["code"];
    icon = json["day"]["condition"]["icon"];
    text = json["day"]["condition"]["text"];
  }
}

class DayHourData {
  List<DayHour> dayHour = [];
  DayHourData.fromJson(Map<String, dynamic> json) {
    dayHour = (json["hour"] as List)
        .map((e) => DayHour.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class DayHour {
  int? timeEpoch;
  DateTime? time;
  double? tempC;
  double? tempF;
  bool? isDay;
  double? windMph;
  double? windKph;
  int? windDegree;
  String? windDir;
  double? pressureMb;
  double? pressureIn;
  double? preCipMm;
  double? preCipIn;
  int? humidity;
  int? cloud;
  double? feelsLikeC;
  double? feelsLikeF;
  double? windChillC;
  double? windChillF;
  double? heatIndexC;
  double? heatIndexF;
  double? dewPointC;
  double? dewPointF;
  int? willItRain;
  int? chanceOfRain;
  int? willItSnow;
  int? chanceOfSnow;
  double? visKm;
  double? visMiles;
  double? gustMph;
  double? gustKph;
  double? uv;
  DayHourCondition? dayHourCondition;

  DayHour.fromJson(Map<String, dynamic> json) {
    uv = json["uv"];
    gustKph = json["gust_kph"];
    gustMph = json["gust_mph"];
    visMiles = json["vis_miles"];
    visKm = json["vis_km"];
    chanceOfSnow = json["chance_of_snow"];
    chanceOfRain = json["chance_of_rain"];
    willItRain = json["will_it_rain"];
    willItSnow = json["will_it_snow"];
    dewPointC = json["dewpoint_c"];
    dewPointF = json["dewpoint_f"];
    heatIndexC = json["heatindex_c"];
    heatIndexF = json["heatindex_f"];
    windChillF = json["windchill_f"];
    windChillC = json["windchill_c"];
    feelsLikeC = json["windchill_c"];
    feelsLikeF = json["windchill_f"];
    cloud = json["cloud"];
    humidity = json["humidity"];
    preCipIn = json["precip_in"];
    preCipMm = json["precip_mm"];
    pressureIn = json["pressure_in"];
    pressureMb = json["pressure_mm"];
    windDir = json["wind_dir"];
    windDegree = json["wind_degree"];
    timeEpoch = json["time_epoch"];
    time = DateTime.parse(json["time"]);
    tempC = json["temp_c"];
    tempF = json["temp_f"];
    isDay = json["is_day"] == 0 ? false : true;
    dayHourCondition = DayHourCondition.fromJson(json);
  }
}

class DayHourCondition {
  String? text;
  int? code;
  String? icon;
  DayHourCondition.fromJson(Map<String, dynamic> json) {
    text = json["condition"]["text"];
    code = json["condition"]["code"];
    icon = json["condition"]["icon"];
  }
}
