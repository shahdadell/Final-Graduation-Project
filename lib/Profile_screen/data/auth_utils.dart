import 'dart:developer';
import 'package:graduation_project/local_data/shared_preference.dart';

class AuthUtils {
  static Future<int?> getUserIdDirectly() async {
    try {
      final userId = await AppLocalStorage.getData('user_id');
      log('Raw userId from AppLocalStorage: $userId, Type: ${userId.runtimeType}');
      if (userId == null) {
        log('User ID is null');
        return null;
      }
      if (userId is String) {
        final parsedUserId = int.tryParse(userId);
        if (parsedUserId == null) {
          log('Failed to parse userId: $userId');
          return null;
        }
        log('Parsed userId: $parsedUserId');
        return parsedUserId;
      }
      if (userId is int) {
        return userId;
      }
      log('Unexpected userId type: ${userId.runtimeType}');
      return null;
    } catch (e) {
      log('Error getting userId: $e');
      return null;
    }
  }
}
