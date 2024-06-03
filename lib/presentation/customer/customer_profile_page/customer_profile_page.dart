import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laborlink/models/shared_preferences.dart';
import 'package:laborlink/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/image_constant.dart';
import '../../../core/utils/size_utils.dart';
import '../../../models/authentication.dart';
import '../../../theme/custom_text_style.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/app_bar/appbar_image.dart';
import '../../../widgets/app_bar/appbar_image_1.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  String userImage = '';
  String userEmail = "";
  String userName = "";

  static FirebaseAuth authInstance = FirebaseAuth.instance;
  static User get userInstance => authInstance.currentUser!;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: appTheme.whiteA70001,
      appBar: CustomAppBar(
        centerTitle: true,
        title: AppbarTitle(text: "Profile"),
      ),
      body: Center(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                imageUrl: userInstance.photoURL.toString(),
              ),
            ),
            SizedBox(
              height: mediaQuery.size.height * 0.02,
              width: mediaQuery.size.width * 0.4,
            ),
            Text(
              userInstance.displayName!,
              style: CustomTextStyles.titleSmallBluegray400_1,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(darkPurple),
                foregroundColor: const MaterialStatePropertyAll(Colors.white),
              ),
              child: Text('Sign Out'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Authentication.signOutFromGoogle();
                Get.offAndToNamed(AppRoutes.customerLogin);
              },
            ),
          ],
        ),
      ),
    );
  }
}
