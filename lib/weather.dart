class ForecastTemp {
  final num dayTemp;
  final num minTemp;
  final num maxTemp;

  ForecastTemp({required this.dayTemp, required this.minTemp, required this.maxTemp});

  factory ForecastTemp.fromJson(Map<String, dynamic> json) {
    final dayTemp = json['day'];
    final minTemp = json['min'];
    final maxTemp = json['max'];
    return ForecastTemp(dayTemp: dayTemp, minTemp: minTemp, maxTemp: maxTemp);
  }

}


class ForecastInfo {
  final int time;
  final int sunrise;
  final int sunset;
  final int humidity;
  final double? rain;
  final double wind_speed;
  final num uvi;
  final ForecastTemp forecastTemp;
  final WeatherInfo weatherInfo;

  ForecastInfo({required this.time, required this.sunrise, required this.sunset, required this.humidity, required this.rain, required this.wind_speed, required this.uvi, required this.forecastTemp, required this.weatherInfo});

  factory ForecastInfo.fromJson(Map<String, dynamic> json) {
    final time = json['dt'];
    final sunrise = json['sunrise'];
    final sunset = json['sunset'];
    final humidity = json['humidity'];
    final rain = json['rain'];
    final wind_speed = json['wind_speed'];
    final uvi = json['uvi'];
    final tempInfoJson = json['temp'];
    final forecastTemp = ForecastTemp.fromJson(tempInfoJson);
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    return ForecastInfo(time: time, sunrise: sunrise, sunset: sunset, humidity: humidity, rain: rain, wind_speed: wind_speed, uvi: uvi, forecastTemp: forecastTemp, weatherInfo: weatherInfo);
  }

}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon);
  }

}

class CurrentInfo {
  final int time;
  final int sunrise;
  final int sunset;
  final double temp;
  final WeatherInfo weatherInfo;

  CurrentInfo({required this.time, required this.sunrise, required this.sunset, required this.temp, required this.weatherInfo,});

  factory CurrentInfo.fromJson(Map<String, dynamic> json) {
    final time = json['dt'];
    final sunrise = json['sunrise'];
    final sunset = json['sunset'];
    final temp = json['temp'];
    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    return CurrentInfo(time: time, sunrise: sunrise, sunset: sunset, temp: temp, weatherInfo: weatherInfo);
  }

}

class Weather {
  final String timezone;
  final CurrentInfo currentInfo;
  List<ForecastInfo> forecastInfo = [];

  Weather({required this.timezone, required this.currentInfo, required this.forecastInfo});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final timezone = json['timezone'];

    final List<ForecastInfo> forecastInfo = [];

    final currentInfoJson = json['current'];
    final currentInfo = CurrentInfo.fromJson(currentInfoJson);

    final forecast = json['daily'] as List;
    for(int i = 0; i < forecast.length; i++){
      final forecastInfoJson = json['daily'][i];
      ForecastInfo forecast = ForecastInfo.fromJson(forecastInfoJson);
      forecastInfo.add(forecast);
    }

    return Weather(
        timezone: timezone, currentInfo: currentInfo, forecastInfo: forecastInfo);
  }

}