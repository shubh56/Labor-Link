import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/presentation/customer/book_screen/book_screen.dart';
import 'package:laborlink/presentation/customer/customer_chat_screen/customer_chat_screen.dart';
import 'package:laborlink/widgets/custom_bottom_bar.dart';

import '../bottom_bar/bottom_bar.dart';
import '../customer_home_screen/customer_home_screen.dart';
import '../customer_profile_page/customer_profile_page.dart';

// ignore_for_file: must_be_immutable
class CustomerBottomBar extends StatelessWidget {
  CustomerBottomBar({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> customernavigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            body: Navigator(
                key: customernavigatorKey,
                initialRoute: AppRoutes.customerHomeScreen,
                onGenerateRoute: (routeSetting) => PageRouteBuilder(
                    pageBuilder: (ctx, ani, ani1) =>
                        getCurrentPage(routeSetting.name!),
                    transitionDuration: Duration(seconds: 0))),
            bottomNavigationBar:
            BottomBarCustomer(onChanged: (CustomerBottomBarEnum customerType) {
              Navigator.pushNamed(
                  customernavigatorKey.currentContext!, getCurrentRoute(customerType));
            })));
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(CustomerBottomBarEnum customerType) {
    switch (customerType) {
      case CustomerBottomBarEnum.Home:
        return AppRoutes.customerHomeScreen;
      case CustomerBottomBarEnum.Message:
        return AppRoutes.customerChat;
      case CustomerBottomBarEnum.Book:
        return AppRoutes.bookJob;
      case CustomerBottomBarEnum.Profile:
        return AppRoutes.customerProfile;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.customerHomeScreen:
        return CustomerHomePage();
      case AppRoutes.customerChat:
        return CustomerChatScreen();
      case AppRoutes.bookJob:
        return BookingWorker();
      case AppRoutes.customerProfile:
        return CustomerProfile();
      default:
        return DefaultWidget();
    }
  }
}
