import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';

class BottomBarCustomer extends StatefulWidget {
  BottomBarCustomer({this.onChanged});

  Function(CustomerBottomBarEnum)? onChanged;

  @override
  BottomBarCustomerState createState() => BottomBarCustomerState();
}

class BottomBarCustomerState extends State<BottomBarCustomer> {
  int selectedIndex = 0;

  List<CustomerBottomMenuModel> bottomMenuList = [
    CustomerBottomMenuModel(
      icon: ImageConstant.imgNavhome,
      activeIcon: ImageConstant.imgNavhome,
      title: "Home",
      customerType: CustomerBottomBarEnum.Home,
    ),
    CustomerBottomMenuModel(
      icon: ImageConstant.imgNavmessage,
      activeIcon: ImageConstant.imgNavmessage,
      title: "Message",
      customerType: CustomerBottomBarEnum.Message,
    ),
    CustomerBottomMenuModel(
      icon: ImageConstant.imgCalendar,
      activeIcon: ImageConstant.imgCalendar,
      title: "Book",
      customerType: CustomerBottomBarEnum.Book,
    ),
    CustomerBottomMenuModel(
      icon: ImageConstant.imgNavprofile,
      activeIcon: ImageConstant.imgNavprofile,
      title: "Profile",
      customerType: CustomerBottomBarEnum.Profile,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getVerticalSize(88),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.08),
            spreadRadius: getHorizontalSize(2),
            blurRadius: getHorizontalSize(2),
            offset: Offset(
              0,
              -4,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: bottomMenuList[index].icon,
                  height: getSize(24),
                  width: getSize(24),
                  color: appTheme.blueGray300,
                ),
                Padding(
                  padding: getPadding(
                    top: 3,
                  ),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.labelLargeInterBluegray300.copyWith(
                      color: appTheme.blueGray300,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomImageView(
                  svgPath: bottomMenuList[index].activeIcon,
                  height: getSize(24),
                  width: getSize(24),
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: getPadding(
                    top: 2,
                  ),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.labelLargeInterPrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].customerType);
          setState(() {});
        },
      ),
    );
  }
}

enum CustomerBottomBarEnum {
  Home,
  Message,
  Book,
  Profile,
}

class CustomerBottomMenuModel {
  CustomerBottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.customerType,
  });

  String icon;

  String activeIcon;

  String? title;

  CustomerBottomBarEnum customerType;
}

class CustomerDefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
