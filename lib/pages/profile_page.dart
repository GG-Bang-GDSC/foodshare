// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/auth_controller.dart';
import 'package:foodshare/data/local_database.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variables
  LocalDatabase db = LocalDatabase();
  AuthController authController = AuthController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 45, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(43, 192, 159, 1),
                image: DecorationImage(
                  image: AssetImage(
                    "assets/profile_bg.png",
                  ),
                  fit: BoxFit.cover
                )
              ),
              child: FutureBuilder(
                future: authController.getUserData(_auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                      print("Error: ${snapshot.error}");
                  }
                  if(snapshot.hasData){
                      return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data!.profilePhoto == null ? "https://register.user.mpkjateng.com/assets/images/user.jpg" : snapshot.data!.profilePhoto
                              ),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text(
                          snapshot.data!.fullName == null ? "Anonymous" : snapshot.data!.fullName,
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(height: 0,);
                  }
                }
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.15), width: 1)
                )
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await Navigator.pushNamed(context, "/viewprofilepage");
                    },
                    child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/profile_icon.svg",
                          ),
                          SizedBox(width: 25,),
                          Text(
                            "View profile",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w700,
                              fontSize: 17
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
			  padding: EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/offer_icon.svg",
                        ),
                        SizedBox(width: 25,),
                        Text(
                          "Voucher/offers",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/donationpage");
                    },
                    child: Container(
                            padding: EdgeInsets.symmetric(vertical: 11),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/donation.svg",
                          ),
                          SizedBox(width: 25,),
                          Text(
                            "Donation",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w700,
                              fontSize: 17
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "/sdgcontributionpage");
                    },
                    child: Container(
                            padding: EdgeInsets.symmetric(vertical: 11),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/fish_outlined.svg",
                          ),
                          SizedBox(width: 25,),
                          Text(
                            "Your contribution for SDG",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w700,
                              fontSize: 17
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
			  padding: EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/location_icon.svg",
                        ),
                        SizedBox(width: 25,),
                        Text(
                          "Adresses",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
			  padding: EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/order.svg",
                        ),
                        SizedBox(width: 25,),
                        Text(
                          "Orders",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
			  padding: EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/help_icon.svg",
                        ),
                        SizedBox(width: 25,),
                        Text(
                          "Help center",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
			              padding: EdgeInsets.symmetric(vertical: 11),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/gift_icon.svg",
                        ),
                        SizedBox(width: 25,),
                        Text(
                          "Invite friends",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20,  top: 0, bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 17
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Terms & Condition / Privacy",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 17
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        title: Text(
                          "Logout Confirmation",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 18,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        content: Text(
                          "Are you sure you want to log out?",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 15
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1),
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Text(
                                    "Cancel",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 15,
                                      color: Color.fromRGBO(43, 192, 159, 1),
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  authController.signOut();
                                  Navigator.pushNamed(context, "/signinpage");
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(43, 192, 159, 1),
                                    borderRadius: BorderRadius.circular(100)
                                  ),
                                  child: Text(
                                    "Logout",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                      }
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Log out",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700,
                          fontSize: 17
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}