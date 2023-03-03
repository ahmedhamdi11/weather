import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> getData(
      {required String cityName, required BuildContext context}) async {
    WeatherModel? weather;
    try {
      String baseUrl = 'http://api.weatherapi.com/v1'; //base url
      String apiKey = '857c77d610af4cd4ad5194954231002'; //my api key
      //parse url
      Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName');
      //get data
      http.Response response = await http.get(url);
      //decode data
      Map<String, dynamic> data = jsonDecode(response.body);

      weather = WeatherModel.fromJson(data);
    } catch (e) {
      SnackBar snack = const SnackBar(
        content: Text('something went wrong try to search again'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }
    return weather;
  }
}
