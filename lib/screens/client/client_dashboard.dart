import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_appointment_booking_system/common/styles/spacing_styles.dart';
import 'package:saloon_appointment_booking_system/common/widgets/custom_text_button.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';
import 'package:saloon_appointment_booking_system/screens/user_profile/profile/user_profile_screen.dart';
import 'package:saloon_appointment_booking_system/services/storage_service.dart';
import 'package:saloon_appointment_booking_system/utils/helper/helper_functions.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
  UserModel? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = await StorageService.getUser();
    setState(() {
      _currentUser = user;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_currentUser == null) {
      return const Center(child: Text("User data not found"));
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: SBSpacingStyle.paddingMainLayout,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Client ${SBHelperFunctions.getFirstName(_currentUser!.name)},",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Find the service you want, and treat yourself',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              CustomTextButton(
                btnText: "Profile",
                onPressed: () => Get.to(const UserProfileScreen()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
