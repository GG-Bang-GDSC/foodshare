// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodshare/data/controller/auth_controller.dart';
import 'package:foodshare/data/model/user_model.dart';

class SDGContributionPage extends StatefulWidget {
  SDGContributionPage({super.key});

  @override
  State<SDGContributionPage> createState() => _SDGContributionPageState();
}

class _SDGContributionPageState extends State<SDGContributionPage> {
  // Variables
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 60,
        leading: GestureDetector(
          onTap: (){
          Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            FutureBuilder<userModel?>(
              future: authController.getUserData(_auth.currentUser!.uid),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Container(
                    padding: EdgeInsets.only(top: 45, bottom: 30),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: NetworkImage(
                               snapshot.data!.profilePhoto == null ? "https://register.user.mpkjateng.com/assets/images/user.jpg" : snapshot.data!.profilePhoto,
                              ),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Hi,",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),
                            ),
                            Text(
                                snapshot.data!.fullName+",",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white
                                ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(height: 0,);
                }
              }
            ),
            SizedBox(height: 17,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "Congratulation",
                    style: TextStyle(
                      color: Color.fromRGBO(43, 192, 159, 1),
                      fontFamily: "Urbanist",
                      fontSize: 33,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 9),
                        child: Image.asset(
                          "assets/recycle_illustration.png"
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Transform.translate(
                            offset: Offset(0, 9),
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: Color.fromRGBO(43, 192, 159, 1),
                                fontFamily: "Urbanist",
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 3,),
                          Text(
                            "Kg",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Urbanist",
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "of food is saved by you",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Urbanist",
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/circlemoney_illustration.png"
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Rp1.240.498",
                                  style: TextStyle(
                                    color: Color.fromRGBO(43, 192, 159, 1),
                                    fontFamily: "Urbanist",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "saved from potential economic loss",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Urbanist",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/circleearth_illustration.png"
                            ),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "172.5",
                                  style: TextStyle(
                                    color: Color.fromRGBO(43, 192, 159, 1),
                                    fontFamily: "Urbanist",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 3,),
                                Text(
                                  "Kg",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Urbanist",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "CO₂ is saved",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Urbanist",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Sustain endeavors to save the earth and contribute to SDGs by entrusting them to FOODSHARE.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 13,
                      ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}