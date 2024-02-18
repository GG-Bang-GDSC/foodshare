// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/auth_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Variables
  TextEditingController _emailaddress = TextEditingController();
  TextEditingController _fullname = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirmation = TextEditingController();
  TextEditingController _mobileNumber = TextEditingController();
  bool _passwordVisible = false;
  bool _passwordConfirmVisible = false;
  bool loading = false;
  AuthController authController = AuthController();
  List dataError = [
    "none",
    {
      "email": false,
      "full_name": false,
      "password": false,
      "password_confirmation": false,
      "phone_number": false,
    }
  ];

  @override
  Widget build(BuildContext context) {
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
                        color: Color.fromRGBO(43, 192, 159, 1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
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
                  ),
                  if(dataError[1]["email"]) Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      dataError[0] == "null" ? "Email can't be empty!" : "Email not valid!",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Urbanist",
                        //fontWeight: FontWeight.w700,
                        fontSize: 13
                      ),
                    ),
                  ) 
                  else SizedBox(height: 12,)
                ],
              ),
              SizedBox(height: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Full Name",
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
                        color: Color.fromRGBO(43, 192, 159, 1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _fullname,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        hintText: "Enter your full name..."
                      ),
                    ),
                  ),
                  if(dataError[1]["full_name"]) Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      dataError[0] == "null" ? "Full name can't be empty!" : "Full name not valid!",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Urbanist",
                        //fontWeight: FontWeight.w700,
                        fontSize: 13
                      ),
                    ),
                  ) 
                  else SizedBox(height: 12,)
                ],
              ),
              SizedBox(height: 8,),
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
                        color: Color.fromRGBO(43, 192, 159, 1),
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
                  ),
                  if(dataError[1]["password"]) Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      dataError[0] == "null" ? "Password can't be empty!" : "Password length must be between 8-24 characters!",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Urbanist",
                        //fontWeight: FontWeight.w700,
                        fontSize: 13
                      ),
                    ),
                  ) 
                  else SizedBox(height: 12,)
                ],
              ),
              SizedBox(height: 8,),
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
                        color: Color.fromRGBO(43, 192, 159, 1),
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
                  ),
                  if(dataError[1]["password_confirmation"]) Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      dataError[0] == "null" ? "Password confirmation can't be empty!" : "Password doesn't match!",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Urbanist",
                        //fontWeight: FontWeight.w700,
                        fontSize: 13
                      ),
                    ),
                  ) 
                  else SizedBox(height: 12,)
                ],
              ),
              SizedBox(height: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phone Number",
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
                        color: Color.fromRGBO(43, 192, 159, 1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _mobileNumber,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Phone Number...",
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
                  ),
                  if(dataError[1]["phone_number"]) Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      dataError[0] == "null" ? "Phone Number can't be empty!" : "Phone Number not valid!",
                      style: TextStyle(
                        color: Colors.red,
                        fontFamily: "Urbanist",
                        //fontWeight: FontWeight.w700,
                        fontSize: 13
                      ),
                    ),
                  ) 
                  else SizedBox(height: 12,)
                ],
              ),
              SizedBox(height: 8,),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                    dataError = [
                        "none",
                        {
                          "email": false,
                          "full_name": false,
                          "password": false,
                          "password_confirmation": false,
                          "phone_number": false,
                        }
                      ];
                  });
                  Map requestData = {
                    "email": _emailaddress.text,
                    "full_name": _fullname.text,
                    "password": _password.text,
                    "password_confirmation": _passwordConfirmation.text,
                    "phone_number": _mobileNumber.text
                  };
                  try {
                    var data = await authController.signUpWithEmail(requestData);
                    if(data["message"] == "success"){
                      Navigator.pushNamed(context, "/assesmentpage");
                    } else if(data.containsKey("error")){
                      showDialog(
                        context: context,
                        builder: (context){
                            return AlertDialog(
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white,
                                title: Text(
                                  "Sign Up Failed",
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                                content: Text(
                                  data["error"].message,
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    fontSize: 15
                                  ),
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1),
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Text(
                                        "Okay",
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
                                ],
                              );
                        }
                      );
                      print(data["error"].message);
                    } else {
                      setState(() {
                        dataError = data["data"];
                      });
                    }
                  } catch(e){
                    print(e);
                  }
                  setState(() {
                    loading = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                  elevation: 0,
                  minimumSize: const Size.fromHeight(55),
                ), 
                child: loading == true ? LoadingAnimationWidget.waveDots(
                      color: Colors.white,
                      size: 25,
                    ) : Text(
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
                  GestureDetector(
                    onTap: () async {
                            var signIn = await authController.signInWithGoogle();
                            if(signIn.containsKey("error")){
                              print(signIn["error"]);
                            } else {
                              if(signIn["message"] == "success"){
                                Navigator.pushNamed(context, "/assesmentpage");
                              }
                            }
                          },
                    child: Container(
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
                    onTap: (){
                      Navigator.pushNamed(context, "/signinpage");
                    },
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