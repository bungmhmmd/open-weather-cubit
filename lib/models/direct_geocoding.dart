import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String name;
  final double lat;
  final double lon;
  final String country;
  final String state;

  DirectGeocoding({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory DirectGeocoding.fromJson(Map<String, dynamic> json) =>
      DirectGeocoding(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"] ?? '',
      );

  @override
  String toString() {
    return 'DirectGeocoding(name: $name, lat: $lat, lon: $lon, country: $country, state: $state)';
  }

  @override
  List<Object> get props {
    return [
      name,
      lat,
      lon,
      country,
      state,
    ];
  }
}
