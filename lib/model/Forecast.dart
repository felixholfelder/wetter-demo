import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Forecast {
  final String name;
  final int temp;
  final IconData icon;
  final String forecastText;

  Forecast({required this.name, required this.temp, required this.icon, required this.forecastText});
  factory Forecast.empty() {
    return Forecast(name: "", temp: 0, icon: Icons.abc, forecastText: "");
  }
}