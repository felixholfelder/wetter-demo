import 'package:flutter/material.dart';

class Weather {
  String name;
  int minTemp;
  int maxTemp;
  IconData icon;

  Weather(
      {required this.name,
      required this.minTemp,
      required this.maxTemp,
      required this.icon});
}
