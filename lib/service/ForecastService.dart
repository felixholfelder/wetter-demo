import 'dart:math';

import 'package:deutsch_example/model/Forecast.dart';
import 'package:deutsch_example/model/Weather.dart';
import 'package:flutter/material.dart';

class ForecastService {
  List<Weather> weathers = [Weather(name: "Regen", minTemp: 5, maxTemp: 20, icon: Icons.water_drop),
    Weather(name: "Schnee", minTemp: -5, maxTemp: 2, icon: Icons.snowing),
    Weather(name: "Sonne", minTemp: 15, maxTemp: 40, icon: Icons.sunny),
    Weather(name: "Bewölkt", minTemp: 0, maxTemp: 15, icon: Icons.cloud),
  ];

  Random random = Random();

  Forecast getForecast() {
    Weather randomWeather = weathers[random.nextInt(weathers.length)];
    int randomTemp = randomWeather.minTemp + random.nextInt(randomWeather.maxTemp - randomWeather.minTemp);
    return Forecast(name: randomWeather.name, temp: randomTemp, icon: randomWeather.icon);
  }
}
