// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/auth_controller.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  // Variables
  LocalDatabase db = LocalDatabase();
  TextEditingController _emailaddress = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _passwordVisible = false;
  bool loading = false;
  AuthController authController = AuthController();
  List dataError = [
    "none",
    {
      "email": false,
      "password": false,
    }
  ];

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
                              color: Color.fromRGBO(43, 192, 159, 1),
                              width: 1.0,
                            ),
                          ),
                          child: TextField(
                            controller: _emailaddress,
                            keyboardType: TextInputType.emailAddress,
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
                            dataError[0] == "null" ? "Password can't be empty!" : "Password not valid!",
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
                    SizedBox(height: 3,),
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
                      onPressed: () async {
                        setState(() {
                          loading = true;
                          dataError = [
                              "none",
                              {
                                "email": false,
                                "password": false,
                              }
                            ];
                        });
                        Map requestData = {
                          "email": _emailaddress.text,
                          "password": _password.text,
                        };
                        try {
                          var data = await authController.signInWithEmail(requestData);
                          setState(() {
                            loading = false;
                          });
                          if(data["message"] == "success"){
                            Navigator.pushNamed(context, "/mainpage");
                          } else if(data.containsKey("error")){
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (context){
                                  return AlertDialog(
                                      backgroundColor: Colors.white,
                                      surfaceTintColor: Colors.white,
                                      title: Text(
                                        "Sign In Failed",
                                        style: TextStyle(
                                          fontFamily: "Urbanist",
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                      content: Text(
                                        data["error"].message == "The supplied auth credential is incorrect, malformed or has expired." ? "Your email or password is incorrect. Please try again." : data["error"].message,
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
                            print("error : " +data["error"].message);
                          } else {
                            setState(() {
                              dataError = data["data"];
                            });
                          }
                        } catch(e){
                          print(e);
                        }
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
                        GestureDetector(
                          onTap: () async {
                            var signIn = await authController.signInWithGoogle();
                            if(signIn.containsKey("error")){
                              print(signIn["error"]);
                            } else {
                              if(signIn["message"] == "success"){
                                Navigator.pushNamed(context, "/mainpage");
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