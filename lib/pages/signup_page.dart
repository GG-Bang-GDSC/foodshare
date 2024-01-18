// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Variables
  TextEditingController _emailaddress = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirmation = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;

  @override
  Widget build(BuildContext context) {
    void toLoginPage(){
      Navigator.pushNamed(context, "/signinpage");
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 20, left: 20, top: 80, bottom: 30),
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
                    "Sign Up",
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
                    "Password",
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
                      obscureText: !_passwordVisible,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Enter your password...",
                        suffixIcon: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Icon(
                              _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            onPressed: () {
                              setState(() {
                                  _passwordVisible = !_passwordVisible;
                              });
                            },
                            ),
                        ),
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
                      obscureText: !_passwordConfirmVisible,
                      controller: _passwordConfirmation,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Confirm your password...",
                        suffixIcon: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: IconButton(
                            icon: Icon(
                              _passwordConfirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            onPressed: () {
                              setState(() {
                                  _passwordConfirmVisible = !_passwordConfirmVisible;
                              });
                            },
                            ),
                        ),
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
                    "Mobile Number",
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
                      controller: _mobileNumber,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Mobile Number...",
                        prefixIcon: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: IconButton(
                            icon: Text(
                              "+62",
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.6),
                                fontFamily: "Urbanist",
                                fontSize: 15
                              ),
                            ),
                            onPressed: () {},
                            ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15,),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: toLoginPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                  elevation: 0,
                  minimumSize: const Size.fromHeight(55),
                ), 
                child: Text(
                  "Sign Up",
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
                    "Already have an account?",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: toLoginPage,
                    child: Text(
                      "Sign In",
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
    );
  }
}