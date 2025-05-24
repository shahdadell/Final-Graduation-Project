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

  // دالة للتحقق من انتهاء التوكن
  static bool isTokenExpired() {
    final expiryTimeInMillis = _preferences.getInt('token_expiry');
    if (expiryTimeInMillis == null)
      return true; // لو مفيش وقت انتهاء، اعتبر التوكن منتهي

    final currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    return currentTimeInMillis >= expiryTimeInMillis;
  }

  // دالة للتحقق إذا كان المستخدم مسجل دخول
  static bool isLoggedIn() {
    String? token = _preferences.getString('token');
    return token != null && token.isNotEmpty;
  }

  // دالة للتحقق إذا كان المستخدم في وضع الـ Guest
  static bool isGuest() {
    return _preferences.getBool('is_guest') ?? false;
  }

  // دالة لتفعيل وضع الـ Guest
  static Future<void> setGuestMode() async {
    await _preferences.setBool('is_guest', true);
    // امسحي كل البيانات المتعلقة بالـ session فقط (مش الإشعارات)
    await _preferences.remove('token');
    await _preferences.remove('token_expiry');
    await _preferences.remove('user_id');

    // إيقاف الـ push notifications
    try {
      await _firebaseMessaging
          .setAutoInitEnabled(false); // إيقاف الإشعارات التلقائية
      await _firebaseMessaging.deleteToken(); // حذف الـ FCM token
      print('Push notifications disabled for guest mode');
    } catch (e) {
      print('Error disabling notifications: $e');
    }
  }

  // دالة لإلغاء وضع الـ Guest
  static Future<void> clearGuestMode() async {
    await _preferences.remove('is_guest');

    // إعادة تفعيل الإشعارات
    try {
      await _firebaseMessaging.setAutoInitEnabled(true);
      await _firebaseMessaging.getToken(); // إعادة توليد الـ FCM token
      print('Push notifications enabled after guest mode');
    } catch (e) {
      print('Error enabling notifications: $e');
    }
  }

  // دالة لعمل logout
  static Future<void> logout(BuildContext context) async {
    try {
      // استدعاء الـ logout API
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
      // امسحي البيانات في كل الحالات
      await clearData();
      await clearGuestMode(); // نتأكد إن وضع الـ Guest يتم إلغاؤه لو كان مفعل

      // انقلي المستخدم لشاشة تسجيل الدخول
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
