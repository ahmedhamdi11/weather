import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFormField(
            onChanged: (val) {
              cityName = val;
            },
            onFieldSubmitted: (data) async {
              cityName = data;
              Provider.of<WeatherProvider>(context, listen: false).cityName =
                  cityName;
              WeatherModel? weather = await WeatherService()
                  .getData(cityName: data, context: context);
              Provider.of<WeatherProvider>(context, listen: false).setter =
                  weather;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      Provider.of<WeatherProvider>(context, listen: false)
                          .cityName = cityName;
                      WeatherModel? weather = await WeatherService()
                          .getData(cityName: cityName!, context: context);

                      Provider.of<WeatherProvider>(context, listen: false)
                          .setter = weather;
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.search)),
                border: const OutlineInputBorder(),
                hintText: 'search a city',
                label: const Text('search'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30)),
          ),
        ),
      ),
    );
  }
}
