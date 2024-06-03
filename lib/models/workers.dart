import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/models/notifications.dart';
import 'package:laborlink/models/shared_preferences.dart';

class Workers {
  CollectionReference workers =
      FirebaseFirestore.instance.collection('workers');
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  displayworkers(
      {required BuildContext context, required String category}) async {
    List<DocumentSnapshot> workerList = (await workers.get()).docs;
    for (var docSnapshot in workerList) {
      String? specialization = (docSnapshot.data()
          as Map<String, dynamic>)['specialization'] as String?;
      if (specialization != null) {
        List<String> specializations = specialization.split(', ');
        if (specializations.contains(category)) {
          print(docSnapshot['email']);
        }
      }
    }
  }

  bookworker(
      {required BuildContext context,
      required String email,
      required String price,
      required String location,
      required String time}) async {
    String? token = await PreferenceManager.getToken();
    String fcmToken = token!; // FCM token of the recipient
    String title = 'Test Notification';
    String body = 'This is a test notification sent from Flutter';

    await PushNotificationService.sendPushNotification(fcmToken, title, body);
    String? data = await PreferenceManager.getEmail();
    String? name = await PreferenceManager.getName();
    workers.doc(email).collection('requests').doc(data).set({
      'customer': name,
      'location': location,
      'price': price,
      'time': time,
      'status': 'pending',
    });

    print('success');
  }
}
