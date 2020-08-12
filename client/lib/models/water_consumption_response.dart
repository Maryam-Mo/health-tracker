import 'dart:convert';

WaterConsumptionResponse waterConsumptionResponseFromJson(String str) =>
    WaterConsumptionResponse.fromJson(json.decode(str));

String waterConsumptionResponseToJson(WaterConsumptionResponse data) =>
    json.encode(data.toJson());

class WaterConsumptionResponse {
  WaterConsumptionResponse({
    this.minConsumption,
    this.waterConsumptions,
    this.waterId,
  });

  int minConsumption;
  List<WaterConsumption> waterConsumptions;
  int waterId;

  factory WaterConsumptionResponse.fromJson(Map<String, dynamic> json) =>
      WaterConsumptionResponse(
        minConsumption: json["minConsumption"],
        waterConsumptions: List<WaterConsumption>.from(
            json["waterConsumptions"].map((x) => WaterConsumption.fromJson(x))),
        waterId: json["waterId"],
      );

  Map<String, dynamic> toJson() => {
        "minConsumption": minConsumption,
        "waterConsumptions":
            List<dynamic>.from(waterConsumptions.map((x) => x.toJson())),
        "waterId": waterId,
      };
}

class WaterConsumption {
  WaterConsumption({
    this.consumption,
    this.id,
    this.time,
    this.water,
  });

  int consumption;
  int id;
  String time;
  Water water;

  factory WaterConsumption.fromJson(Map<String, dynamic> json) =>
      WaterConsumption(
        consumption: json["consumption"],
        id: json["id"],
        time: json["time"],
        water: Water.fromJson(json["water"]),
      );

  Map<String, dynamic> toJson() => {
        "consumption": consumption,
        "id": id,
        "time": time,
        "water": water.toJson(),
      };
}

class Water {
  Water({
    this.date,
    this.id,
    this.minConsumption,
  });

  int date;
  int id;
  int minConsumption;

  factory Water.fromJson(Map<String, dynamic> json) => Water(
        date: json["date"],
        id: json["id"],
        minConsumption: json["minConsumption"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "id": id,
        "minConsumption": minConsumption,
      };
}
