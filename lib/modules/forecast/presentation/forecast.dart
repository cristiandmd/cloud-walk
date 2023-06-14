import 'package:concerts_weather/app/design_tokens.dart';
import 'package:concerts_weather/generated/l10n.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:concerts_weather/modules/forecast/presentation/forecast_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forecast_bloc.dart';
import 'forecast_state.dart';

class Forecast extends StatefulWidget {
  const Forecast({
    super.key,
    required this.bloc,
    required this.latitude,
    required this.longitude,
    required this.range,
  });
  final ForecastBloc bloc;
  final double latitude, longitude;
  final ForecastRange range;

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(LoadForecastEvent(
      latitude: widget.latitude,
      longitude: widget.longitude,
      range: widget.range,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(DesignTokens.large),
      child: BlocBuilder<ForecastBloc, ForecastState>(
        builder: (context, state) {
          return switch (state) {
            InitialForecastState() => const SizedBox.shrink(),
            LoadingForecastState() => const CircularProgressIndicator(),
            LoadedForecastState() => _LoadedState(data: state.data),
            CouldNotLoadForecastState() => Column(
                children: [
                  const Icon(Icons.error),
                  const SizedBox(height: DesignTokens.small),
                  Text(S.current.ForecastCouldNotLoad),
                ],
              ),
          };
        },
      ),
    );
  }
}

class _LoadedState extends StatelessWidget {
  const _LoadedState({required this.data});
  final ForecastModel data;

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
                  S.current.ForecastTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: DesignTokens.large),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
