import 'dart:convert';

WaterResponse waterResponseFromJson(String str) =>
    WaterResponse.fromJson(json.decode(str));

String waterResponseToJson(WaterResponse data) => json.encode(data.toJson());

class WaterResponse {
  WaterResponse({
    this.id,
    this.date,
    this.minConsumption,
  });

  int id;
  int date;
  double minConsumption;

  factory WaterResponse.fromJson(Map<String, dynamic> json) => WaterResponse(
        id: json["id"],
        date: json["date"],
        minConsumption: json["minConsumption"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "minConsumption": minConsumption,
      };
}
