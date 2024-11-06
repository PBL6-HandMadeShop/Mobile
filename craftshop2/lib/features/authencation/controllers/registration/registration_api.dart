import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../utils/constants/api_constants.dart';


class CSHttpClient {
  static const String _baseUrl = APIConstants.BASE_URL;

  static Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/${APIConstants.REGISTER}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

}