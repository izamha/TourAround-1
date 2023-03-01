import 'package:weather/weather.dart';

import '../constants/api_keys.dart';

class WeatherMethods {
   Future<Weather> getWeather(double lat, double lng) async {
    WeatherFactory wf = WeatherFactory(openWeatherApiKey);
    // String cityName = "Kigali";
    Weather weather = await wf.currentWeatherByLocation(lat, lng);
    // Weather weatherByCity = await wf.currentWeatherByCityName(cityName);
    return weather;
  }
}