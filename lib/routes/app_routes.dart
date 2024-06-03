import 'package:flutter/material.dart';
import 'package:laborlink/presentation/customer/all_categories/all_categories.dart';
import 'package:laborlink/presentation/customer/book_screen/book_screen.dart';
import 'package:laborlink/presentation/customer/customer_bottom_bar/customer_bottom_bar.dart';
import 'package:laborlink/presentation/customer/customer_chat_screen/customer_chat_screen.dart';
import 'package:laborlink/presentation/customer/customer_login_screen/customer_login_screen.dart';
import 'package:laborlink/presentation/customer/customer_profile_page/customer_profile_page.dart';
import 'package:laborlink/presentation/customer/loading_screen/loading_screen.dart';
import 'package:laborlink/presentation/customer/recommended_workers/recommended_workers.dart';
import 'package:laborlink/presentation/customer/scheduling/payments.dart';
import 'package:laborlink/presentation/worker/splash_screen/splash_screen.dart';
import 'package:laborlink/presentation/worker/onboarding_one_screen/onboarding_one_screen.dart';
import 'package:laborlink/presentation/worker/onboarding_two_screen/onboarding_two_screen.dart';
import 'package:laborlink/presentation/worker/onboarding_three_screen/onboarding_three_screen.dart';
import 'package:laborlink/presentation/worker/sign_up_create_acount_screen/sign_up_create_acount_screen.dart';
import 'package:laborlink/presentation/worker/sign_up_complete_account_screen/sign_up_complete_account_screen.dart';
import 'package:laborlink/presentation/worker/job_type_screen/job_type_screen.dart';
import 'package:laborlink/presentation/worker/speciallization_screen/speciallization_screen.dart';
import 'package:laborlink/presentation/worker/select_a_country_screen/select_a_country_screen.dart';
import 'package:laborlink/presentation/worker/login_screen/login_screen.dart';
import 'package:laborlink/presentation/worker/enter_otp_screen/enter_otp_screen.dart';
import 'package:laborlink/presentation/worker/home_container_screen/home_container_screen.dart';
import 'package:laborlink/presentation/worker/search_screen/search_screen.dart';
import 'package:laborlink/presentation/worker/job_details_tab_container_screen/job_details_tab_container_screen.dart';
import 'package:laborlink/presentation/worker/message_action_screen/message_action_screen.dart';
import 'package:laborlink/presentation/worker/chat_screen/chat_screen.dart';
import 'package:laborlink/presentation/worker/apply_job_screen/apply_job_screen.dart';
import 'package:laborlink/presentation/worker/notifications_my_proposals_tab_container_screen/notifications_my_proposals_tab_container_screen.dart';
import 'package:laborlink/presentation/worker/settings_screen/settings_screen.dart';
import 'package:laborlink/presentation/worker/personal_info_screen/personal_info_screen.dart';
import 'package:laborlink/presentation/worker/experience_setting_screen/experience_setting_screen.dart';
import 'package:laborlink/presentation/worker/new_position_screen/new_position_screen.dart';
import 'package:laborlink/presentation/worker/add_new_education_screen/add_new_education_screen.dart';
import 'package:laborlink/presentation/worker/privacy_screen/privacy_screen.dart';
import 'package:laborlink/presentation/worker/language_screen/language_screen.dart';
import 'package:laborlink/presentation/worker/notifications_screen/notifications_screen.dart';
import 'package:laborlink/presentation/worker/app_navigation_screen/app_navigation_screen.dart';
import 'package:laborlink/presentation/worker/worker_verification/worker_verification.dart';

