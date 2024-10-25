import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class CSHttpClient {
 static const String _baseUrl = APIConstants.BASE_URL;

 // helper method to make GET request
 static Future<Map<String, dynamic>> get(String endPoint) async {
   final response = await http.get(Uri.parse('$_baseUrl/$endPoint'));
   return _handleResponse(response);
 }
 static Future<Map<String, dynamic>> post( String endPoint, dynamic data) async {
   final response = await http.post(Uri.parse('$_baseUrl/$endPoint'),
       headers: {'Content-Type': 'application/json'},
       body: json.encode(data));
   return _handleResponse(response);
 }
 static Future<Map<String, dynamic>> put (String endPoint, dynamic data) async {
  final response = await http.put(
      Uri.parse('$_baseUrl/$endPoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data)
    );
  return _handleResponse(response);
 }
 static Future<Map<String, dynamic>> delete(String endPoint) async {
   final response = await http.delete(Uri.parse('$_baseUrl/$endPoint'));
   return _handleResponse(response);
 }
 // handle response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data:${response.statusCode}');
    }
  }
}