import 'package:concerts_weather/app/design_tokens.dart';
import 'package:concerts_weather/generated/l10n.dart';
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';
import 'package:concerts_weather/modules/current_weather/presentation/current_weather_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'current_weather_bloc.dart';
import 'current_weather_state.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({
    super.key,
    required this.bloc,
    required this.latitude,
    required this.longitude,
  });
  final CurrentWeatherBloc bloc;
  final double latitude, longitude;

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(LoadCurrentWeatherEvent(latitude: widget.latitude, longitude: widget.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.large),
      child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
        builder: (context, state) {
          return Center(
            child: switch (state) {
              InitialCurrentWeatherState() => const SizedBox.shrink(),
              LoadingCurrentWeatherState() => const CircularProgressIndicator(),
              LoadedCurrentWeatherState() => _LoadedState(data: state.data),
              ColdNotLoadCurrentWeatherState() => Column(
                  children: [
                    const Icon(Icons.error),
                    const SizedBox(height: DesignTokens.small),
                    Text(S.current.CurrentWeatherCouldNotLoad),
                  ],
                ),
            },
          );
        },
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  const _LoadedState({required this.data});
  final WeatherModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.current.CurrentWeatherTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: DesignTokens.large),
                Text(
                  data.main,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  data.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
