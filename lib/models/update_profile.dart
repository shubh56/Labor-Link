import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/models/shared_preferences.dart';

class UpdateProfile {
  CollectionReference workers =
      FirebaseFirestore.instance.collection('workers');
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  updateSpecilization(
      {required BuildContext context,
      required List<String> specilization}) async {
    String specilizationString = "";

    specilizationString = specilization.join(', ');
    String? data = await PreferenceManager.getEmail();
    await workers.doc(data).update({'specialization': specilizationString});
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadImageToFirebaseStorage(
      String folder, String filename, dynamic file) async {
    Reference ref = storage.ref().child('$folder/$filename');
    await ref.putFile(file);
    return ref.getDownloadURL();
  }

  Future<void> uploadImagesAndSaveURLs(
      dynamic profilePhoto, dynamic aadharCard) async {
    String? data = await PreferenceManager.getEmail();
    String profilePhotoURL = await uploadImageToFirebaseStorage(
        'profile_photos', '$data-profilePhoto.jpg', profilePhoto);
    String aadharCardURL = await uploadImageToFirebaseStorage(
        'aadhar_cards', '$data-aadharCard.jpg', aadharCard);

    await firestore.collection('workers').doc(data).update({
      'profilePhoto': profilePhotoURL,
      'addharImage': aadharCardURL,
      // Other user data
    });
  }
}
