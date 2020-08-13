import 'dart:convert';

WaterConsumptionResponse waterConsumptionResponseFromJson(String str) =>
    WaterConsumptionResponse.fromJson(json.decode(str));

String waterConsumptionResponseToJson(WaterConsumptionResponse data) =>
    json.encode(data.toJson());

class WaterConsumptionResponse {
  WaterConsumptionResponse({
    this.waterConsumptions,
    this.waterId,
  });

  List<WaterConsumption> waterConsumptions;
  int waterId;

  factory WaterConsumptionResponse.fromJson(Map<String, dynamic> json) =>
      WaterConsumptionResponse(
        waterConsumptions: List<WaterConsumption>.from(
            json["waterConsumptions"].map((x) => WaterConsumption.fromJson(x))),
        waterId: json["waterId"],
      );

  Map<String, dynamic> toJson() => {
        "waterConsumptions":
            List<dynamic>.from(waterConsumptions.map((x) => x.toJson())),
        "waterId": waterId,
      };
}

class WaterConsumption {
  WaterConsumption({
    this.consumption,
    this.time,
  });

  double consumption;
  String time;

  factory WaterConsumption.fromJson(Map<String, dynamic> json) =>
      WaterConsumption(
        consumption: json["consumption"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "consumption": consumption,
        "time": time,
      };
}
