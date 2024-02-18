// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AssesmentPage3 extends StatefulWidget {
  AssesmentPage3({super.key});

  @override
  State<AssesmentPage3> createState() => _AssesmentPage3State();
}

class _AssesmentPage3State extends State<AssesmentPage3> {
  // Variables
  List questionItems = [
    "Serene Bistro & Lounge",
    "Urban Cafe",
    "Velvet Elegance Restaurant",
    "Java Dream Café",
    "Blissful Retreat Resort",
    "Harbonview Hotel & Grill",
    "Tommorow",
    "Divine Delights Bistro",
    "Cat and Treats Cafe",
    "Mosaic Fusion Café & Lounge",
  ];
  List activeAnswer = List.generate(10, (index) => false);
  List selectedAnswer = [];

  // Actions
  addAnswer(String answer){
    if(selectedAnswer.contains(answer)){
      setState(() {
        selectedAnswer.remove(answer);
      });
    } else {
      setState(() {
        selectedAnswer.add(answer);
      });
    }
  }

  // Widgets
  Widget question_item(String item, int index){
    return GestureDetector(
      onTap: (){
       setState(() {
         activeAnswer[index] = !activeAnswer[index];
       });
       addAnswer(item);
      },
      child: Container(
        margin: EdgeInsets.only(right: 12, top: 11),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: activeAnswer[index] == true ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: activeAnswer[index] == true ? Border.all(color: Color.fromRGBO(59, 0, 125, 0)): Border.all(color: Color.fromRGBO(59, 0, 125, 1))
        ),
        child: Text(
          item,
          style: TextStyle(
            fontFamily: "Urbanist",
            color: activeAnswer[index] == true ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
        body: Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Choose your top 3 favorite restaurants/cafés/hotels",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Urbanist",
                  fontSize: 20
                ),
              ),
              SizedBox(height: 30,),
              Wrap(
                alignment: WrapAlignment.center,
                children: questionItems.asMap().entries.map((entry) => question_item(entry.value, entry.key)).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}