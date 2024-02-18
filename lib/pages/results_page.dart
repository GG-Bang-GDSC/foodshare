// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
//import 'package:foodshare/data/firebase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foodshare/data/controller/food_controller.dart';
import 'package:foodshare/data/model/food_model.dart';
import 'package:foodshare/data/firebase.dart';
import 'package:intl/intl.dart';

class ResultsPage extends StatefulWidget {
  final String data;

  ResultsPage({required this.data, Key? key}) : super(key: key);


  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  // Variables
 // FirebaseService fdb = FirebaseService();
  List sortValue = ["Top result", "Near me", "Rated 4.5+", "Populer"];
  int _selectedSort = 0;
  FoodController foodController = FoodController();

  // Actions
  String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(number);
  }

  void changeSort(int index){
    setState(() {
      _selectedSort = index;

      // sortRestaurant(index);
    });
  }
  void checkDishes(int id, String name, String restaurantImg, num distance, List category, String discount, double rating){
    Map _restaurantData = {
      "id": id,
      "name": name,
      "img": restaurantImg,
      "distance": distance,
      "category": category,
      "discount": discount,
      "rating": rating,
      // "foods": restaurantFoods(id)
    }; 
    print(_restaurantData);
    Navigator.pushNamed(context, "/restaurantpage", arguments: _restaurantData);
  }

  // Widgets
  Widget sortWidget(String value, int index){
    Color bgColor = index == _selectedSort ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(220, 220, 220, .8);
    Color textColor = index == _selectedSort ? Colors.white : Colors.black;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      margin: EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(100)
      ),
      child: Text(
        value,
        style: TextStyle(
          color: textColor,
          fontFamily: "Urbanist",
          fontSize: 14,
        ),
      ),
    );
  }
  Widget dishesItem(String img, String name, int price, num discount){
    return Container(
      margin: EdgeInsets.only(right: 15),
      width: 240,
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromRGBO(248, 248, 248, 1),
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 4),
            ),
          ],
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.circular(11)
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 13
                    ),
                  ),
                  Row(
                    children: [
                      if(discount > 0) Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          formatNumberWithDots(price),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough
                          ),
                        ),
                      ),
                      Text(
                        formatNumberWithDots((price - (price * discount)).floor()),
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700,
                          fontSize: 11
                        ),
                      ),
                    ],
                  ),
                  if(discount != 0) Container(
                    margin: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(100)
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    child: Text(
                      "${(discount * 100).round()}%",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        color: Colors.red
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget restaurantBox( int id, String name, String restaurantImg, num distance, List category, String discount, double rating, List dishes){
    String _overflowText(String text, int limit){
      if (text.length >= limit){
        return text.substring(0, limit - 3) + "...";
      } else {
        return text;
      }
    }
    int namelimit = 16;
    int categorylimit = 35;
    //dishes = dishes[0];

    return GestureDetector(
      onTap: () => checkDishes(id, name, restaurantImg, distance, category, discount, rating),
      child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 106,
                  height: 110,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        restaurantImg,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15,),
                      Container(
                        height: 23,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(43, 192, 159, 1),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(2, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(width: 4,),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 18,
                              ),
                              SizedBox(width: 3,),
                              Text(
                                rating.toString(),
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 14
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 110,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _overflowText(name, namelimit),
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 21
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        "${distance} km",
                                        style: TextStyle(
                                          fontFamily: "Urbanist",
                                          fontSize: 13
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                _overflowText(category.join(", "), categorylimit),
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 13
                                ),
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: List.generate(150~/3, (index) => Expanded(
                                    child: Container(
                                      color: index%2==0?Colors.black38
                                      :Colors.transparent,
                                      height: 1,
                                    ),
                                  )),
                              ),
                              SizedBox(height: 5,),
                              if (discount != "") Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    discount,
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer_sharp,
                                    color: Colors.red,
                                    size: 18,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    "Delivery in ${distance.floor() * 10} - ${distance.floor() * 10 + 10} min",
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (dishes.length > 0) Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text(
                                  "Dishes found",
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16
                                  ),
                                ),
                                SizedBox(height: 15,),
                                SingleChildScrollView(
                                  clipBehavior: Clip.none,
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...dishes.map((e) => dishesItem(e.img, e.name, e.price, e.discount))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 25,)
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: Column(
          children: [
            Text(
              "Results",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w700,
                fontSize: 30
              ),
            ),
            Text(
                "for ${widget.data}",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w700,
                  fontSize: 18
                ),
              )
          ],
        ),
        leadingWidth: 42,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(43, 192, 159, 1),
              size: 35,
            ),
          ),
        ),
      ),
      body: ListView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  ...sortValue.asMap().entries.map((entry) => GestureDetector(onTap: () => changeSort(entry.key), child: sortWidget(entry.value, entry.key))).toList(),
                ],
              ),
            ),
            SizedBox(height: 25,),
            Container(
                child: FutureBuilder<List>(
                    future: foodController.searchFoods(widget.data, _selectedSort),
                    builder: (context, snapshot){
                      if(snapshot.hasData && snapshot.data!.length > 0){
                        return Column(
                          children: snapshot.data!.map((item){
                            return restaurantBox(item["id"], item["name"], item["img"], item["distance"], item["category"], item["discount"], item["rating"], item["foods"]);
                          }).toList(),
                        );
                      } else {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.manage_search,
                                    size: 26,
                                  ),
                                  SizedBox(width: 8,),
                                  Text(
                                    "No results found for \"${widget.data}\"",
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18
                                    ),
                                  ),
                                ],
                                
                              ),
                              SizedBox(width: 8,),
                                  Text(
                                    "We couldn't find any food related to \"${widget.data}\". Maybe check your spelling or try to search another food!",
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 15
                                    ),
                                  ),
                            ],
                          ),
                        );
                      }
                    }
                  ),
              ),
          ],
        ),
    );
  }
}