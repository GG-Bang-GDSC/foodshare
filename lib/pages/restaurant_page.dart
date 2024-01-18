// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RestaurantPage extends StatefulWidget {
  final Map data;

  RestaurantPage({required this.data, Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  // Variables
  int namelimit = 16;
  int categorylimit = 35;

  // Actions
  String _overflowText(String text, int limit){
      if (text.length >= limit){
        return text.substring(0, limit - 3) + "...";
      } else {
        return text;
      }
    }
  void addDishes(String img, String name, int price, num discount, String restaurantName, int restaurantId, Map restaurant){
    Map _foodData  = {
      "img": img,
      "name":  name,
      "price": price,
      "discount": discount,
      "restaurant": restaurant
    };
    //Navigator.pushNamed(context, "/addfoodpage", arguments: _foodData);
    Navigator.pushNamed(context, "/checkoutpage", arguments: _foodData);
  }


  // Widgets
  Widget dishesItem(String menu, String img, String name, int price, num discount){
    return GestureDetector(
      onTap: () => addDishes(img, name, price, discount, widget.data["name"], widget.data["id"], widget.data),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(11)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(menu.toLowerCase() == "best offer") Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.yellow
                    ),
                    child: Text(
                      "End offer in 23.59",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 9,
                        color: Colors.red
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 17
                      ),
                    ),
                    Row(
                      children: [
                        if(discount > 0) Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                            price.toString(),
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2.0
                            ),
                          ),
                        ),
                        Text(
                          "${(price - (price * discount)).round()}",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                          ),
                        ),
                      ],
                    ),
                    if(discount != 0) Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                      child: Text(
                        "${(discount * 100).round()}%",
                        style: TextStyle(
                          fontSize: 11,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 120,
        height: 45,
        child: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Color.fromRGBO(165, 0, 0, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/menu_floating_icon.svg",
                fit: BoxFit.scaleDown,
              ),
              SizedBox(width: 10,),
              Text(
                "Menu",
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.white
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: Column(
          children: [
            Text(
              _overflowText(widget.data["name"], namelimit),
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w700,
                fontSize: 25
              ),
            ),
            SizedBox(height:3,),
            Text(
              _overflowText(widget.data["category"].join(", "), categorylimit),
              style: TextStyle(
                fontFamily: "Urbanist",
                fontSize: 16
              ),
            ),
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
              color: Colors.black,
              size: 35,
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20, left: 18),
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Color.fromRGBO(226, 76, 0, 1),
                      size: 14,
                    ),
                    Text(
                      widget.data["rating"].toString(),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
            
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Color.fromRGBO(226, 76, 0, 1),
                      size: 14,
                    ),
                    Text(
                      "${widget.data["distance"].toString()} km",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(182, 60, 0, 1)
                  ),
                  child: Center(
                    child: Text(
                      "10 PROMOS AVAILABLE",
                       style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Best Offer",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black
                            ),
                          ),
                          SizedBox(height: 10,),
                          ...widget.data["foods"].asMap().entries.map((entry) => dishesItem("Menu", entry.value["img"], entry.value["name"], entry.value["price"], entry.value["discount"]))

                          // dishesItem("best offer", widget.data["foods"][1]["img"], widget.data["foods"][1]["name"], widget.data["foods"][1]["price"], widget.data["foods"][1]["discount"]),

                          // dishesItem("asas", widget.data["foods"][2]["img"], widget.data["foods"][2]["name"], widget.data["foods"][2]["price"], widget.data["foods"][2]["discount"]),

                          // dishesItem("best offer", widget.data["foods"][3]["img"], widget.data["foods"][3]["name"], widget.data["foods"][3]["price"], widget.data["foods"][3]["discount"]),

                          // dishesItem("best offer", widget.data["foods"][4]["img"], widget.data["foods"][4]["name"], widget.data["foods"][4]["price"], widget.data["foods"][4]["discount"]),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}