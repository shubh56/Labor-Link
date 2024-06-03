import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laborlink/models/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    return token ?? '';
  }
}


class Authentication {
  static Future<User?> signInWithGoogle(
      {required BuildContext context, required String fcmToken}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference workers =
        FirebaseFirestore.instance.collection('workers');
    CollectionReference customers =
        FirebaseFirestore.instance.collection('customers');
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        String? data = await PreferenceManager.getData();
        print(data.toString());

        if (data != null) {
          print("Hello");
          // Check if the user exists in Firestore
          DocumentSnapshot userDoc;
          if (data == "worker") {
            userDoc = await workers.doc(user!.email).get();
          } else {
            userDoc = await customers.doc(user!.email).get();
          }

          // If the user doesn't exist in Firestore, add them
          if (!userDoc.exists) {
            if (data == "worker") {
              try {
                PreferenceManager.saveEmail(user.email!);
                PreferenceManager.saveName(user.displayName!);
                PreferenceManager.saveToken(fcmToken);
                PreferenceManager.saveImage(user.photoURL.toString());
                print(user.email);
                await workers.doc(user.email).set({
                  'uid': user.uid,
                  'displayName': user.displayName,
                  'email': user.email,
                  'availability': 'Permanant',
                  'specialization': 'Plumbing',
                  'addharImage': '',
                  'profilePhoto': user.photoURL.toString(),
                  'fcmtoken': fcmToken,

                  // Add other user information you want to store
                });
              } catch (e) {
                customSnackBar(content: e.toString());
              }
            } else {
              try {
                PreferenceManager.saveEmail(user.email!);
                PreferenceManager.saveName(user.displayName!);
                PreferenceManager.saveToken(fcmToken);
                PreferenceManager.saveImage(user.photoURL.toString());
                await customers.doc(user.email).set({
                  'uid': user.uid,
                  'profilePhoto': user.photoURL.toString(),
                  'displayName': user.displayName,
                  'email': user.email,
                  'fcmtoken': fcmToken,
                  // Add other user information you want to store
                });
              } catch (e) {
                customSnackBar(content: e.toString());
              }
            }
          } else {
            customSnackBar(content: "User exists");
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          customSnackBar(content: e.toString());
        } else if (e.code == 'invalid-credential') {
          customSnackBar(content: e.toString());
        }
      } catch (e) {
        customSnackBar(content: e.toString());
      }
    }

    return user;
  }



  static Future<void> signOutFromGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }


}

SnackBar customSnackBar({required String content}) {
  return SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      content,
      style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
    ),
  );
}
