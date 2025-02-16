import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class SBCustomErrorHandler {
  SBCustomErrorHandler._();

  static void handleErrorResponse(Map<String, dynamic> responseData, String defaultMessage) {
    final errorMessage = responseData['message'] ?? defaultMessage;
    SBHelperFunctions.showErrorSnackbar("error $errorMessage");
  }

  static void handleAuthError(dynamic error) {
    SBHelperFunctions.showErrorSnackbar("error ${error is Exception ? error.toString() : 'authentication failed'}");
  }
}