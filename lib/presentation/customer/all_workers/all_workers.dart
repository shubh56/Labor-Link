import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import '../../../models/wrokers_model.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/theme_helper.dart';
import '../recommended_workers/widgets/worker_card.dart';

class AllWorkers extends StatefulWidget {
  const AllWorkers({super.key});

  @override
  State<AllWorkers> createState() => _AllWorkersState();
}

class _AllWorkersState extends State<AllWorkers> {
  String category = Get.arguments;

  int randomNumber = Random().nextInt(4)+1;

  List<WorkersModel> list = [];

  final List<WorkersModel> _searchList = [];
  bool _isSearching = false;

  List<WorkersModel> secondList = [];

  Map<String, String> workersMap = {};



  int count = 0;

  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllWorkers() {
    print("Getting worker snapshots");
    return firestoreInstance
        .collection('workers')
        .where(
          'specialization',
        )
        .snapshots();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.back,
            color: darkPurple,
          ),
          onPressed: () {
            Get.offAndToNamed(AppRoutes.allCategories);
          },
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          category,
          style: TextStyle(
            color: darkPurple,
            fontSize: Get.height * 0.03,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            child: StreamBuilder(
              stream: getAllWorkers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    list = data
                            ?.map((e) => WorkersModel.fromJson(e.data()))
                            .toList() ??
                        [];
                    if (list.isNotEmpty) {
                      for (var worker in list) {
                        if (worker.specialization.contains(category.trim())) {
                          secondList.add(worker);
                        }
                      }
                      if(secondList.isEmpty) {
                        return Column(
                          children: [
                            Center(
                              child: Container(
                                height: Get.height*0.4,
                                width: Get.width*0.5,
                                child: Image.asset('assets/images/404_$randomNumber.jpg'),
                              ),
                            ),
                            Text(
                              'Bringing new workers to you ASAP',
                            ),
                          ],
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.only(
                          top: Get.height * 0.01,
                        ),
                        itemCount: secondList.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return WorkerCard(worker: secondList[index]);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                          );
                        },
                      );
                    } else {
                      return const Text(
                        'No Workers Found in this category',
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
