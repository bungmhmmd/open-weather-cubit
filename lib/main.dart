import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:open_weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:open_weather_cubit/cubits/theme/theme_cubit.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:open_weather_cubit/pages/home_page.dart';

import 'package:http/http.dart' as http;
import 'package:open_weather_cubit/repositories/weather_repository.dart';
import 'package:open_weather_cubit/services/weather_api_services.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
          weatherApiServices: WeatherApiServices(httpClient: http.Client())),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WeatherCubit(
                weatherRepository: context.read<WeatherRepository>()),
          ),
          BlocProvider(
            create: (context) => TempSettingsCubit(),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(
              weatherCubit: context.read<WeatherCubit>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Open Weather App',
              debugShowCheckedModeBanner: false,
              theme: state.appTheme == AppTheme.light
                  ? ThemeData.light()
                  : ThemeData.dark(),
              // ThemeData(
              //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              //   useMaterial3: true,
              //   fontFamily: 'Poppins',
              // ),
              home: const HomePage(),
            );
          },
        ),
      ),
    );
  }
}
