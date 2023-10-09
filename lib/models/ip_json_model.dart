//http://ip-api.com/json/

class LocationData {
  String? country;
  String? regionName;
  double? lat;
  double? lon;
  String? query;

  LocationData({
    this.country,
    this.regionName,
    this.lat,
    this.lon,
    this.query,
  });

  factory LocationData.fromJSON(Map<String, dynamic> json) {
    return LocationData(
      country: json["country"],
      regionName: json["regionName"],
      lat: json["lat"],
      lon: json["lon"],
      query: json["query"],
    );
  }
}