import '../presentation/customer/all_workers/all_workers.dart';
import '../presentation/customer/customer_home_screen/customer_home_screen.dart';
import '../presentation/customer/scheduling/scheduling.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';

  static const String onboardingOneScreen = '/onboarding_one_screen';
  static const String customerHomeScreen = '/customer_home';

  static const String onboardingTwoScreen = '/onboarding_two_screen';

  static const String onboardingThreeScreen = '/onboarding_three_screen';

  static const String signUpCreateAcountScreen =
      '/sign_up_create_acount_screen';

  static const String signUpCompleteAccountScreen =
      '/sign_up_complete_account_screen';

  static const String jobTypeScreen = '/job_type_screen';

  static const String speciallizationScreen = '/speciallization_screen';

  static const String selectACountryScreen = '/select_a_country_screen';

  static const String loginScreen = '/login_screen';

  static const String enterOtpScreen = '/enter_otp_screen';

  static const String homePage = '/home_page';

  static const String homeContainerScreen = '/home_container_screen';

  static const String searchScreen = '/search_screen';

  static const String jobDetailsPage = '/job_details_page';

  static const String jobDetailsTabContainerScreen =
      '/job_details_tab_container_screen';

  static const String messagePage = '/message_page';

  static const String messageActionScreen = '/message_action_screen';

  static const String chatScreen = '/chat_screen';

  static const String savedPage = '/saved_page';

  static const String savedDetailJobPage = '/saved_detail_job_page';

  static const String applyJobScreen = '/apply_job_screen';

  static const String appliedJobPage = '/applied_job_page';

  static const String notificationsGeneralPage = '/notifications_general_page';

  static const String notificationsMyProposalsPage =
      '/notifications_my_proposals_page';

  static const String notificationsMyProposalsTabContainerScreen =
      '/notifications_my_proposals_tab_container_screen';

  static const String profilePage = '/profile_page';

  static const String settingsScreen = '/settings_screen';

  static const String personalInfoScreen = '/personal_info_screen';

  static const String experienceSettingScreen = '/experience_setting_screen';

  static const String newPositionScreen = '/new_position_screen';

  static const String addNewEducationScreen = '/add_new_education_screen';

  static const String privacyScreen = '/privacy_screen';

  static const String languageScreen = '/language_screen';

  static const String notificationsScreen = '/notifications_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String facialVerification = '/worker_verification';

  //Customer Side

  static const String customerLogin = '/customer_login_screen';

  static const String customerBottom = '/customer_bottom_bar';

  static const String customerChat = '/customer_chat_screen';

  static const String bookJob =  '/book_job_screen';

  static const String customerProfile = '/customer_profile';

  static const String recommendWorkers = '/recommended_workers';

  static const String scheduling = '/scheduling';

  static const String payment = '/payment';

  static const String allCategories = '/allCategories';

  static const String allWorkers = '/allWorkers';

  static const String loadingScreen = '/loadingScreen';

  static Map<String, WidgetBuilder> routes = {
    facialVerification: (context) => FacialVerification(),
    splashScreen: (context) => SplashScreen(),
    onboardingOneScreen: (context) => OnboardingOneScreen(),
    onboardingTwoScreen: (context) => OnboardingTwoScreen(),
    onboardingThreeScreen: (context) => OnboardingThreeScreen(),
    signUpCreateAcountScreen: (context) => SignUpCreateAcountScreen(),
    signUpCompleteAccountScreen: (context) => SignUpCompleteAccountScreen(),
    jobTypeScreen: (context) => JobTypeScreen(),
    speciallizationScreen: (context) => SpeciallizationScreen(),
    selectACountryScreen: (context) => SelectACountryScreen(),
    loginScreen: (context) => LoginScreen(),
    enterOtpScreen: (context) => EnterOtpScreen(),
    homeContainerScreen: (context) => HomeContainerScreen(),
    searchScreen: (context) => SearchScreen(),
    jobDetailsTabContainerScreen: (context) => JobDetailsTabContainerScreen(),
    messageActionScreen: (context) => MessageActionScreen(),
    chatScreen: (context) => ChatScreen(),
    applyJobScreen: (context) => ApplyJobScreen(),
    notificationsMyProposalsTabContainerScreen: (context) =>
        NotificationsMyProposalsTabContainerScreen(),
    settingsScreen: (context) => SettingsScreen(),
    personalInfoScreen: (context) => PersonalInfoScreen(),
    experienceSettingScreen: (context) => ExperienceSettingScreen(),
    newPositionScreen: (context) => NewPositionScreen(),
    addNewEducationScreen: (context) => AddNewEducationScreen(),
    privacyScreen: (context) => PrivacyScreen(),
    languageScreen: (context) => LanguageScreen(),
    notificationsScreen: (context) => NotificationsScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),

    //CUSTOMER SIDE

    customerLogin: (context) => CustomerLoginScreen(),
    customerHomeScreen: (context) => CustomerHomePage(),
    customerBottom: (context) => CustomerBottomBar(),
    customerChat: (context) => CustomerChatScreen(),
    bookJob : (context) => BookingWorker(),
    customerProfile: (context) => CustomerProfile(),
    recommendWorkers: (context) => RecommendedWorkers(),
    scheduling: (context)=> Scheduling(),
    payment: (context)=> Payment(),
    allCategories: (context)=> AllCategories(),
    allWorkers: (context)=>AllWorkers(),
    loadingScreen: (context)=> LoadingScreen(),
  };
}
