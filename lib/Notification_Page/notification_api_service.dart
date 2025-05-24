import 'package:dio/dio.dart';
import 'package:graduation_project/API_Services/endpoints.dart';
import 'package:graduation_project/Notification_Page/notification_manager.dart';
import 'package:graduation_project/local_data/shared_preference.dart';

// كلاس لتمثيل الإشعار من الـ API
class ApiNotification {
  final String notificationId;
  final String notificationTitle;
  final String notificationBody;
  final String notificationUserId;
  final String notificationDateTime;

  ApiNotification({
    required this.notificationId,
    required this.notificationTitle,
    required this.notificationBody,
    required this.notificationUserId,
    required this.notificationDateTime,
  });

  factory ApiNotification.fromJson(Map<String, dynamic> json) {
    return ApiNotification(
      notificationId: json['notification_id'].toString(),
      notificationTitle: json['notification_title'],
      notificationBody: json['notification_body'],
      notificationUserId: json['notification_userid'].toString(),
      notificationDateTime: json['notification_datetime'],
    );
  }
}

class NotificationApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: AppEndpoints.baseUrl,
  ));

  // دالة لجلب إشعارات الطلبات باستخدام POST
  static Future<List<ApiNotification>> fetchOrderNotifications() async {
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId == null) {
      throw Exception('User ID not found in local storage');
    }

    final String token = AppLocalStorage.getData('token') ?? '';
    if (token.isEmpty) {
      throw Exception('Token not found in local storage');
    }

    try {
      final response = await _dio.post(
        AppEndpoints.ordersNotifications,
        data: FormData.fromMap({
          'userid': userId.toString(),
        }),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        if (jsonResponse['status'] == 'success') {
          List<dynamic> notificationsJson = jsonResponse['data'];
          return notificationsJson
              .map((json) => ApiNotification.fromJson(json))
              .toList();
        } else {
          throw Exception(
              'Failed to load notifications: ${jsonResponse['status']}');
        }
      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }

  // دالة لتخزين إشعارات الطلبات
  static Future<void> saveApiNotifications() async {
    // لو المستخدم guest، ما نجيبش إشعارات من الـ API
    if (AppLocalStorage.isGuest()) {
      print('Skipping API notifications fetch for guest user');
      return;
    }

    try {
      final apiNotifications = await fetchOrderNotifications();
      for (var apiNotification in apiNotifications) {
        final notification = NotificationModel(
          title: apiNotification.notificationTitle,
          body: apiNotification.notificationBody,
          timestamp: apiNotification.notificationDateTime,
          isFromApi: true,
          pagename: 'refreshorderpending',
        );
        await NotificationManager.saveNotificationFromApi(notification);
      }
    } catch (e) {
      print('Error saving API notifications: $e');
    }
  }

  // دالة للاشتراك في الـ topic وإرسال رسالة ترحيب
  static Future<void> subscribeToWelcomeTopic(int userId) async {
    try {
      final response = await _dio.post(
        AppEndpoints.greetingNewUser,
        data: FormData.fromMap({
          'userid': userId.toString(),
        }),
      );

      if (response.statusCode == 200) {
        print('Successfully subscribed to welcome topic for user $userId');
      } else {
        throw Exception(
            'Failed to subscribe to welcome topic: ${response.statusCode}');
      }
    } catch (e) {
      print('Error subscribing to welcome topic: $e');
    }
  }
}
