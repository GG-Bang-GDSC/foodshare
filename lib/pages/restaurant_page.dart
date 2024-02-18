// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/food_controller.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:foodshare/data/model/food_model.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';


class RestaurantPage extends StatefulWidget {
  final Map data;

  RestaurantPage({required this.data, Key? key}) : super(key: key);

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  // Init action
  @override
  void initState(){
    if(_myBox.get("cart_items") == null){
      db.createInitialData();
      db.updateDatabase();
    } else{
      db.loadData();
    }

    super.initState();
    getPromos();
  }
  // Variables
  final _myBox = Hive.box("myBox");
  int namelimit = 16;
  int categorylimit = 35;
  FoodController foodController = FoodController();
  LocalDatabase db = LocalDatabase();
  int promos = 0;

  // Actions
  void getPromos() async {
    int totalPromo = 0;
    var foods = await foodController.getFoods(widget.data["id"]);
    for(int i = 0; i < foods.length; i++){
      if(foods[i].discount > 0){
        totalPromo++;
      }
    }
    setState(() {
      promos = totalPromo;
    });
  }
  String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(number);
  }
  String _overflowText(String text, int limit){
      if (text.length >= limit){
        return text.substring(0, limit - 3) + "...";
      } else {
        return text;
      }
    }
  void addDishes(BuildContext context, foodModel food){
    if(!db.cartItems.containsKey(widget.data["id"])){
      setState(() {
        Map foodMap = food.toJson();
        foodMap["quantity"] = 1;
        db.cartItems[widget.data["id"]] = {foodMap["name"]: foodMap, "done": false};
        db.updateDatabase();
      });
    } else {
      if(db.cartItems[widget.data["id"]].containsKey(food.name)){
        setState(() {
          Map foodMap = db.cartItems[widget.data["id"]][food.name];
          foodMap["quantity"] = foodMap["quantity"] + 1;
          db.cartItems[widget.data["id"]][food.name] = foodMap;
          db.updateDatabase();
        });
      } else {
        setState(() {
          Map foodMap = food.toJson();
          foodMap["quantity"] = 1;
          db.cartItems[widget.data["id"]][food.name] = foodMap;
          db.updateDatabase();
        });
      }
    }
  }
  void removeDishes(BuildContext context, foodModel food){
    if(db.cartItems[widget.data["id"]].containsKey(food.name)){
      if(db.cartItems[widget.data["id"]][food.name]["quantity"] == 1){
        setState(() {
          db.cartItems[widget.data["id"]].remove(food.name);
          db.updateDatabase();
        });
      } else {
        setState(() {
          db.cartItems[widget.data["id"]][food.name]["quantity"] = db.cartItems[widget.data["id"]][food.name]["quantity"] - 1;
          db.updateDatabase();
        });
      }
    }
    if(db.cartItems[widget.data["id"]].length == 1){
      setState(() {
        db.cartItems.remove(widget.data["id"]);
        db.updateDatabase();
      });
    }
  }
  void toCheckoutPage(context) async{
    await Navigator.pushNamed(context, "/checkoutpage", arguments: widget.data);
    setState(() {
      db.cartItems = db.cartItems;
    });
  }

  Future displayDescription(BuildContext context, foodModel food){
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(100))
      ),
      builder: (context) => Container(
        
        padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Detail",
                  style: TextStyle(
                      fontFamily: 'Urbanist',
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Text(
              food.name,
              style: TextStyle(
                  fontFamily: 'Urbanist',
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700
                ),
            ),
            Text(
              food.description,
              style: TextStyle(
                  fontFamily: 'Urbanist',
                  color: Colors.black,
                  fontSize: 15,
                ),
            ),
            SizedBox(height: 14,),
            Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Best Before",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700
                      ),
                  ),
                  Text(
                    "20 Jan 2024",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Color.fromRGBO(43, 192, 159, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w700
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Created at",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w700
                      ),
                  ),
                  Text(
                    "18 Jan 2024",
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Color.fromRGBO(43, 192, 159, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w700
                      ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 88, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Text(
                          "Confirm",
                          style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700
                            ),
                        ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      addDishes(context, food);
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(
                      "assets/shopping_bag_icon.svg",
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      )
    );
  }
  bool checkFood(foodModel food){
    if(db.cartItems.containsKey(widget.data["id"])){
      if(db.cartItems[widget.data["id"]].containsKey(food.name)){
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
  Map getOrderData(){
    if(db.cartItems.containsKey(widget.data["id"])){
      num realPrice = 0;
      num discountPrice = 0;
      num quantity = 0;
      for(var entry in db.cartItems[widget.data["id"]].entries){
        var key = entry.key;
        var value = entry.value;
        if(key != "done"){
          quantity += value["quantity"];
          realPrice += value["price"] * value["quantity"];
          num fixedPrice = (value["price"] - (value["price"] * value["discount"])) * value["quantity"];
          discountPrice += fixedPrice; 
        }
      }
      return {
        "real_price": realPrice.floor(),
        "discount_price": discountPrice.floor(),
        "quantity": quantity.floor()
      };
    } else {
      return {};
    }
  }

  // Widgets
  Widget dishesItem(BuildContext context,  menu, foodModel food){
    return GestureDetector(
      //onTap: () => addDishes(context, img, name, price, discount, widget.data["name"], widget.data["id"], widget.data),
      onTap: () => displayDescription(context, food),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromRGBO(244, 244, 244, 1),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 14, left: 12),
              height: 80,
              width: 85,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(food.img),
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
                      food.name,
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        fontSize: 17
                      ),
                    ),
                    Row(
                      children: [
                        if(food.discount > 0) Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Text(
                            formatNumberWithDots(food.price),
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              decorationThickness: 2.0
                            ),
                          ),
                        ),
                        Text(
                          formatNumberWithDots((food.price - (food.price * food.discount)).floor()),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            fontSize: 15
                          ),
                        ),
                      ],
                    ),
                    if(food.discount != 0) Container(
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(100)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                      child: Text(
                        "${(food.discount * 100).round()}%",
                        style: TextStyle(
                          fontSize: 11,
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700,
                          color: Colors.red
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                         if(checkFood(food)) Row(
                          children: [
                            GestureDetector(
                              onTap: () => removeDishes(context, food),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1)
                                ),
                                child: Center(
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      color: Color.fromRGBO(43, 192, 159, 1),
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                  db.cartItems[widget.data["id"]][food.name]["quantity"].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Urbanist",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                  ),
                                ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => addDishes(context, food),
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Color.fromRGBO(43, 192, 159, 1), width: 1)
                            ),
                            child: Center(
                              child: Text(
                                "+",
                                style: TextStyle(
                                  color: Color.fromRGBO(43, 192, 159, 1),
                                  fontFamily: "Urbanist",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
    Map checkoutData = getOrderData();
    return Scaffold(
      bottomNavigationBar: db.cartItems.containsKey(widget.data["id"]) == false ? Container(height: 0,) : Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 82,
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 248, 248, 1),
          border: Border(top: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.2), width: 1))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total:",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
                Row(
                  children: [
                    Text(
                      formatNumberWithDots(checkoutData["real_price"]),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      formatNumberWithDots(checkoutData["discount_price"]),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(43, 192, 159, 1),
                        fontSize: 20
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "x"+checkoutData["quantity"].toString(),
                   style: TextStyle(
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(43, 192, 159, 1),
                      fontSize: 20
                    ),
                ),
                SizedBox(width: 10,),
                ElevatedButton(
                    onPressed: () => toCheckoutPage(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15, 
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 120,
        height: 45,
        child: FloatingActionButton(
          onPressed: (){},
          backgroundColor: Color.fromRGBO(43, 192, 159, 1),
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
              SizedBox(width: 15,),
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
                    color: Color.fromRGBO(43, 192, 159, 1)
                  ),
                  child: Center(
                    child: Text(
                      (promos == 0  ? "NO" : promos.toString())+" PROMOS AVAILABLE",
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
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          Container(
                            child: FutureBuilder<List<foodModel>>(
                                future: foodController.getFoods(widget.data["id"]),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    return Column(
                                      children: snapshot.data!.map((item){
                                        return dishesItem(context, "best offer", item);
                                      }).toList(),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }
                              ),
                          ),
                          // ...widget.data["foods"].asMap().entries.map((entry) => dishesItem("Menu", entry.value["img"], entry.value["name"], entry.value["price"], entry.value["discount"]))

                          //dishesItem(context, "best offer", "https://static.tacdn.com/img2/branding/homepage/home-tab3-hero-800x520-prog.jpg", "Ayam Goreng Oseng KANGKUNG", 1221, 0.2, "bjir"),

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