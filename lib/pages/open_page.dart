// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/auth_controller.dart';

class OpenPage extends StatefulWidget {
  OpenPage({super.key});

  @override
  State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if(authController.IsLogged()){
        Navigator.pushNamed(context, "/mainpage");
      } else {
        Navigator.pushNamed(context, "/signinpage");
      }
    });
  }

  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/foodshare_logo.svg",
              fit: BoxFit.cover,
              width: 60,
            ),
            Text(
              "FoodShare",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(43, 192, 159, 1),
                fontWeight: FontWeight.w700,
                fontFamily: "Urbanist",
                fontSize: 30
              ),
            )
          ],
        ),
      ),
    );
  }
}