import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/models/workers.dart';
import 'package:laborlink/presentation/customer/bottom_bar/bottom_bar.dart';
import 'package:laborlink/presentation/customer/customer_home_screen/widget/services_card.dart';
import 'package:laborlink/presentation/customer/customer_home_screen/widget/workers_card_home_screen.dart';
import 'package:laborlink/presentation/customer/recommended_workers/widgets/worker_card.dart';
import 'package:laborlink/presentation/worker/home_page/widgets/home_item_widget.dart';
import 'package:laborlink/widgets/app_bar/appbar_circleimage.dart';
import 'package:laborlink/widgets/custom_bottom_bar.dart';
import 'package:laborlink/widgets/custom_icon_button.dart';
import 'package:laborlink/widgets/custom_search_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../models/wrokers_model.dart';

// ignore_for_file: must_be_immutable
class CustomerHomePage extends StatelessWidget {
  CustomerHomePage({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  static FirebaseAuth authInstance = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getTopRatedWorkers(int limit) {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      return firestore
          .collection('workers')
          .orderBy('rating', descending: true)
          .limit(limit)
          .snapshots();
    } catch (e) {
      print('Error $e');
      return Stream.empty();
    }
  }

  List list = [];
  List<WorkersModel> _searchList = [];

  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Get.height * 0.02,
                    bottom: Get.height * 0.02,
                    left: Get.width * 0.03,
                    right: Get.width * 0.03,
                  ),
                  child: SearchBar(
                    backgroundColor:
                        MaterialStatePropertyAll(appTheme.whiteA70002),
                    leading: Icon(
                      CupertinoIcons.search,
                      color: darkPurple,
                      size: Get.height * 0.03,
                    ),
                    hintText: 'Search Services...',
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: MySearchDelegate(),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: Get.width * 0.75,
                    top: Get.height * 0.01,
                  ),
                  child: Text(
                    'Services',
                    style: TextStyle(
                      fontSize: Get.height * 0.025,
                      color: darkPurple,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: Get.height * 0.02,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: IntrinsicWidth(
                      child: Row(
                        children: [
                          ServicesCard(
                            serviceName: 'Plumbing Services',
                            imgPath: 'assets/images/services_plumber.jpg',
                          ),
                          ServicesCard(
                            serviceName: 'AC Repair and Services',
                            imgPath: 'assets/images/services_acrepair.jpg',
                          ),
                          ServicesCard(
                            serviceName: 'Electrical Repair',
                            imgPath: 'assets/images/services_electrician.jpg',
                          ),
                          ServicesCard(
                            serviceName: 'Painting',
                            imgPath: 'assets/images/services_painting.jpg',
                          ),
                          ServicesCard(
                            serviceName: 'Carpenters',
                            imgPath: 'assets/images/services_carpenter.jpg',
                          ),
                          ServicesCard(
                            serviceName: 'Stress relief massage',
                            imgPath: 'assets/images/services_massager.jpg',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    right: Get.width * 0.55,
                    top: Get.height * 0.01,
                  ),
                  child: Text(
                    'Top Rated Workers',
                    style: TextStyle(
                      fontSize: Get.height * 0.025,
                      color: darkPurple,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: Get.height * 0.02,
                ),
                // HomeWorkerCard()
                StreamBuilder(
                  stream: getTopRatedWorkers(5),
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
                          return Container(
                            padding: EdgeInsets.all(Get.height * 0.002),
                            height: 200,
                            width: double.infinity,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(
                                top: Get.height * 0.01,
                              ),
                              itemCount: _isSearching
                                  ? _searchList.length
                                  : list.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return HomeWorkerCard(
                                    worker: _isSearching
                                        ? _searchList[index]
                                        : list[index]);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 20,
                                  width: 20,
                                );
                              },
                            ),
                          );
                        } else {
                          //TODO: Beatuify THIS
                          return const Text(
                            'No connections found',
                          );
                        }
                    }
                  },
                ),
                SizedBox(
                  height: Get.height*0.05,
                  width: double.infinity,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: Get.height*0.02,
                      width: Get.width*0.03,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(Get.height*0.04,),),
                          backgroundColor: MaterialStatePropertyAll(appTheme.whiteA70002),
                        ),
                        onPressed: () {
                          Get.toNamed(AppRoutes.allCategories);
                        },
                        child: Text(
                          'View All Workers',
                          style: TextStyle(
                            color: darkPurple,
                            fontSize: Get.height*0.02,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height*0.02,
                      width: Get.width*0.03,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.all(Get.height*0.04,),),
                          backgroundColor: MaterialStatePropertyAll(darkPurple),
                          foregroundColor: MaterialStatePropertyAll(appTheme.whiteA70002),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Book a Worker',
                          style: TextStyle(
                            fontSize: Get.height*0.02,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height*0.02,
                      width: Get.width*0.03,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// showSearch(
// context: context,
// delegate: MySearchDelegate(),
// );

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
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
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: darkPurple,
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: () {
              if (query.isEmpty) {
                FocusManager.instance.primaryFocus
                    ?.unfocus(); //closes on screen keyboard
                close(context, null);
              }
              query = '';
            },
            icon: Icon(CupertinoIcons.multiply, color: darkPurple)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        close(context, null);
      },
      icon: Icon(
        CupertinoIcons.back,
        color: darkPurple,
      ));

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          query,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> Suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: Suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = Suggestions[index];
        return ListTile(
          title: Text(
            suggestion,
            style: TextStyle(
              color: darkPurple,
            ),
          ),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }
}
