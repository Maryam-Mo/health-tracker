import 'package:health/models/water_response.dart';
import 'package:http/http.dart' as http;

class WaterService {
  WaterService({this.url});

  final String url;
  final String baseUrl = 'http://192.168.2.101:8080';

  Future<WaterResponse> postData(WaterResponse waterResponse) async {
    final response = await http.post(baseUrl + url,
        headers: {"Content-type": "application/json"},
        body: waterResponseToJson(waterResponse));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return waterResponseFromJson(responseString);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
