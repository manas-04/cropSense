class SensorDataResponse {
  final String moisture;
  final String soilTemp;
  final double weatherTemp;
  final String weatherCond;
  final int weatherHumidity;
  final String weatherLocation;

  SensorDataResponse({
    required this.moisture,
    required this.soilTemp,
    required this.weatherTemp,
    required this.weatherCond,
    required this.weatherHumidity,
    required this.weatherLocation,
  });

  factory SensorDataResponse.fromJson(Map<String, dynamic> json) {
    return SensorDataResponse(
      moisture: json["moisture"],
      soilTemp: json["soilTemperature"],
      weatherTemp: json["weatherTemperature"],
      weatherCond: json["weatherCondition"],
      weatherHumidity: json["weatherHumidity"],
      weatherLocation: json["weatherLocation"],
    );
  }
}
