
import 'dart:convert';

Map<String, Data> dataFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, Data>(k, Data.fromJson(v)));

String dataToJson(Map<String, Data> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class Data {
  Data({
    this.icao,
    this.iata,
    this.name,
    this.city,
    this.state,
    this.country,
    this.elevation,
    this.lat,
    this.lon,
    this.tz,
  });

  String icao;
  String iata;
  String name;
  String city;
  String state;
  String country;
  int elevation;
  double lat;
  double lon;
  String tz;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    icao: json["icao"],
    iata: json["iata"] == null ? null : json["iata"],
    name: json["name"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    elevation: json["elevation"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    tz: json["tz"],
  );

  Map<String, dynamic> toJson() => {
    "icao": icao,
    "iata": iata == null ? null : iata,
    "name": name,
    "city": city,
    "state": state,
    "country": country,
    "elevation": elevation,
    "lat": lat,
    "lon": lon,
    "tz": tz,
  };

  // @override
  // String toString() {
  //   return '"info" : { "icao": $icao, "name": $name, "city": $city, "state": $state, "country": $country, "lat": $lat,"lon": $lon,"tz": $tz}';
  // }
}
