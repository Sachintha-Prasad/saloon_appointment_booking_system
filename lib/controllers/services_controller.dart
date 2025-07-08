import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/models/service_model.dart';
import 'package:saloon_appointment_booking_system/services/api_service.dart';
import 'package:saloon_appointment_booking_system/services/secure_storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';
import 'package:http/http.dart' as http;

class ServicesController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();


  final RxBool isLoading = true.obs;
  final RxList<ServiceModel> servicesList =  <ServiceModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    fetchServicesData();
  }

  // fetch services
  Future<void> fetchServicesData() async {
    try {
      final token = await SecureStorageService.getToken();

    final response  = await http.get(
          Uri.parse('${apiService.baseUrl}/services'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );


      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        List<ServiceModel> services = (responseData as List)
            .map((json) => ServiceModel.fromJson(json))
            .toList();
        servicesList.assignAll(services);
        isLoading.value = false;
      } else {
        debugPrint("error: ${response.body}");
        isLoading.value = false;
        SBHelperFunctions.showErrorSnackbar("error: ${response.statusCode}");
      }
    } catch (err) {
      SBHelperFunctions.showErrorSnackbar("error fetching services: $err");
    }
  }

}