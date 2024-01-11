import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_cubit/constants/constants.dart';
import 'package:open_weather_cubit/exceptions/weather_exception.dart';
import 'package:open_weather_cubit/models/direct_geocoding.dart';
import 'package:open_weather_cubit/models/weather.dart';
import 'package:open_weather_cubit/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({required this.httpClient});

  Future<DirectGeocoding> getDirectGeocoding(String city) async {
    final uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/geo/1.0/direct',
      queryParameters: {
        'q': city,
        'limit': kLimit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final responseBody = json.decode(response.body);

      if (responseBody.isEmpty) {
        throw WeatherException('Cannot get the location of $city');
      }

      final directGeocoding = DirectGeocoding.fromJson(responseBody[0]);

      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final uri = Uri(
      scheme: 'https',
      host: kApiHost,
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': directGeocoding.lat.toString(),
        'lon': directGeocoding.lon.toString(),
        'units': kUnit,
        'appid': dotenv.env['APPID'],
      },
    );

    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }

      final weatherJson = json.decode(response.body);
      final Weather weather = Weather.fromJson(weatherJson);
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
