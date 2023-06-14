import 'package:concerts_weather/modules/concerts/domain/repositories/concert_model.dart';
import 'package:flutter/material.dart';

class ConcertsDetailPage extends StatelessWidget {
  const ConcertsDetailPage({
    super.key,
    required this.currentWeather,
    required this.forecast,
    required this.concert,
  });
  final WidgetBuilder currentWeather;
  final WidgetBuilder forecast;
  final ConcertModel concert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${concert.address.city}, ${concert.address.country}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            currentWeather(context),
            forecast(context),
          ],
        ),
      ),
    );
  }
}
