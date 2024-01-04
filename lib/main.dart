import 'package:deutsch_example/service/ForecastService.dart';
import 'package:deutsch_example/ui/WeatherCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'model/Forecast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ForecastService forecastService = ForecastService();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late Forecast forecast = Forecast.empty();

  bool _loading = false;

  @override
  void initState() {
    _loadForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Wetter-Demo"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async => await _getForecast(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Skeletonizer(
            enabled: _loading || forecast.name == "",
            child: Column(
              children: <Widget>[
                WeatherCard(text: forecast.name, icon: forecast.icon),
                WeatherCard(
                    text: "Temperatur: ${forecast.temp} °C",
                    icon: Icons.thermostat),
                WeatherCard(
                    text: forecast.forecastText, icon: Icons.short_text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loadForecast() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState?.show();
    });
  }

  Future<void> _getForecast() async {
    setState(() {
      _loading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      forecast = forecastService.getForecast();
      _loading = false;
    });
  }
}
