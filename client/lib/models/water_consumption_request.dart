import 'dart:convert';

WaterConsumptionRequest waterConsumptionRequestFromJson(String str) =>
    WaterConsumptionRequest.fromJson(json.decode(str));

String waterConsumptionRequestToJson(WaterConsumptionRequest data) =>
    json.encode(data.toJson());

class WaterConsumptionRequest {
  WaterConsumptionRequest({
    this.consumption,
    this.time,
    this.waterId,
  });

  double consumption;
  String time;
  int waterId;

  factory WaterConsumptionRequest.fromJson(Map<String, dynamic> json) =>
      WaterConsumptionRequest(
        consumption: json["consumption"],
        time: json["time"],
        waterId: json["waterId"],
      );

  Map<String, dynamic> toJson() => {
        "consumption": consumption,
        "time": time,
        "waterId": waterId,
      };
}
