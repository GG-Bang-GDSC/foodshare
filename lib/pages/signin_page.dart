// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // Variables
  TextEditingController _emailaddress = TextEditingController();
  TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    void toSearchPage(){
      Navigator.pushNamed(context, "/mainpage");
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: 20, left: 20, top: 50, bottom: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 18),
                          child: SvgPicture.asset(
                            "assets/foodshare_logo.svg",
                            fit: BoxFit.scaleDown,
                            width: 35,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color.fromRGBO(43, 192, 159, 1),
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 40
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Email Address",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Color.fromRGBO(59, 0, 125,1),
                              width: 1.0,
                            ),
                          ),
                          child: TextField(
                            controller: _emailaddress,
                            style: TextStyle(
                              fontFamily: "Urbanist"
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 30),
                              hintText: "Enter your email..."
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Password Confirmation",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 20
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: double.infinity,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Color.fromRGBO(59, 0, 125,1),
                              width: 1.0,
                            ),
                          ),
                          child: TextField(
                            controller: _password,
                            style: TextStyle(
                              fontFamily: "Urbanist"
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 30),
                              hintText: "Confirm your password..."
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color.fromRGBO(43, 192, 159, 1),
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromRGBO(43, 192, 159, 1),
                              decorationThickness: 3.0
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: toSearchPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                        elevation: 0,
                        minimumSize: const Size.fromHeight(55),
                      ), 
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      )
                    ),
                    SizedBox(height: 25,),
                    Text(
                      "or using",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),
                    SizedBox(height: 25,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(43, 192, 159, 1),
                              width: 2.0
                            ),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: SvgPicture.asset(
                            "assets/facebook_logo.svg",
                            fit: BoxFit.scaleDown
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(43, 192, 159, 1),
                              width: 2.0
                            ),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: SvgPicture.asset(
                            "assets/google_logo.svg",
                            fit: BoxFit.scaleDown
                          ),
                        ),
                        SizedBox(width: 15,),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromRGBO(43, 192, 159, 1),
                              width: 2.0
                            ),
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: SvgPicture.asset(
                            "assets/instagram_logo.svg",
                            fit: BoxFit.scaleDown
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 70,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5),
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "/signuppage");
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Color.fromRGBO(43, 192, 159, 1),
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromRGBO(43, 192, 159, 1),
                              decorationThickness: 3.0
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}