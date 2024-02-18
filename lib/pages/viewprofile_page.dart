// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodshare/data/controller/auth_controller.dart';

class ViewProfilePage extends StatefulWidget {
  ViewProfilePage({super.key});

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  // Variables
  AuthController authController = AuthController();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _number = TextEditingController();
  TextEditingController _email = TextEditingController();
  bool editProfile = false;
  bool linkedGoogle = false;
  bool linkedFacebook = false;
  bool editPhoto = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState(){
    if(_auth.currentUser!.providerData[0].providerId == "google.com"){
      setState(() {
        linkedGoogle = true;
      });
    }
    super.initState();
  }

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
        actions: [
          if(editProfile) GestureDetector(
            onTap: (){
                showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  title: Text(
                    "Save Confirmation",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  content: Text(
                    "Are you sure you want to save the edited data?",
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
                            Map newData = {
                              "full_name": _fullname.text,
                              "email": _email.text,
                              "phone_number": _number.text
                            };
                            authController.updateUserData(newData);

                            setState(() {
                              editProfile = false;
                            });
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(43, 192, 159, 1),
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: Text(
                              "Save",
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
            child: Text(
              "Save",
              style: TextStyle(
                fontFamily: "Urbanist",
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700
              ),
            ),
          )
          else GestureDetector(
            onTap: (){
              setState(() {
                editProfile = true;
              });
            },
            child: SvgPicture.asset(
              "assets/edit_icon.svg",
            ),
          ),
          SizedBox(width: 25,)
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 150,
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
            ),
            FutureBuilder(
              future: authController.getUserData(_auth.currentUser!.uid), 
              builder: (context, snapshot){
                if(snapshot.hasData){
                  print("NEW");
                  _fullname.text = snapshot.data!.fullName == null ? "Anonymous" : snapshot.data!.fullName;
                  _email.text = snapshot.data!.email == null ? "" : snapshot.data!.email;
                  _number.text = snapshot.data!.phoneNumber == null ? "" : snapshot.data!.phoneNumber;
                  return Transform.translate(
                      offset: Offset(0, -62),
                      child: Column(
                        children: [
                          Transform.translate(
                            offset: ((editProfile) && (editPhoto)) ? Offset(-9, -25) : Offset(0, 0),
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    if(editProfile){
                                      setState(() {
                                        editPhoto = !editPhoto;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: 105,
                                    width: 105,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                           snapshot.data!.profilePhoto == null ? "https://register.user.mpkjateng.com/assets/images/user.jpg" : snapshot.data!.profilePhoto,
                                        ),
                                        fit: BoxFit.cover
                                      ),
                                      boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.15),
                                            spreadRadius: 3,
                                            blurRadius: 10,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                  color: Color.fromRGBO(43, 192, 159, 1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/crown_icon.svg"
                                      )
                                    ],
                                  ),
                                ),
                                if((editProfile) && (editPhoto)) Transform.translate(
                                  offset: Offset(60, 60),
                                  child: Positioned(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(43, 192, 159, 1),
                                        borderRadius: BorderRadius.circular(10) 
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Text(
                                              "View photo",
                                              style: TextStyle(
                                                  fontFamily: "Urbanist",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white
                                                ),
                                              ),
                                          ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                              "Take photo",
                                              style: TextStyle(
                                                  fontFamily: "Urbanist",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                              "Upload photo",
                                              style: TextStyle(
                                                  fontFamily: "Urbanist",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              child: Text(
                                              "Remove photo",
                                              style: TextStyle(
                                                  fontFamily: "Urbanist",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          if((editProfile) && (editPhoto)) Container(height: 0,)
                          else Text(
                              "Reguler",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Full Name",
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                          color: Color.fromRGBO(0, 0, 0, 0.5)
                                        ))
                                      ),
                                      child: TextField(
                                        controller: _fullname,
                                        enabled: editProfile == true? true : false,
                                        keyboardType: TextInputType.text,
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          color: Colors.black,
                                          fontSize: 16
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "Your full name...",
                                          hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5)
                                          )
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                          color: Color.fromRGBO(0, 0, 0, 0.5)
                                        ))
                                      ),
                                      child: TextField(
                                        controller: _number,
                                        enabled: editProfile == true? true : false,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          color: Colors.black,
                                          fontSize: 16
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "Your phone number...",
                                          hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5)
                                          )
                                        ),
                                      ),

                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email Address",
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      height: 35,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border(bottom: BorderSide(
                                          color: Color.fromRGBO(0, 0, 0, 0.5)
                                        ))
                                      ),
                                      child: TextField(
                                        controller: _email,
                                        enabled: editProfile == true? true : false,
                                        keyboardType: TextInputType.emailAddress,
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          color: Colors.black,
                                          fontSize: 16
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          border: InputBorder.none,
                                          hintText: "Your email address...",
                                          hintStyle: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 0.5)
                                          )
                                        ),
                                      ),

                                    )
                                  ],
                                ),
                                Text(
                                  "The information regarding your account and propduct communication will be sent to the verified email address.",
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "The linked account",
                                        style: TextStyle(
                                          fontFamily: 'Urbanist',
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/google_icon.png"
                                              ),
                                              SizedBox(width: 15,),
                                              Text(
                                                "Google",
                                                style: TextStyle(
                                                  fontFamily: "Urbanist",
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ],
                                          ),
                                          Switch(
                                            activeColor: Color.fromRGBO(22, 146, 118, 1),
                                            activeTrackColor: Color.fromRGBO(43, 192, 159, 1),
                                            inactiveThumbColor: Colors.blueGrey.shade600,
                                            inactiveTrackColor: Color.fromRGBO(0, 0, 0, 0.1),
                                            splashRadius: 10.0,
                                            value: linkedGoogle,
                                            onChanged: (value){
                                              setState(() {
                                                linkedGoogle = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                "assets/facebook_icon.png"
                                              ),
                                              SizedBox(width: 15,),
                                              Text(
                                                "Facebook",
                                                style: TextStyle(
                                                  fontFamily: "Urbanist",
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ],
                                          ),
                                          Switch(
                                            activeColor: Color.fromRGBO(22, 146, 118, 1),
                                            activeTrackColor: Color.fromRGBO(43, 192, 159, 1),
                                            inactiveThumbColor: Colors.blueGrey.shade600,
                                            inactiveTrackColor: Color.fromRGBO(0, 0, 0, 0.1),
                                            splashRadius: 10.0,
                                            value: linkedFacebook,
                                            onChanged: (value){
                                              setState(() {
                                                linkedFacebook = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25,),
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
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.12),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Log out",
                                        style: TextStyle(
                                              fontFamily: "Urbanist",
                                              color: Colors.black,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700
                                            ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          
                        ],
                      ),
                    );
                } else {
                  return Container(height: 0,);
                }
              }),
          ],
        ),
      ),
    );
  }
}