// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';


class DonationPage extends StatefulWidget {
  DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  // Actions
  String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/donation.svg",
              width: 27,
            ),
            SizedBox(width: 10,),
            Text(
              "Donation",
              style: TextStyle(
                fontFamily: "Urbanist",
                color: Color.fromRGBO(43, 192, 159, 1),
                fontWeight: FontWeight.w700,
                fontSize: 33
              ),
            ),
            SizedBox(width: 40,),
          ],
        ),
        leadingWidth: 42,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(43, 192, 159, 1),
              size: 35,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Become a donor",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: 7,),
                  Text(
                    "Be part of the goodness with our donation feature! Donate food for our special food distribution event.",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      color: Colors.black,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, "/donationpaymentpage");
                },
                child: CircularPercentIndicator(
                        radius: 100.0,
                        lineWidth: 20.0,
                        percent: 100000/500000,
                        animation: true,
                        animationDuration: 700,
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Color.fromRGBO(0, 0, 0, 0.15),
                        center: Text(
                          "Donate\nNow",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Color.fromRGBO(43, 192, 159, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 22
                          ),
                        ),
                        progressColor: Color.fromRGBO(43, 192, 159, 1),
                ),
              ),
              SizedBox(height: 30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "You have donated",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formatNumberWithDots(100000),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          color: Color.fromRGBO(43, 192, 159, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 19
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        "of",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 19
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        formatNumberWithDots(500000),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          color: Color.fromRGBO(43, 192, 159, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 19
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14,),
                  Text(
                    "The Food and Beverage Donation Event",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18
                    ),
                  ),
                  Column(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 22),
                        child: Image.asset(
                          "assets/donation_comingsoon.png"
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(43, 192, 159, 1)
                        ),
                        child: Text(
                          "COMING SOON",
                          style: TextStyle(
                            letterSpacing: 3,
                            fontFamily: "Urbanist",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}