// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodshare/data/controller/auth_controller.dart';
import 'package:foodshare/data/model/user_model.dart';
import 'package:intl/intl.dart';

class DonationPaymentPage extends StatefulWidget {
  DonationPaymentPage({super.key});

  @override
  State<DonationPaymentPage> createState() => _DonationPaymentPageState();
}

class _DonationPaymentPageState extends State<DonationPaymentPage> {
  // Variables
  TextEditingController donationValueController = TextEditingController();
  int activeQuick = 0;
  bool donateAsAnonymous = false;
  bool writeMessage = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthController authController = AuthController();

  // Actions
  String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(number);
  }

  // Widgets
  Widget quickDonationValue(BuildContext context, int value){
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (){
        if(activeQuick == value){
          setState(() {
            activeQuick = 0;
            donationValueController.text = "";
          });
        } else {
          setState(() {
            activeQuick = value;
            donationValueController.text = value.toString();
          });
        }
      },
      child: Container(
        width: (screenWidth / 2) - 28,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: activeQuick == value ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(248, 248, 248, 1), 
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
          boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.07),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
        ),
        child: Center(
          child: Text(
            "Rp"+formatNumberWithDots(value),
            style: TextStyle(
              fontFamily: "Urbanist",
              color: activeQuick == value ? Colors.white : Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20
            ),
          ),
        ),
      ),
    );
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2,),
              Text(
                "Start donate from Rp1.000",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                  border: Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1)
                ),
                child: Row(
                    children: [
                      SizedBox(width: 20,),
                      Text(
                        "Rp",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value){
                            setState(() {
                              activeQuick = 0;
                            });
                          },
                          controller: donationValueController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          //  onSubmitted: (context) => search_action(),
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 15),
                              hintText: "0",
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5)
                              )
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.15), width: 1))
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          quickDonationValue(context, 10000),
                          quickDonationValue(context, 20000),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          quickDonationValue(context, 50000),
                          quickDonationValue(context, 100000),
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          quickDonationValue(context, 150000),
                          quickDonationValue(context, 200000),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                FutureBuilder<userModel?>(
                future: authController.getUserData(_auth.currentUser!.uid),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data!.fullName,
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 16
                            ),
                          ),
                          Text(
                            snapshot.data!.phoneNumber,
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              color: Colors.black,
                              fontSize: 16
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container(height: 0,);
                    }
                  }
                ),
                SizedBox(height: 17,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/gopay_donation.png"
                        ),
                        Text(
                          donationValueController.text == "" ? "Rp0" : "Rp"+formatNumberWithDots(int.parse(donationValueController.text)),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Text(
                          "Change",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                          ),
                        ),
                    )
                  ],
                ),
                SizedBox(height: 17,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Donate as anonymous",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Colors.black,
                        fontSize: 16
                      ),
                    ),
                    Switch(
                      activeColor: Color.fromRGBO(22, 146, 118, 1),
                      activeTrackColor: Color.fromRGBO(43, 192, 159, 1),
                      inactiveThumbColor: Colors.blueGrey.shade600,
                      inactiveTrackColor: Color.fromRGBO(0, 0, 0, 0.1),
                      splashRadius: 10.0,
                      value: donateAsAnonymous,
                      onChanged: (value){
                        setState(() {
                          donateAsAnonymous = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Write message",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Colors.black,
                        fontSize: 16
                      ),
                    ),
                    Switch(
                      activeColor: Color.fromRGBO(22, 146, 118, 1),
                      activeTrackColor: Color.fromRGBO(43, 192, 159, 1),
                      inactiveThumbColor: Colors.blueGrey.shade600,
                      inactiveTrackColor: Color.fromRGBO(0, 0, 0, 0.1),
                      splashRadius: 10.0,
                      value: writeMessage,
                      onChanged: (value){
                        setState(() {
                          writeMessage = value;
                        });
                      },
                    ),
                  ],
                ),
                if(writeMessage) Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.15), width: 1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                      child: TextField(
                        maxLines: null,
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 15
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write your message...',
                          border: InputBorder.none, 
                        ),
                      ),
                    ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(bottom: 50),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(43, 192, 159, 1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700
                            ),
                        ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}