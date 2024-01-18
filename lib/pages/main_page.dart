// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/pages/community_page.dart';
import 'package:foodshare/pages/home_page.dart';
import 'package:foodshare/pages/profile_page.dart';
import 'package:foodshare/pages/search_page.dart';
import 'package:foodshare/pages/shopping_page.dart';
import 'package:foodshare/pages/signin_page.dart';
import 'package:foodshare/pages/signup_page.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Variables
  List screens = [
    HomePage(),
    ShoppingPage(),
    CommunityPage(),
    ProfilePage()
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, -2),
            ),
          ], 
        ),
        child: CurvedNavigationBar(
          onTap: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Color.fromRGBO(43, 192, 159, 1),
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(
              Icons.home_outlined,
              size: 26,
              color: _selectedIndex == 0 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              size: 26,
              color: _selectedIndex == 1 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.groups_2_outlined,
              size: 26,
              color: _selectedIndex == 2 ? Colors.white : Colors.black,
            ),
            Icon(
              Icons.person_2_outlined,
              size: 26,
              color: _selectedIndex == 3 ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
      body: screens[_selectedIndex],
    );
  }
}