import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/presentation/customer/recommended_workers/widgets/worker_card.dart';
import '';

import '../../../models/wrokers_model.dart';
import '../../../theme/theme_helper.dart';


class RecommendedWorkers extends StatefulWidget {
  const RecommendedWorkers({super.key});

  @override
  State<RecommendedWorkers> createState() => _RecommendedWorkersState();
}

class _RecommendedWorkersState extends State<RecommendedWorkers> {

  List<WorkersModel> list = [];


  final List<WorkersModel> _searchList = [];
  bool _isSearching = false;


  String recommendedWorker = '';

  Map<String,String> workersMap = {};

  int count = 0;

  void getData() async{
    recommendedWorker  = Get.arguments;
  }

  @override
  void initState(){
    super.initState();
    getData();
  }
  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  static FirebaseAuth authInstance = FirebaseAuth.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getWorkers() {
    return firestoreInstance
        .collection('workers')
        .where('specialization',)
        .snapshots();
  }


  @override
  Widget build(BuildContext context) {
    List<WorkersModel> secondList = [];
    return Scaffold(
      backgroundColor: appTheme.whiteA70001,
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: Get.height*0.15, right: Get.height*0.03, left: Get.height*0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Our analysis recommends that a(n) ',
                    style: TextStyle(
                      fontSize: Get.height*0.015,
                    ),
                  ),
                  Text(
                    recommendedWorker,
                    style: CustomTextStyles.titleMediumBluegray900,
                  ),
                  Text(
                      ' would be most suitable.',
                      style: TextStyle(
                      fontSize: Get.height*0.015,
                      ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: 10,
                ),
                child: Divider(),
              ),
              Text(
                "Our top rated $recommendedWorker (s)",
                style: CustomTextStyles.titleMediumBold,
              ),
              StreamBuilder(stream: getWorkers(),
                  builder: (context, snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.active:
                  case ConnectionState.done:
                    final data = snapshot.data?.docs;
                    list=data
                    ?.map((e) => WorkersModel.fromJson(e.data()))
                    .toList() ?? [];
                    if (list.isNotEmpty) {
                      for(var worker in list){
                        if(worker.specialization.contains(recommendedWorker)){
                          secondList.add(worker);
                        }
                      }
                      return ListView.separated(
                        padding: EdgeInsets.only(
                          top: Get.height * 0.01,
                        ),
                        itemCount:
                        _isSearching ? _searchList.length : secondList.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return WorkerCard(
                              worker: _isSearching
                                  ? _searchList[index]
                                  : secondList[index]);
                        }, separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                          );
                      },
                      );

                    } else {
                      //TODO: Beatuify THIS
                      return Text(
                        'No connections found',
                      );
                    }
                }
              })
            ],
          ),
        ),
      )
    );
  }
}
