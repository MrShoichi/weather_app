import 'package:flutter/material.dart';

class WeatherItem {
  String image;
  String date;
  int countTemperature;
  String countWind;
  String countWater;
  String countPressure;

  WeatherItem(this.image, this.date, this.countTemperature, this.countWind,
      this.countWater, this.countPressure);
}
