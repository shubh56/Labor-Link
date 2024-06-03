import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laborlink/presentation/worker/home_page/widgets/booking_card.dart';
import 'package:laborlink/presentation/worker/profile_page/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/bookings.dart';
import '../home_page/widgets/home_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/widgets/app_bar/appbar_circleimage.dart';
import 'package:laborlink/widgets/app_bar/appbar_image_1.dart';
import 'package:laborlink/widgets/app_bar/appbar_subtitle.dart';
import 'package:laborlink/widgets/app_bar/appbar_subtitle_2.dart';
import 'package:laborlink/widgets/app_bar/custom_app_bar.dart';
import 'package:laborlink/widgets/custom_icon_button.dart';
import 'package:alan_voice/alan_voice.dart';
import 'package:laborlink/widgets/custom_search_view.dart';
import 'package:get/get.dart';
import '../message_page/message_page.dart';
import '../sign_up_create_acount_screen/sign_up_create_acount_screen.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // _HomePageState() {
  //   /// Init Alan Button with project key from Alan AI Studio
  //   AlanVoice.addButton(
  //       "27a47e26729240131b510e602e761dfc2e956eca572e1d8b807a3e2338fdd0dc/stage",
  //       buttonAlign: AlanVoice.BUTTON_ALIGN_RIGHT);
  //
  //   /// Handle commands from Alan AI Studio
  //   AlanVoice.onCommand.add(
  //       (command) => {print(command.toString()), _handleCommand(command.data)});
  // }
  //
  // void _handleCommand(Map<String, dynamic> command) {
  //   switch (command["command"]) {
  //     case "home":
  //       print("Helloooooo");
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => HomePage(),
  //           ));
  //       break;
  //     case "profile":
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => ProfilePage(),
  //           ));
  //       break;
  //     case "chat":
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => MessagePage()),
  //       );
  //       break;
  //     case "bookmarks":
  //       Navigator.pushNamed(context, AppRoutes.savedPage);
  //       break;
  //     case "signup":
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => SignUpCreateAcountScreen()),
  //       );
  //       break;
  //     default:
  //       print("Unknown Command");
  //   }
  // }
  List<Bookings> list = [];
  @override
  void initState() {
    super.initState();
    getWorkerID();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).unfocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();

  /// Init Alan Button with project key from Alan AI Studio

  //Code for getting bookings
  Map<String, String> bookingsMap = {};
  String workerEmail = '';
  void getWorkerID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    workerEmail = pref.getString('email')!;
  }

  static FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getBookings() {
    return firestoreInstance
        .collection('bookings')
        .where('workerId')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    List<Bookings> secondList = [];
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA70001,
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          leadingWidth: getHorizontalSize(74),
          leading: AppbarCircleimage(
            imagePath: ImageConstant.imgImage50x50,
            margin: getMargin(
              left: 24,
            ),
          ),
          title: Padding(
            padding: getPadding(
              left: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppbarSubtitle(
                  text: "Hi, Welcome Back! 👋",
                ),
                AppbarSubtitle2(
                  text: "Find your job",
                  margin: getMargin(
                    top: 9,
                    right: 33,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            AppbarImage1(
              svgPath: ImageConstant.imgNotification,
              margin: getMargin(
                left: 24,
                top: 13,
                right: 24,
                bottom: 13,
              ),
            ),
          ],
        ),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomSearchView(
                  margin: getMargin(
                    left: 24,
                    top: 30,
                    right: 24,
                  ),
                  controller: searchController,
                  hintText: "Search...",
                  hintStyle: CustomTextStyles.titleMediumBluegray400,
                  alignment: Alignment.center,
                  prefix: Container(
                    margin: getMargin(
                      left: 16,
                      top: 17,
                      right: 8,
                      bottom: 17,
                    ),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgSearch,
                    ),
                  ),
                  prefixConstraints: BoxConstraints(
                    maxHeight: getVerticalSize(52),
                  ),
                  suffix: Container(
                    margin: getMargin(
                      left: 30,
                      top: 17,
                      right: 16,
                      bottom: 17,
                    ),
                    child: CustomImageView(
                      svgPath: ImageConstant.imgFilterPrimary,
                    ),
                  ),
                  suffixConstraints: BoxConstraints(
                    maxHeight: getVerticalSize(52),
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 24,
                  top: 25,
                ),
                child: Text(
                  "Upcoming Jobs",
                  style: CustomTextStyles.titleMedium18,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: Get.height * 0.2,
                        width: Get.width * 0.9,
                        child: StreamBuilder(
                            stream: getBookings(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                case ConnectionState.none:
                                  return const Center(
                                      child: CircularProgressIndicator());
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  final data = snapshot.data?.docs;
                                  list = data
                                      ?.map((e) => Bookings.fromJson(e.data()))
                                      .toList() ??
                                      [];
                                  if (list.isNotEmpty) {
                                    for (var booking in list) {
                                      if (booking.workerId.contains(workerEmail)) {
                                        secondList.add(booking);
                                      }
                                    }
                                    return ListView.separated(
                                      padding: EdgeInsets.only(
                                        top: Get.height * 0.01,
                                      ),
                                      itemCount: secondList.length,
                                      physics: BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return BookingCard(booking: secondList[index]);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
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
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: getPadding(
                  left: 24,
                  top: 22,
                ),
                child: Text(
                  "Recent Jobs",
                  style: CustomTextStyles.titleMediumInter,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      left: 24,
                      top: 16,
                      right: 24,
                    ),
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (
                        context,
                        index,
                      ) {
                        return SizedBox(
                          height: getVerticalSize(16),
                        );
                      },
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return HomeItemWidget();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
