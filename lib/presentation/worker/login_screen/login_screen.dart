import 'package:flutter/material.dart';
import 'package:laborlink/core/app_export.dart';
import 'package:laborlink/models/authentication.dart';
import 'package:laborlink/presentation/worker/enter_otp_screen/enter_otp_screen.dart';
import 'package:laborlink/presentation/worker/home_container_screen/home_container_screen.dart';
import 'package:laborlink/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laborlink/widgets/custom_outlined_button.dart';
import 'package:laborlink/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isFirstLogin = true;
  @override
  void initState() {
    super.initState();
    checkFirstLogin();
  }

  void checkFirstLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isFirstLogin = prefs.getBool('firstLogin') ?? true;
    });
  }

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.whiteA70001,
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        getPadding(left: 24, top: 13, right: 24, bottom: 13),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                              svgPath: ImageConstant.imgGroup162799,
                              height: getSize(24),
                              width: getSize(24),
                              alignment: Alignment.centerLeft,
                              onTap: () {
                                onTapImgImage(context);
                              }),
                          Padding(
                              padding: getPadding(top: 44),
                              child: Text("Hi, Welcome Back! 👋",
                                  style: theme.textTheme.headlineSmall)),
                          Padding(
                              padding: getPadding(top: 11),
                              child: Text("",
                                  style: CustomTextStyles
                                      .titleSmallBluegray400_1)),
                          CustomOutlinedButton(
                              height: getVerticalSize(56),
                              text: "Continue with Google",
                              margin: getMargin(top: 31),
                              onTap: () => {
                                    handleauthentication(context),
                                  },
                              leftIcon: Container(
                                  margin: getMargin(right: 12),
                                  child: CustomImageView(
                                      svgPath: ImageConstant.imgGooglesymbol1)),
                              buttonStyle: CustomButtonStyles.outlinePrimary,
                              buttonTextStyle: theme.textTheme.titleMedium!),
                          CustomOutlinedButton(
                              height: getVerticalSize(56),
                              text: "Continue with Apple",
                              margin: getMargin(top: 16),
                              leftIcon: Container(
                                  margin: getMargin(right: 12),
                                  child: CustomImageView(
                                      svgPath: ImageConstant.imgIconApple)),
                              buttonStyle: CustomButtonStyles.outlinePrimary,
                              buttonTextStyle: theme.textTheme.titleMedium!),
                          Padding(
                              padding: getPadding(left: 33, top: 26, right: 33),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: getPadding(top: 8, bottom: 8),
                                        child: SizedBox(
                                            width: getHorizontalSize(62),
                                            child: Divider())),
                                    Padding(
                                        padding: getPadding(left: 12),
                                        child: Text("Or continue with",
                                            style: CustomTextStyles
                                                .titleSmallBluegray300)),
                                    Padding(
                                        padding: getPadding(top: 8, bottom: 8),
                                        child: SizedBox(
                                            width: getHorizontalSize(74),
                                            child: Divider(
                                                indent: getHorizontalSize(12))))
                                  ])),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                  padding: getPadding(top: 28),
                                  child: Text("Email",
                                      style: theme.textTheme.titleSmall))),
                          CustomTextFormField(
                              controller: emailController,
                              margin: getMargin(top: 9),
                              hintText: "Enter your email address",
                              hintStyle:
                                  CustomTextStyles.titleMediumBluegray400,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                              contentPadding: getPadding(
                                  left: 12, top: 15, right: 12, bottom: 15)),
                          CustomElevatedButton(
                              text: "Continue with Email",
                              margin: getMargin(top: 40),
                              buttonStyle: CustomButtonStyles.fillPrimary,
                              onTap: () {
                                onTapContinuewith(context);
                              }),
                          Padding(
                              padding: getPadding(left: 41, top: 26, right: 41),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: getPadding(bottom: 1),
                                        child: Text("Don’t have an account?",
                                            style: CustomTextStyles
                                                .titleMediumBluegray300)),
                                    GestureDetector(
                                        onTap: () {
                                          onTapTxtLargelabelmediu(context);
                                        },
                                        child: Padding(
                                            padding: getPadding(left: 2),
                                            child: Text(" Sign up",
                                                style: theme
                                                    .textTheme.titleMedium)))
                                  ])),
                          Container(
                              width: getHorizontalSize(245),
                              margin: getMargin(
                                  left: 40, top: 84, right: 40, bottom: 5),
                              child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: "By signing up you agree to our ",
                                        style: CustomTextStyles
                                            .titleSmallBluegray400SemiBold),
                                    TextSpan(
                                        text: "Terms",
                                        style: CustomTextStyles
                                            .titleSmallErrorContainer),
                                    TextSpan(
                                        text: " and ",
                                        style: CustomTextStyles
                                            .titleSmallBluegray400SemiBold),
                                    TextSpan(
                                        text: "Conditions of Use",
                                        style: CustomTextStyles
                                            .titleSmallErrorContainer)
                                  ]),
                                  textAlign: TextAlign.center))
                        ])))));
  }

  /// Navigates back to the previous screen.
  ///
  /// This function takes a [BuildContext] object as a parameter, which is used
  /// to navigate back to the previous screen.
  onTapImgImage(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the enterOtpScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [Navigator] widget
  /// to push the named route for the enterOtpScreen.
  onTapContinuewith(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.enterOtpScreen);
  }

  /// Navigates to the signUpCreateAcountScreen when the action is triggered.
  ///
  /// The [BuildContext] parameter is used to build the navigation stack.
  /// When the action is triggered, this function uses the [Navigator] widget
  /// to push the named route for the signUpCreateAcountScreen.
  onTapTxtLargelabelmediu(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpCreateAcountScreen);
  }


  void showDialogue(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context) => Center(child: SizedBox(height: Get.height*0.03, width: Get.width*0.04,child: const CircularProgressIndicator())),
    );
  }

  void hideProgressDialogue(BuildContext context) {
    Navigator.pop(context);
  }


  handleauthentication(BuildContext context) async {
    FirebaseMessagingService _fcmService = FirebaseMessagingService();
    String fcmToken = await _fcmService.getFCMToken();
    User? user = await Authentication.signInWithGoogle(
        context: context, fcmToken: fcmToken);

    if (user != null) {
      print('USer signed in from Worker Log in method');
      hideProgressDialogue(context);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userEmail = prefs.getString('email');
      if (userEmail == null) {
        // Navigate to OTP screen
        prefs.setString('email', user.email.toString());
        Get.toNamed(AppRoutes.enterOtpScreen);
      } else {
        // Navigate to customer home screen
        Get.offAndToNamed(AppRoutes.homeContainerScreen);
      }
    }
  }
}
