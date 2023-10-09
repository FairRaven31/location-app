class WeatherData {
  Current? current;

  WeatherData({
    this.current,
  });

  factory WeatherData.fromJSON(Map<String, dynamic> json) {
    return WeatherData(
      current: Current.fromJSON(json["current"])
    );
  }
}

class Current {
  String? observationTime;
  String? temperature;

  Current({
    this.observationTime,
    this.temperature,
  });

  factory Current.fromJSON(Map<String, dynamic> json) {
    return Current(
      observationTime: json["observation_time"],
      temperature: json["temperature"],
    );
  }
}
