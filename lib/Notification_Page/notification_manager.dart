import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'dart:convert';

// كلاس لتمثيل الإشعار
class NotificationModel {
  final String? title;
  final String? body;
  final String? topic;
  final String? pagename;
  final String? pageid;
  final String timestamp;
  final bool isFromApi;
  final String? expiryDate;

  NotificationModel({
    this.title,
    this.body,
    this.topic,
    this.pagename,
    this.pageid,
    required this.timestamp,
    this.isFromApi = false,
    this.expiryDate,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'body': body,
        'topic': topic,
        'pagename': pagename,
        'pageid': pageid,
        'timestamp': timestamp,
        'isFromApi': isFromApi,
        'expiryDate': expiryDate,
      };

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      body: json['body'],
      topic: json['topic'],
      pagename: json['pagename'],
      pageid: json['pageid'],
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
      isFromApi: json['isFromApi'] ?? false,
      expiryDate: json['expiryDate'],
    );
  }
}

class NotificationManager {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  // طلب إذن الإشعارات
  static Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  // الاشتراك في الـ Topics
  static Future<void> subscribeToTopics() async {
    await _firebaseMessaging.subscribeToTopic('allusers');
    print('Subscribed to allusers topic');

    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      final String? previousUserId =
          AppLocalStorage.getData('previous_user_id');
      if (previousUserId != null && previousUserId != userId.toString()) {
        await _firebaseMessaging.unsubscribeFromTopic('users$previousUserId');
        print('Unsubscribed from old topic: users$previousUserId');
      }

      await _firebaseMessaging.subscribeToTopic('users$userId');
      print('Subscribed to users$userId topic');

      await AppLocalStorage.cacheData('previous_user_id', userId.toString());
    }
  }

  // إلغاء الاشتراك من الـ Topics
  static Future<void> unsubscribeFromTopics() async {
    await _firebaseMessaging.unsubscribeFromTopic('allusers');
    print('Unsubscribed from allusers topic');

    final int? userId = AppLocalStorage.getData('user_id');
    if (userId != null) {
      await _firebaseMessaging.unsubscribeFromTopic('users$userId');
      print('Unsubscribed from users$userId topic');
    }
  }

  // تخزين إشعار من FCM
  static Future<void> saveNotification(RemoteMessage message) async {
    final notification = NotificationModel(
      title: message.notification?.title,
      body: message.notification?.body,
      topic: message.data['topic'],
      pagename: message.data['pagename'],
      pageid: message.data['pageid'],
      timestamp: DateTime.now().toIso8601String(),
      isFromApi: false,
      expiryDate: DateTime.now()
          .add(const Duration(days: 7))
          .toIso8601String(), // الإشعار هينتهي بعد 7 أيام
    );

    List<NotificationModel> notifications = await getNotifications();

    bool alreadyExists = notifications.any((n) =>
        n.title == notification.title &&
        n.body == notification.body &&
        n.pagename == notification.pagename);

    if (!alreadyExists) {
      notifications.add(notification);

      notifications.sort((a, b) =>
          DateTime.parse(b.timestamp).compareTo(DateTime.parse(a.timestamp)));

      await AppLocalStorage.cacheData(
        'notifications',
        jsonEncode(notifications.map((n) => n.toJson()).toList()),
      );
    } else {
      print("Notification already exists, skipping save.");
    }
  }

  // تخزين إشعار من الـ API
  static Future<void> saveNotificationFromApi(
      NotificationModel notification) async {
    List<NotificationModel> notifications = await getNotifications();

    bool alreadyExists = notifications.any((n) =>
        n.title == notification.title &&
        n.body == notification.body &&
        n.timestamp == notification.timestamp);

    if (!alreadyExists) {
      notifications.add(notification);

      notifications.sort((a, b) =>
          DateTime.parse(b.timestamp).compareTo(DateTime.parse(a.timestamp)));

      await AppLocalStorage.cacheData(
        'notifications',
        jsonEncode(notifications.map((n) => n.toJson()).toList()),
      );
    } else {
      print("API Notification already exists, skipping save.");
    }
  }

  // استرجاع الإشعارات من الـ local storage مع حذف الإشعارات المنتهية
  static Future<List<NotificationModel>> getNotifications() async {
    final notificationsJson = AppLocalStorage.getData('notifications');
    if (notificationsJson != null) {
      List<dynamic> jsonList = jsonDecode(notificationsJson);
      List<NotificationModel> notifications =
          jsonList.map((json) => NotificationModel.fromJson(json)).toList();

      // احذف إشعارات FCM المنتهية
      notifications = notifications.where((notification) {
        if (notification.isFromApi) {
          return true; // إشعارات API تفضل دايمًا
        } else if (notification.expiryDate != null) {
          final expiryDate = DateTime.parse(notification.expiryDate!);
          return expiryDate
              .isAfter(DateTime.now()); // احتفظ بالإشعارات اللي لسه صالحة
        }
        return false;
      }).toList();

      // أعد تخزين الإشعارات بعد الحذف
      await AppLocalStorage.cacheData(
        'notifications',
        jsonEncode(notifications.map((n) => n.toJson()).toList()),
      );

      return notifications;
    }
    return [];
  }

  // مسح الإشعارات من الـ local storage
  static Future<void> clearNotifications() async {
    await AppLocalStorage.removeData('notifications');
  }
}
