// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPVerificationPage extends StatefulWidget {
  OTPVerificationPage({super.key});

  @override
  State<OTPVerificationPage> createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        // title: Text(
        //   "SMS Verification",
        //   style: TextStyle(
        //     color: Color.fromRGBO(43, 192, 159, 1),
        //     fontWeight: FontWeight.w700,
        //     fontFamily: "Urbanist",
        //     fontSize: 25
        //   ),
        // ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Verification code",
              style: TextStyle(
                //color: Color.fromRGBO(43, 192, 159, 1),
                fontWeight: FontWeight.w700,
                fontFamily: "Urbanist",
                fontSize: 19
              ),
            ),
            Text(
              "We have sent verification code to",
              style: TextStyle(
                //color: Color.fromRGBO(43, 192, 159, 1),
               // fontWeight: FontWeight.w700,
                fontFamily: "Urbanist",
                fontSize: 14
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Text(
                  "+62123456789",
                  style: TextStyle(
                    //color: Color.fromRGBO(43, 192, 159, 1),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Urbanist",
                    fontSize: 14
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  "Change phone number?",
                  style: TextStyle(
                    color: Color.fromRGBO(43, 192, 159, 1),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Urbanist",
                    fontSize: 14
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 64,
                  width: 68,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    onChanged: (value){
                      if(value.length == 1){
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 8),
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        )
                      ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  height: 64,
                  width: 68,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    onChanged: (value){
                      if(value.length == 1){
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 8),
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        )
                      ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  height: 64,
                  width: 68,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    onChanged: (value){
                      if(value.length == 1){
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 8),
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        )
                      ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  height: 64,
                  width: 68,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextFormField(
                    onChanged: (value){
                      if(value.length == 1){
                        FocusScope.of(context).nextFocus();
                      } else {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 35
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(bottom: 8),
                        hintText: "0",
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                        )
                      ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Resend code after",
                  style: TextStyle(
                    //color: Color.fromRGBO(43, 192, 159, 1),
                   // fontWeight: FontWeight.w700,
                    fontFamily: "Urbanist",
                    fontSize: 14
                  ),
                ),
                SizedBox(width: 5,),
                Text(
                  "1:50",
                  style: TextStyle(
                    color: Color.fromRGBO(43, 192, 159, 1),
                    fontWeight: FontWeight.w700,
                    fontFamily: "Urbanist",
                    fontSize: 14
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1)
                    ),
                    child: Text(
                        "Resend",
                        style: TextStyle(
                          color: Color.fromRGBO(43, 192, 159, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Urbanist",
                          fontSize: 16
                        ),
                      ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/assesmentpage");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(43, 192, 159, 1),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Urbanist",
                          fontSize: 16
                        ),
                      ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}