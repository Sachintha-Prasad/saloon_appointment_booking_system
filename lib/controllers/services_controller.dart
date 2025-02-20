import 'dart:convert';

import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/service_model.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';
import 'package:http/http.dart' as http;

class ServicesController extends GetxController {
  static ServicesController get instance => Get.find();

  final ApiService _apiService = Get.put(ApiService());

  // service list
  var servicesList =  <ServiceModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit(){
    super.onInit();
    fetchServicesData();
  }

  // fetch services
  Future<void> fetchServicesData() async {
    try {
      final token = await StorageService.getToken();

    final response  = await http.get(
          Uri.parse('${_apiService.baseUrl}/services'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );
      print("API Status Code: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List<ServiceModel> services = (responseData as List)
            .map((json) => ServiceModel.fromJson(json))
            .toList();
        servicesList.assignAll(services);
        isLoading.value = false;
      } else {
        print("Error: ${response.body}");
        isLoading.value = false;
        SBHelperFunctions.showErrorSnackbar("Error: ${response.statusCode}");
      }
    } catch (err) {
      SBHelperFunctions.showErrorSnackbar("Error fetching services: $err");
    }
  }

}