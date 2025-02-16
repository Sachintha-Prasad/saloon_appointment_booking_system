import 'dart:convert';

import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/constants/base_api_endpoints.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  final String baseUrl = SBBaseApiEndpoints.baseUrl;


  // authenticated GET method
  Future<http.Response> authenticatedGet(String endpoint) async {
    final token = await StorageService.getToken();
    
    return await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    );
  }

  // authenticated POST method
  Future<http.Response> authenticatedPost(String endpoint, dynamic data) async {
    final token = await StorageService.getToken();

    return await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(data)
    );
  }
}