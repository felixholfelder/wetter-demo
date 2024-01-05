import 'package:deutsch_example/responsive/LayoutUtils.dart';
import 'package:deutsch_example/responsive/ResponsiveWrapper.dart';
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
        actions: buildActionButtons(),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async => await _getForecast(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Skeletonizer(
              enabled: _loading || forecast.name == "",
              child: ResponsiveWrapper(
                mobile: Column(
                  children: <Widget>[
                    buildForecastName(),
                    buildForecastTemp(),
                    buildForecastText(),
                  ],
                ),
                tablet: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: buildForecastName()),
                        Expanded(child: buildForecastTemp()),
                      ],
                    ),
                    buildForecastText(),
                  ],
                ),
                desktop: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: buildForecastName()),
                        Expanded(child: buildForecastTemp()),
                        Expanded(child: buildForecastText()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForecastName() {
    return WeatherCard(text: forecast.name, icon: forecast.icon);
  }

  Widget buildForecastTemp() {
    return WeatherCard(
        text: "Temperatur: ${forecast.temp} °C", icon: Icons.thermostat);
  }

  Widget buildForecastText() {
    return WeatherCard(text: forecast.forecastText, icon: Icons.short_text);
  }

  List<Widget>? buildActionButtons() {
    if(LayoutUtils.isDesktop(MediaQuery.of(context).size.width)) {
      return [IconButton(icon: const Icon(Icons.refresh), onPressed: () => _loadForecast())];
    }
    return [];
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
