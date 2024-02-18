// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AssesmentPage2 extends StatefulWidget {
  AssesmentPage2({super.key});

  @override
  State<AssesmentPage2> createState() => _AssesmentPage2State();
}

class _AssesmentPage2State extends State<AssesmentPage2> {
  // Variable
  int selectedNumber = 1;
  List numberDesc = ["Strongly disagree", "Disagree", "Netral",  "Agree", "Strongly Agree"];
  
  // Actions
  changeNumber(int number){
    setState(() {
      selectedNumber = number;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
        body: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "To what extent do you believe that individuals play a significant role in reducing the negative impact of food waste?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontFamily: "Urbanist",
                fontSize: 20
              ),
            ),
            Text(
              selectedNumber.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(43, 192, 159, 1),
                fontWeight: FontWeight.w700,
                fontFamily: "Urbanist",
                fontSize: 180
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => changeNumber(1),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: selectedNumber == 1 ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text(
                        "1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedNumber == 1 ? Colors.white : Color.fromRGBO(59, 0, 125, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Urbanist",
                          fontSize: 35
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeNumber(2),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: selectedNumber == 2 ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text(
                        "2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedNumber == 2 ? Colors.white : Color.fromRGBO(59, 0, 125, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Urbanist",
                          fontSize: 35
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeNumber(3),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: selectedNumber == 3 ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text(
                        "3",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedNumber == 3 ? Colors.white : Color.fromRGBO(59, 0, 125, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Urbanist",
                          fontSize: 35
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeNumber(4),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: selectedNumber == 4 ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text(
                        "4",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedNumber == 4 ? Colors.white : Color.fromRGBO(59, 0, 125, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Urbanist",
                          fontSize: 35
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => changeNumber(5),
                    child: Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        color: selectedNumber == 5 ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text(
                        "5",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedNumber == 5 ? Colors.white : Color.fromRGBO(59, 0, 125, 1),
                          fontWeight: FontWeight.w700,
                          fontFamily: "Urbanist",
                          fontSize: 35
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Text(
              numberDesc[selectedNumber - 1],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(43, 192, 159, 1),
                fontWeight: FontWeight.w700,
                fontFamily: "Urbanist",
                fontSize: 17
              ),
            ),
          ],
        ),
      ),
    );
  }
}