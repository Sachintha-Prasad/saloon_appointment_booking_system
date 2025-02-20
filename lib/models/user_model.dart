import 'package:saloon_appointment_booking_system/utils/constants/enum.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String mobileNo;
  final String? profileImageUrl;
  final Roles role;

  UserModel({
    this.id,
    required this.email,
    required this.name,
    required this.mobileNo,
    this.profileImageUrl,
    required this.role,
  });
  
  // factory method to read json data
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json["_id"] ?? json["id"],
      email: json["email"] as String,
      name: json["name"] as String,
      mobileNo: json["mobileNo"] as String,
      profileImageUrl: json["profileImageUrl"] as String?,
      role: Roles.values.byName(json["role"] as String),
    );
  }

  // convert UserModel to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "mobileNo": mobileNo,
      "profileImageUrl": profileImageUrl,
      "role": role.name,
    };

    if(id != null) data["_id"] = id;

    return data;
  }
}
