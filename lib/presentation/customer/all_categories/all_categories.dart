import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laborlink/core/app_export.dart';

class AllCategories extends StatefulWidget {
  const AllCategories({super.key});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  List<String> items = [
    "Carpenter",
    "Plumber",
    "Electrician",
    "Welder",
    "Delivery boy",
    "Mason",
    "Painter",
    "Driver",
    "Maid",
    "Nurse",
    "Cook",
    "Massager",
    "Office Boy",
    "Watchman",
    "AC technicians",
    "Water filtration technician",
    "Scrap dealer"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.whiteA70001,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: darkPurple,
          ),
          onPressed: () {
            Get.offAndToNamed(AppRoutes.customerBottom);
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'All Categories',
          style: TextStyle(
            color: darkPurple,
            fontSize: Get.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: Get.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.03,
              ),
              Text(
                'Workers in multiple ',
                style: TextStyle(
                  color: darkPurple,
                  fontSize: Get.height * 0.03,
                  fontFamily: 'Poppins',
                ),
              ),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    'categories',
                    textStyle: TextStyle(
                      color: darkPurple,
                      fontSize: Get.height * 0.03,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TypewriterAnimatedText(
                    'trades',
                    textStyle: TextStyle(
                      color: darkPurple,
                      fontSize: Get.height * 0.03,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  TypewriterAnimatedText(
                    'locations',
                    textStyle: TextStyle(
                      color: darkPurple,
                      fontSize: Get.height * 0.03,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: Get.height*0.04,),
            height: Get.height*0.7,
            width: Get.height*0.6,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: (){
                    Get.toNamed(AppRoutes.allWorkers, arguments: items[index]);
                  },
                  title: Text(
                    items[index],
                    style: TextStyle(
                      color: darkPurple,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios_sharp, color: darkPurple),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
