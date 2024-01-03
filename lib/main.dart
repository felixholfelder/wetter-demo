import 'package:deutsch_example/service/ForecastService.dart';
import 'package:flutter/material.dart';

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
      title: 'Wetter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ForecastService forecastService = ForecastService();

  late Forecast forecast;

  @override
  void initState() {
    getForecast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Title(
                    color: Colors.black,
                    child: const Text("Das aktuelle Wetter")),
                Icon(forecast.icon),
                Text(forecast.name),
                Text("Temperatur: ${forecast.temp} °C")
              ],
            ),
          ),
          onRefresh: () async => getForecast()),
    );
  }

  void getForecast() {
    setState(() {
      forecast = forecastService.getForecast();
    });
  }
}
