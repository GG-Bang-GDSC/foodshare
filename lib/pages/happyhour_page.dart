// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodshare/data/controller/food_controller.dart';
import 'package:foodshare/data/controller/restaurant_controller.dart';
import 'package:foodshare/data/model/food_model.dart';
import 'package:foodshare/data/model/restaurant_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';

class HappyHourPage extends StatefulWidget {
  HappyHourPage({super.key});

  @override
  State<HappyHourPage> createState() => _HappyHourPageState();
}

class _HappyHourPageState extends State<HappyHourPage> {
  // Variables
  FoodController foodController = FoodController();
  RestaurantController restaurantController = RestaurantController();
  String selectedFilter = "all";

  // Actions
  String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(number);
  }

  // Widgets
  Widget happyHourItem(foodModel food){
    Map restaurantData = {};
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(top: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 106,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        food.img,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 17, right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      food.name,
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              FutureBuilder<restaurantModel>(
                                future: restaurantController.getRestaurantDetail(food.restaurantId),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    restaurantData = snapshot.data!.toJson();
                                    return Text(
                                      snapshot.data!.name,
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700
                                      ),
                                    );
                                  } else {
                                    return Text(
                                        "Lesehan Ci Lin",
                                        style: TextStyle(
                                          fontFamily: "Urbanist",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700
                                        ),
                                      );
                                  }
                                }
                              ),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      "Rp"+formatNumberWithDots(food.price),
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Container(
                                      margin: EdgeInsets.only(top: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/lightning_icon_red.svg",
                                          ),
                                          SizedBox(width: 3,),
                                          Text(
                                            "${(food.discount * 100).floor()}%",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontFamily: "Urbanist",
                                              fontWeight: FontWeight.w700,
                                              color: Colors.red
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                              SizedBox(height: 2,),
                              Text(
                                "Rp"+formatNumberWithDots((food.price - (food.price * food.discount)).floor()),
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  color: Color.fromRGBO(43, 192, 159, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 6,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.translate(
                                    offset: Offset(-10, 0),
                                    child: LinearPercentIndicator(
                                      width: 150,
                                      animation: true,
                                      lineHeight: 20.0,
                                      animationDuration: 400,
                                      backgroundColor: Color.fromRGBO(0, 0, 0, 0.15),
                                      percent: 0.8,
                                      center: Text(
                                        "LIMITED STOCK",
                                        style: TextStyle(
                                          fontFamily: "Urbanist",
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700
                                        ),
                                    
                                      ),
                                      barRadius: Radius.circular(10),
                                      progressColor: Color.fromRGBO(43, 192, 159, 1),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, "/restaurantpage", arguments: restaurantData);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(43, 192, 159, 1),
                                        borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Text(
                                        "Buy",
                                        style: TextStyle(
                                          fontFamily: "Urbanist",
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/clock_icon.svg",
                  ),
                  SizedBox(width: 8,),
                  Text(
                    "Happy Hour",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      color: Color.fromRGBO(43, 192, 159, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 33
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: (){
                        if(selectedFilter == "near_me"){
                          setState(() {
                            selectedFilter = "all";
                          });
                        } 
                      },
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedFilter == "all" ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: selectedFilter == "all" ? Border.all(width: 0, color: Colors.transparent) : Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/lightning_icon.svg",
                                fit: BoxFit.scaleDown,
                                height: 20,
                                color: selectedFilter == "all" ? Colors.white : Color.fromRGBO(43, 192, 159, 1),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "All",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 15,
                                color: selectedFilter == "all" ? Colors.white : Color.fromRGBO(43, 192, 159, 1),
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        if(selectedFilter == "all"){
                          setState(() {
                            selectedFilter = "near_me";
                          });
                        }
                      },
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.symmetric(vertical: 7),
                        decoration: BoxDecoration(
                          color: selectedFilter == "near_me" ? Color.fromRGBO(43, 192, 159, 1) : Colors.transparent,
                          border: selectedFilter == "near_me" ? Border.all(width: 0, color: Colors.transparent) : Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/pointer_icon.svg",
                                fit: BoxFit.scaleDown,
                                height: 20,
                                color: selectedFilter == "near_me" ? Colors.white : Color.fromRGBO(43, 192, 159, 1),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Near me",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 15,
                                color: selectedFilter == "near_me" ? Colors.white : Color.fromRGBO(43, 192, 159, 1),
                                fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 22,),
              FutureBuilder<List<foodModel>>(
                future: foodController.getFoodsHappyHour(0.5),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: snapshot.data!.map((item){
                        return happyHourItem(item);
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                }
              ),



              SizedBox(height: 120,),
            ],
          ),
        ),
      ),
    );
  }
}