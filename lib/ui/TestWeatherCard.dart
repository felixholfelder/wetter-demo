import 'package:flutter/material.dart';

class TestWeatherCard extends StatefulWidget {
  const TestWeatherCard({super.key});

  @override
  State<TestWeatherCard> createState() => _TestWeatherCardState();
}

class _TestWeatherCardState extends State<TestWeatherCard> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Row(
        children: [
          Icon(Icons.snowing),
          Text("Schnee"),
        ],
      ),
    );
  }
}
