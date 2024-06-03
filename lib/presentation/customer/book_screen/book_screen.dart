import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';

class BookingWorker extends StatefulWidget {
  const BookingWorker({super.key});

  @override
  State<BookingWorker> createState() => _BookingWorkerState();
}

class _BookingWorkerState extends State<BookingWorker> {
  PlatformFile? pickedFile;
  String? containerText;
  String message='';
  String filePath = '';
  bool isVisible = false;
  String recommendedWorker = '';
  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png','jpeg','jpg']);
    setState(() {
      pickedFile = result?.files.first;
      filePath = result!.files.first.path!;
      print(pickedFile?.path);
      containerText = result.files.first.name;
      isVisible = true;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA70001,
      appBar: CustomAppBar(
        centerTitle: true,
        title: AppbarTitle(text: "Book Worker"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: !isVisible,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  child: const Text(
                    'Take a photo of the work required and we will recommend you the best people for the job.',
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Image.file(
                  File(filePath),
                  fit: BoxFit.cover,
                  width: 300,
                  height: 450,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30),
                child: Visibility(
                  visible: isVisible,
                  child: Text(
                    message = (isVisible ? containerText : 'Image Path')!,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: pickFile,
                    child: const Text(
                      'Upload Image',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 30,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: TextButton(
                      onPressed: () {
                          Get.offAndToNamed(AppRoutes.loadingScreen, arguments: [pickedFile,filePath]);
                        },
                      child: const Text(
                        'Analyze Image',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
