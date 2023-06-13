class AddressModel {
  const AddressModel({
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
  });
  final String city;
  final String country;
  final double latitude, longitude;
}
