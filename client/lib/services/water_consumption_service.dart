import 'package:health/models/water_consumption_request.dart';
import 'package:health/models/water_consumption_response.dart';
import 'package:http/http.dart' as http;

class WaterConsumptionService {
  WaterConsumptionService({this.url});

  final String url;
  final String baseUrl = 'http://192.168.2.100:8080';

  Future<WaterConsumptionResponse> postData(
      WaterConsumptionRequest waterConsumptionRequest) async {
    final response = await http.post(baseUrl + url,
        headers: {"Content-type": "application/json"},
        body: waterConsumptionRequestToJson(waterConsumptionRequest));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return waterConsumptionResponseFromJson(responseString);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<WaterConsumptionResponse> fetchData() async {
    final response = await http.get(baseUrl + url);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return waterConsumptionResponseFromJson(responseString);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
