import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';

class ServicesCard extends StatefulWidget {
  String serviceName;
  String imgPath;
  ServicesCard({super.key,required this.serviceName, required this.imgPath});

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        Get.height * 0.01,
      ),
      child: Container(
        height: Get.height * 0.25,
        width: Get.width * 0.35,
        child: Column(
          children: [
            SizedBox(
              width: Get.width * 0.35,
              height: Get.height * 0.2,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(Get.width * 0.02),
                  child: Image.asset(widget.imgPath, fit: BoxFit.cover,),),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.only(
                top: Get.height * 0.01,
                left: Get.width * 0.01,
              ),
              child: Text(
                widget.serviceName,
                style: TextStyle(
                  color: darkPurple,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
