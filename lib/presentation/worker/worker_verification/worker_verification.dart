import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/models/update_profile.dart';
import 'package:laborlink/presentation/worker/speciallization_screen/speciallization_screen.dart';

class FacialVerification extends StatefulWidget {
  @override
  _FacialVerificationState createState() => _FacialVerificationState();
}

class _FacialVerificationState extends State<FacialVerification> {
  File? image1;
  File? image2;
  final picker = ImagePicker();

  Future getImage(int imageNumber) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        if (imageNumber == 1) {
          image1 = File(pickedFile.path);
        } else {
          image2 = File(pickedFile.path);
        }
      }
    });
  }

  Future<void> sendImages() async {
    if (image1 != null && image2 != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.29.57:5000/verification'), // Replace with your server address
      );

      // Add images to the request
      request.files.add(
        await http.MultipartFile.fromPath('image1', image1!.path),
      );
      request.files.add(
        await http.MultipartFile.fromPath('image2', image2!.path),
      );

      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          // Parse the response
          var responseData = await response.stream.bytesToString();
          var result = json.decode(responseData);
          print("Hello");
          // Display the result
          if (result['result'] == "Similarity in facial features detected") {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  iconColor: Colors.white,
                  title: Text(
                    'Face Similarity Result',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  content: Text(result['result']),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        updateProfileImages();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => SpeciallizationScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black,
                  iconColor: Colors.white,
                  title: Text(
                    'Face Similarity Result',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  content: Text(result['result']),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          // Handle error
          print('Failed to send images. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error sending images: $e');
      }
    } else {
      // Inform the user to select two images
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text('Error',style: TextStyle(
              color: Colors.white,
            ),),
            content: Text('Please select two images.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK',style: TextStyle(
                  color: Colors.white,
                ),),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: darkPurple,
        centerTitle: true,
        title: Text(
          'Face Similarity Checker',
          style: TextStyle(color: Colors.white, fontFamily: 'Inter', fontSize: Get.height*0.02,),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(Get.height*0.02,),
              child: Text(
                textAlign: TextAlign.center,
                'Face Verification is compulsory for registering as a worker on LaborLink',
                style: TextStyle(
                  color: darkPurple,
                  fontSize: Get.height*0.03,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    if (image1 != null)
                      Image.file(
                        image1!,
                        width: Get.width*0.4,
                        height: Get.height*0.4,
                        fit: BoxFit.cover,
                      ),
                    SizedBox(height: Get.height*0.02,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(darkPurple),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: Get.height*0.03,horizontal: Get.width*0.03,),),
                      ),
                      onPressed: () => getImage(1),
                      child: Text('Select Image 1',style:TextStyle(
                        color: Colors.white,
                        fontSize: Get.height*0.02,
                        fontFamily: 'Inter',
                      ),),
                    ),
                  ],
                ),
                SizedBox(width: Get.width*0.05,),
                Column(
                  children: [
                    if (image2 != null)
                      Image.file(
                        image2!,
                        width: Get.width*0.4,
                        height: Get.height*0.4,
                        fit: BoxFit.fill,
                      ),
                    SizedBox(height: Get.height*0.02),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: Get.height*0.03,horizontal: Get.width*0.03,),),
                        backgroundColor: MaterialStatePropertyAll(darkPurple),
                      ),
                      onPressed: () => getImage(2),
                      child: Text('Select Image 2',style:TextStyle(
                        color: Colors.white,
                        fontSize: Get.height*0.02,
                        fontFamily: 'Inter',
                      ),),
                    ),
                  ],
                ),

              ],
            ),
            SizedBox(height: Get.height*0.03,),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: Get.height*0.03,horizontal: Get.width*0.03,),),
                backgroundColor: MaterialStatePropertyAll(darkPurple),
              ),
              onPressed: sendImages,
              child: Text('Check Face Similarity',style:TextStyle(
                color: Colors.white,
                fontSize: Get.height*0.02,
                fontFamily: 'Inter',
              ),),
            ),
          ],

        ),

      ),
    );
  }

  updateProfileImages() async {
    UpdateProfile updater =
        UpdateProfile(); // Create an instance of UpdateProfile
    await updater.uploadImagesAndSaveURLs(image1, image2);
  }
}
