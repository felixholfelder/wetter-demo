import 'package:flutter/material.dart';

class WeatherCard extends StatefulWidget {
  const WeatherCard({super.key, required this.text, this.icon});

  final String text;
  final IconData? icon;

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.icon != null
                ? Row(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(widget.icon)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(widget.text)),
                    ],
                  )
                : Text(widget.text),
          ],
        ),
      ),
    );
  }
}
