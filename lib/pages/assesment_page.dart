// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:foodshare/pages/asm1.dart';
import 'package:foodshare/pages/asm2.dart';
import 'package:foodshare/pages/asm3.dart';
import 'package:foodshare/pages/asm4.dart';
import 'package:foodshare/pages/asm5.dart';

class AssesmentPage extends StatefulWidget {
  AssesmentPage({super.key});

  @override
  State<AssesmentPage> createState() => _AssesmentPageState();
}

class _AssesmentPageState extends State<AssesmentPage> {
  // Variables
  List asmPages = [
    AssesmentPage1(),
    AssesmentPage2(),
    AssesmentPage3(),
    AssesmentPage4(),
    AssesmentPage5()
  ];
  int currentAsm = 0;

  // Actions
  void changeAssesment(){
    if(currentAsm < 4){
      setState(() {
        currentAsm = currentAsm + 1;
      });
    } else {
      Navigator.pushNamed(context, "/mainpage");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: Text(
          "Assesment",
          style: TextStyle(
            color: Color.fromRGBO(43, 192, 159, 1),
            fontWeight: FontWeight.w700,
            fontFamily: "Urbanist",
            fontSize: 28
          ),
        ),
        leading: GestureDetector(
          onTap: (){
            if(currentAsm == 0){
              Navigator.pop(context);
            } else {
              setState(() {
                currentAsm = currentAsm - 1;
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(43, 192, 159, 1),
              size: 30,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 60),
        child: SizedBox(
          width: 150,
          height: 50,
          child: FloatingActionButton(
            elevation: 0,
            onPressed: changeAssesment,
            backgroundColor: Color.fromRGBO(43, 192, 159, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentAsm == 4 ? "Finish" : "Continue",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: Colors.white
                  ),
                ),
                SizedBox(width: 10,),
                 Transform.flip(
                  flipX: true,
                   child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                 ),
              ],
            ),
          ),
        ),
      ),
      body: asmPages[currentAsm],
    );
  }
}