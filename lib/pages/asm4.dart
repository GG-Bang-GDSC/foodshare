// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AssesmentPage4 extends StatefulWidget {
  AssesmentPage4({super.key});

  @override
  State<AssesmentPage4> createState() => _AssesmentPage4State();
}

class _AssesmentPage4State extends State<AssesmentPage4> {
  // Variables
  List questionItems = [
   "Snacks",
   "Noodles",
   "Beverages",
   "Vegan",
   "Rice Dishes",
   "Desserts",
   "Healthy Food",
   "Indonesian Food",
   "Asian Food",
   "Coffee",
   "Japanese Food",
   "Korean Food",
   "Seafood",
   "Fast Food",
   "Bread and Pastry"
  ];
  List activeAnswer = List.generate(15, (index) => false);
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
    print(selectedAnswer);
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
                "Favorite Food Categories",
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