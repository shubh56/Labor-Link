import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laborlink/core/app_export.dart';
import '../../../../models/wrokers_model.dart';
import 'dart:math';

class HomeWorkerCard extends StatefulWidget {
  final WorkersModel worker;
  const HomeWorkerCard({super.key, required this.worker});

  @override
  State<HomeWorkerCard> createState() => _HomeWorkerCardState();
}

class _HomeWorkerCardState extends State<HomeWorkerCard> {
  int randomInt = Random().nextInt(999);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.4,
      width: Get.height * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.height * 0.02),
        color: darkPurple,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(
              Get.height * 0.02,
            ),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    width: Get.height * 0.055,
                    height: Get.height * 0.055,
                    imageUrl: widget.worker.profilePhoto,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                  width: Get.height * 0.02,
                ),
                Text(
                  widget.worker.displayName,
                  style: TextStyle(
                    color: appTheme.whiteA70002,
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.worker.rating} ⭐ ${widget.worker.specialization.trim()}',
                  style: TextStyle(
                    color: appTheme.whiteA70002,
                    fontSize: Get.height * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$randomInt meters away from you',
                  style: TextStyle(
                    color: appTheme.whiteA70002,
                    fontSize: Get.height * 0.015,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: Get.height * 0.02,
                    left: Get.height * 0.02,
                    right: Get.height * 0.02,
                    bottom: Get.height * 0.02,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.all(
                          Get.height * 0.03,
                        ),
                      ),
                      backgroundColor: MaterialStatePropertyAll(appTheme.whiteA70002),
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.allWorkers);
                    },
                    child: Text(
                      'View Worker',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Get.height * 0.016,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
