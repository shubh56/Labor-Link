import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:laborlink/core/app_export.dart';




class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key });

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  PlatformFile? pickedFile = Get.arguments[0];
  String filePath = Get.arguments[1];
  String geminiResponse='Plumber';


  Future<void> analyseImage() async{
    if(pickedFile!=null){
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.155.165:5000/getWorkerType'),
      );

      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      try{
        var response = await request.send();
        if(response.statusCode==200){
          var responseData = await response.stream.bytesToString();
          var result = json.decode(responseData);
          print('Hello');
          geminiResponse=result['data'].trim();
          print(geminiResponse);
        }
      }catch(e){
        print('Error: $e');
      }
    }
  }


  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 10), () {
      // After 3 seconds, check authentication status and navigate to the appropriate screen
      analyseImage().then((value) {
        Get.offAndToNamed(AppRoutes.recommendWorkers,arguments: geminiResponse);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA70001,
      body: Center(
        child: Container(
          height: Get.height*0.3,
          width: Get.width*0.6,
          child: Column(
            children: [
              Text('Image analysis in progress'),
              SizedBox(
                height: Get.height*0.05,
                width: double.infinity,
              ),
              LinearProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
