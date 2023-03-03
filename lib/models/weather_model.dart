import 'package:flutter/material.dart';

class WeatherModel {
  final String date;
  final double temp;
  final double maxTemp;
  final double minTemp;
  final String condition;
  final String icon;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.condition,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];
    return WeatherModel(
        date: data['location']['localtime'],
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        condition: jsonData['condition']['text'],
        icon: jsonData['condition']['icon']);
  }

  MaterialColor getThemeColor() {
    if (condition == 'Clear' || condition == 'Light Cloud') {
      return Colors.orange;
    } else if (condition == 'Sleet' ||
        condition == 'Snow' ||
        condition == 'Hail') {
      return Colors.blue;
    } else if (condition == 'Heavy Cloud') {
      return Colors.blueGrey;
    } else if (condition == 'Light Rain' ||
        condition == 'Heavy Rain' ||
        condition == 'Showers') {
      return Colors.blue;
    } else {
      return Colors.orange;
    }
  }
}
