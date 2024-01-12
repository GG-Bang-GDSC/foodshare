// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:foodshare/firebase_options.dart';
import 'package:foodshare/pages/results_page.dart';
import 'package:foodshare/pages/search_page.dart';
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
      home: SearchPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/searchpage": (context) => SearchPage(),
        "/resultspage": (context) => ResultsPage(data: ModalRoute.of(context)!.settings.arguments as String),

      },
    );
  }
}