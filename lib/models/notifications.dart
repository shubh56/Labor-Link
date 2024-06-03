import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static Future<void> sendPushNotification(
      String fcmToken, String title, String body) async {
    final String serverKey =
        'AAAADu9qBU4:APA91bHk674ZhwqL_-Rbf3xNmJYinoS0-Gblx0LF3jKrxurf9UFyPKyjE_fLWUW2jLMV5a8vXNsYvRrext0Q2SfB5rNgom38Bku9fudDAFPSlr0BoC0RuYBgCZF8sf2qVTfSLvJC4fCb'; // Your FCM server key
    const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> notificationData = {
      'notification': {'title': title, 'body': body},
      'to': fcmToken,
    };

    final response = await http.post(
      Uri.parse(fcmUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(notificationData),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }

  static void initializeForegroundNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.body}");
      // Handle foreground message here, for example, show a notification
      displayNotification(message);
    });
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID',
        'channel name',
        importance: Importance.max,
        priority: Priority.high,
      );
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics);
      await FlutterLocalNotificationsPlugin().show(
        0,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics,
        payload: 'New Payload',
      );
    } catch (e) {
      print(e);
    }
  }
}
