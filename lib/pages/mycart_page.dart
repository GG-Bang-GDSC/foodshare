// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/restaurant_controller.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:foodshare/data/model/restaurant_model.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class MyCartPage extends StatefulWidget {
  MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
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
  }
  // Variables
  final _myBox = Hive.box("myBox");
  LocalDatabase db = LocalDatabase();
  RestaurantController restaurantController = RestaurantController();

  //  Actions
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
  Map getOrderData(var id){
    if(db.cartItems.containsKey(id)){
      num realPrice = 0;
      num discountPrice = 0;
      num quantity = 0;
      for(var entry in db.cartItems[id].entries){
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
  void toCheckoutPage(context, data, bool done) async {
    if(!done){
      data["popup"] = false;
    }
    await Navigator.pushNamed(context, !done? "/waitingpage" : "/checkoutpage", arguments: data);
    setState(() {
      db.cartItems = db.cartItems;
    });
  }
  // Widgets
  Widget foodbox(var food, bool done){
    return Container(
        margin: EdgeInsets.only(top: 12),
        width: double.infinity,
        height: 90,
        child: Row(
          children: [
            Container(
              height: double.infinity,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    food["img"]
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: done == true ? Color.fromRGBO(0, 0, 0, 0) : Color.fromRGBO(0, 0, 0, 0.5),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    food["name"],
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(0, 5),
                        child: Text(
                          food["quantity"].toString() + " x",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Row(
                          children: [
                            Text(
                              "Rp" + formatNumberWithDots(food["price"]),
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: 13,
                                decoration: TextDecoration.lineThrough,
                                decorationThickness: 3,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "Rp" + formatNumberWithDots((food["price"] - (food["price"] * food["discount"])).floor()),
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w700,
                                color: Color.fromRGBO(43, 192, 159, 1),
                                fontSize: 17
                              ),
                            ),
                          ],
                        )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
  }
  Widget cartbox(BuildContext context,var restaurant, bool done, Map foods){
    Map checkoutData = getOrderData(restaurant.id);

    if(checkoutData["real_price"] == null){
      return Container(height: 0,);
    }

    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, "/restaurantpage", arguments: restaurant.toJson());
        setState(() {
          db.cartItems = db.cartItems;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 15),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/cartcake_icon.svg",
                        fit: BoxFit.cover,
                        width: 18,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        _overflowText(restaurant.name, 18),
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.flip(
                  flipX: true,
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Change",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontSize: 13
                    ),
                  ),
                ),
              ],
            ),
      
            SizedBox(height: 6,),
            // foodbox(foods, done),
            // foodbox(foods , done),
            ...foods.entries.map((entry){
              if(entry.key != "done"){
                return foodbox(entry.value, done);
              } else {
                return Container(height: 0,);
              }
            }),
            SizedBox(height: 12,),
      
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(    
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total:",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 14,
                            decorationThickness: 3,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "Rp"+formatNumberWithDots(checkoutData["real_price"]),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 3,
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "Rp"+formatNumberWithDots(checkoutData["discount_price"]),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontWeight: FontWeight.w700,
                            color: Color.fromRGBO(43, 192, 159, 1),
                            fontSize: 17
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                      onPressed: () => toCheckoutPage(context, restaurant.toJson(), done),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: done == true ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(104, 104, 104, 1),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          color: done == true ? Colors.white : Color.fromRGBO(182, 182, 182, 1),
                          fontSize: 15, 
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
              ],
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
        surfaceTintColor: Colors.transparent,
        shape: Border(
        bottom: BorderSide(
          color: Color.fromRGBO(0, 0, 0, 0.2),
          width: 1
        )
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        toolbarHeight: 73,
        title: Row(
          children: [
            SizedBox(width: 20,),
            Text(
              "My Cart",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w700,
                fontSize: 23
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
              Icons.arrow_back,
              size: 28,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
          child: Column(
            children: [
              Column(
                children: [
                  if(db.cartItems.length > 0) ...db.cartItems.entries.map((entry){
                    return FutureBuilder(
                    future: restaurantController.getRestaurantDetail(entry.key),
                    builder: (context, snapshot){
                          if(snapshot.hasData){
                            return cartbox(context, snapshot.data!, !db.cartItems[entry.key]["done"], db.cartItems[entry.key]);
                            //return Container(height: 0,);
                          } else {
                            return Container(
                              height: 0,
                            );
                          }
                    }
                  );}).toList().reversed.toList()
                  else Container(
                    margin: EdgeInsets.only(top: 20),
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
                              "There is nothing in your cart",
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
                              "You haven't ordered anything yet. Browse all of restaurants here and order the food you want!",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontSize: 15
                              ),
                            ),
                      ],
                    ),
                  )
                ],
              )
            ],
           
          ),
        ),
      ),
    );
  }
}