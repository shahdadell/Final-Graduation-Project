// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/model/response/LogOut/LogOutResponse.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AppLocalStorage {
  static late SharedPreferences _preferences;
  static const String userNameKey = 'user_name';
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static bool isTokenExpired() {
    final expiryTimeInMillis = _preferences.getInt('token_expiry');
    if (expiryTimeInMillis == null) return true;

    final currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    return currentTimeInMillis >= expiryTimeInMillis;
  }

  static bool isLoggedIn() {
    String? token = _preferences.getString('token');
    return token != null && token.isNotEmpty;
  }

  static bool isGuest() {
    return _preferences.getBool('is_guest') ?? false;
  }

  static Future<void> setGuestMode(bool isGuest) async {
    await _preferences.setBool('is_guest', isGuest);
    if (isGuest) {
      await _preferences.remove('token');
      await _preferences.remove('token_expiry');
      await _preferences.remove('user_id');

      try {
        await _firebaseMessaging.setAutoInitEnabled(false);
        await _firebaseMessaging.deleteToken();
        print('Push notifications disabled for guest mode');
      } catch (e) {
        print('Error disabling notifications: $e');
      }
    }
  }

  static Future<void> clearGuestMode() async {
    await _preferences.remove('is_guest');

    try {
      await _firebaseMessaging.setAutoInitEnabled(true);
      await _firebaseMessaging.getToken();
      print('Push notifications enabled after guest mode');
    } catch (e) {
      print('Error enabling notifications: $e');
    }
  }

  static Future<void> logout(BuildContext context) async {
    try {
      ApiManager apiManager = ApiManager.getInstance();
      LogOutResponse response = await apiManager.logout();

      if (response.status == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Logged out successfully.'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.message ?? 'Failed to logout.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during logout: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      await clearData();
      await clearGuestMode();

      Navigator.pushNamedAndRemoveUntil(
        context,
        SignInScreen.routName,
        (route) => false,
      );
    }
  }

  static Future<void> cacheData(String key, dynamic value) async {
    if (value is String) {
      await _preferences.setString(key, value);
    } else if (value is bool) {
      await _preferences.setBool(key, value);
    } else if (value is int) {
      await _preferences.setInt(key, value);
    } else if (value is double) {
      await _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _preferences.setStringList(key, value);
    }
  }

  static dynamic getData(String key) {
    if (key == 'user_id') {
      var value = _preferences.getInt(key);
      if (value == null) {
        var stringValue = _preferences.getString(key);
        if (stringValue != null) {
          value = int.tryParse(stringValue);
          if (value != null) {
            _preferences.setInt(key, value);
            _preferences.remove(key);
          }
        }
      }
      return value;
    }
    return _preferences.get(key);
  }

  static Future<void> cacheCart(Map<String, dynamic> cartData) async {
    await cacheData('cached_cart', jsonEncode(cartData));
  }

  static Map<String, dynamic>? getCachedCart() {
    final cartJson = getData('cached_cart');
    if (cartJson != null) {
      return jsonDecode(cartJson);
    }
    return null;
  }

  static Future<void> removeData(String key) async {
    await _preferences.remove(key);
  }

  static Future<void> clearData() async {
    final notifications = getData('notifications');
    await _preferences.clear();
    if (notifications != null) {
      await cacheData('notifications', notifications);
    }
  }
}
