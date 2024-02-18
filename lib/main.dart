// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodshare/firebase_options.dart';
import 'package:foodshare/pages/add_restaurant.dart';
import 'package:foodshare/pages/assesment_page.dart';
import 'package:foodshare/pages/checkout_page.dart';
import 'package:foodshare/pages/donation_page.dart';
import 'package:foodshare/pages/donationpayment_page.dart';
import 'package:foodshare/pages/home_page.dart';
import 'package:foodshare/pages/location_page.dart';
import 'package:foodshare/pages/main_page.dart';
import 'package:foodshare/pages/mycart_page.dart';
import 'package:foodshare/pages/open_page.dart';
import 'package:foodshare/pages/otpverification_page.dart';
import 'package:foodshare/pages/profile_page.dart';
import 'package:foodshare/pages/restaurant_page.dart';
import 'package:foodshare/pages/results_page.dart';
import 'package:foodshare/pages/sdgcontribution_page.dart';
import 'package:foodshare/pages/search_page.dart';
import 'package:foodshare/pages/signin_page.dart';
import 'package:foodshare/pages/signup_page.dart';
import 'package:foodshare/pages/viewprofile_page.dart';
import 'package:foodshare/pages/waiting_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Hive Box
  var box = await Hive.openBox("myBox");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OpenPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/openpage": (context) => OpenPage(),
        "/assesmentpage": (context) => AssesmentPage(),
        "/signuppage": (context) => SignupPage(),
        "/otpverificationpage": (context) => OTPVerificationPage(),
        "/signinpage": (context) => SigninPage(),
        "/mainpage": (context) => MainPage(),
        "/homepage": (context) => HomePage(),
        "/profilepage": (context) => ProfilePage(),
        "/searchpage": (context) => SearchPage(),
        "/resultspage": (context) => ResultsPage(data: ModalRoute.of(context)!.settings.arguments as String),
        "/restaurantpage": (context) => RestaurantPage(data: ModalRoute.of(context)!.settings.arguments as Map),
        "/checkoutpage": (context) => CheckoutPage(data: ModalRoute.of(context)!.settings.arguments as Map),
        "/waitingpage": (context) => WaitingPage(data: ModalRoute.of(context)!.settings.arguments as Map),
        "/mycartpage": (context) => MyCartPage(),
        "/donationpage": (context) => DonationPage(),
        "/donationpaymentpage": (context) => DonationPaymentPage(),
        "/viewprofilepage": (context) => ViewProfilePage(),
        "/sdgcontributionpage": (context) => SDGContributionPage(),
        "/locationpage": (context) => LocationPage(),
      },
    );
  }
}