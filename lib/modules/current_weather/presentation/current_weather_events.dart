sealed class CurrentWeatherEvent {}

class LoadCurrentWeatherEvent extends CurrentWeatherEvent {
  LoadCurrentWeatherEvent({required this.latitude, required this.longitude});
  final double latitude, longitude;
}
