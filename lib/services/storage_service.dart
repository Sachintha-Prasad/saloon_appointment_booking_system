import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:saloon_appointment_booking_system/models/user_model.dart';

class StorageService{
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'authToken';
  static const _userKey = 'currentUser';
  static const _themeKey = 'themeMode';
  
  // token operations
  static Future<void> saveToken(String token) async => (
    await _storage.write(key: _tokenKey, value: token)
  );

  static Future<String?> getToken() async => (
    await _storage.read(key: _tokenKey)
  );

  static Future<void> deleteToken() async => (
    await _storage.delete(key: _tokenKey)
  );
  
  
  // user operations 
  static Future<void> saveUser(UserModel user) async => (
    await _storage.write(key: _userKey, value: jsonEncode(user.toJson()))
  );

  static Future<UserModel?> getUser() async {
    final userString = await _storage.read(key: _userKey);
    return userString != null
      ? UserModel.fromJson(jsonDecode(userString))
      : null;
  }
  
  static Future<void> deleteUser() async => (
    await _storage.delete(key: _userKey)
  );

  // theme operations
  static Future<void> setTheme(String themeMode) async => (
    await _storage.write(key: _themeKey, value: themeMode)
  );

  static Future<String?> getTheme() async  {
    return await _storage.read(key: _themeKey);
  }
}