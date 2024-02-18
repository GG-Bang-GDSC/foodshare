// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/auth_controller.dart';
import 'package:foodshare/data/controller/restaurant_controller.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:foodshare/data/model/food_model.dart';
import 'package:foodshare/pages/restaurant_page.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class CheckoutPage extends StatefulWidget {
  final Map data;

  CheckoutPage({required this.data, Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
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
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthController authController = AuthController();
  RestaurantController restaurantController = RestaurantController();
  final _myBox = Hive.box("myBox");
  LocalDatabase db = LocalDatabase();
  int namelimit = 16;
  int categorylimit = 35;
  String deliveryValue = "self_pickup";
  Map deliveryName = {
    "self_pickup": "Self Pickup",
    "regular": "Regular Delivery",
    "priority": "Priority Delivery",
  };
  Map deliveryPrice = {
    "self_pickup": 0,
    "regular": 8000,
    "priority": 12000,
  };
  String paymentValue = "qris";
  Map paymentName = {
    "qris": "QRIS",
    "card": "Credit/Debit Card",
    "cod": "Cash on Delivery",
  };
  Map selectedVoucher = {
    "id": "uid123",
    "name": "Free Delivery up to 8k",
    "type": "value",
    "voucher_type": "delivery",
    "description": "Minimum purchase 30k",
    "discount": 8000,
    "minimum_purchase": 30000
  };
  List voucherList = [
    {
      "id": "uid123",
      "name": "Free Delivery up to 8k",
      "type": "value",
      "voucher_type": "delivery",
      "description": "Minimum purchase 30k",
      "discount": 8000,
      "minimum_purchase": 30000
    },
      {
      "id": "uid456",
      "name": "Free Delivery up to 12k",
      "type": "value",
      "voucher_type": "delivery",
      "description": "Minimum purchase 30k",
      "discount": 12000,
      "minimum_purchase": 20000
    }
  ];
  int discount = 0;
  bool loading = false;
  TextEditingController _note = TextEditingController();

  // Actions
  String _overflowText(String text, int limit){
      if (text.length >= limit){
        return text.substring(0, limit - 3) + "...";
      } else {
        return text;
      }
  }
  Map discountFunction(String type, int price, {int percentage = 0, int value = 0, int max=0}){
    Map result = {};
    if(type == "percentage"){
      result["discount"] = price * percentage;
      if((max != 0) && (result["discount"] > max)){
        result["discount"] = max;
      }
      result["discountPrice"] = price - result["discont"];
    }
    if(type == "fixed"){
      result["discount"] = value;
      result["discountPrice"] = price - result["discont"];
    }
    return result;
  }
  void addDishes(BuildContext context, Map food){
    if(!db.cartItems.containsKey(widget.data["id"])){
      setState(() {
        Map foodMap = food;
        foodMap["quantity"] = 1;
        db.cartItems[widget.data["id"]] = {foodMap["name"]: foodMap};
        db.updateDatabase();
      });
    } else {
      if(db.cartItems[widget.data["id"]].containsKey(food["name"])){
        setState(() {
          Map foodMap = db.cartItems[widget.data["id"]][food["name"]];
          foodMap["quantity"] = foodMap["quantity"] + 1;
          db.cartItems[widget.data["id"]][food["name"]] = foodMap;
          db.updateDatabase();
        });
      } else {
        setState(() {
          Map foodMap = food;
          foodMap["quantity"] = 1;
          db.cartItems[widget.data["id"]][food["name"]] = foodMap;
          db.updateDatabase();
        });
      }
    }
  }
  void removeDishes(BuildContext context, Map food){
    if(db.cartItems[widget.data["id"]].containsKey(food["name"])){
      if(db.cartItems[widget.data["id"]][food["name"]]["quantity"] == 1){
        if(db.cartItems[widget.data["id"]].length == 2){
          db.cartItems[widget.data["id"]].remove(food["name"]);
          db.cartItems.remove(widget.data["id"]);
          db.updateDatabase();
          Navigator.pop(context);
        } else {
          setState(() {
          db.cartItems[widget.data["id"]].remove(food["name"]);
          db.updateDatabase();
        });
        }
      } else {
        setState(() {
          db.cartItems[widget.data["id"]][food["name"]]["quantity"] = db.cartItems[widget.data["id"]][food["name"]]["quantity"] - 1;
          db.updateDatabase();
        });
      }
    }
  }

  // Actions
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
  String formatNumberWithDots(int number) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(number);
  }
  Future displayDelivery(BuildContext context){
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Delivery Option",
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
            SizedBox(height: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommended",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: deliveryValue == "self_pickup" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: RadioListTile(
                    activeColor: Color.fromRGBO(43, 192, 159, 1),
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Self Pick Up",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                "Pickup at 3-4 PM",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 11,
                                  color: Colors.black
                                ),
                              ),
                              Text(
                                "You contributed reducing 29,6 grams CO₂",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 11,
                                  color: Color.fromRGBO(43, 192, 159, 1)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Rp "+formatNumberWithDots(deliveryPrice["self_pickup"]),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 14,
                            color: Color.fromRGBO(43, 192, 159, 1)
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    value: 'self_pickup',
                    groupValue: deliveryValue,
                    onChanged: (value) {
                      setState(() {
                        deliveryValue = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:  deliveryValue == "regular" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: RadioListTile(
                    activeColor: Color.fromRGBO(43, 192, 159, 1),
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Regular Delivery",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                "Delivered to you in 30-45 min",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 11,
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 13,),
                        Text(
                          "Rp "+formatNumberWithDots(deliveryPrice["regular"]),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 14,
                            color: Color.fromRGBO(43, 192, 159, 1)
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    value: 'regular',
                    groupValue: deliveryValue,
                    onChanged: (value) {
                      setState(() {
                        deliveryValue = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:  deliveryValue == "priority" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: RadioListTile(
                    activeColor: Color.fromRGBO(43, 192, 159, 1),
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Priority Delivery",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              Text(
                                "Faster, expedited shipping service",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 11,
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Rp "+formatNumberWithDots(deliveryPrice["priority"]),
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            fontSize: 14,
                            color: Color.fromRGBO(43, 192, 159, 1)
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    value: 'priority',
                    groupValue: deliveryValue,
                    onChanged: (value) {
                      setState(() {
                        deliveryValue = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      )
    );
  }

  Future displayVoucher(BuildContext context){
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(100))
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Voucher",
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
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(237, 237, 237, 0.7)
                      ),
                      child: TextField(
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.black,
                          fontSize: 12
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "What food is on your mind?",
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.5)
                          )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: Text(
                      "Search",
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700
                        ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Text(
                "Delivery Discount",
                 style: TextStyle(
                    fontFamily: 'Urbanist',
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w700
                  ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(voucherList.length > 0) ...voucherList.asMap().entries.map((entry){
                        return discountItem(entry.value);
                      }), 
                  
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  int totalCheckout(String type, Map checkoutData){
    if(type == "subtotal"){
      return checkoutData["discount_price"] + deliveryPrice[deliveryValue];
    } else if(type == "total"){
      if(selectedVoucher != {}){
        return checkoutData["discount_price"] + deliveryPrice[deliveryValue] - selectedVoucher["discount"];
      } else {
        return checkoutData["discount_price"] + deliveryPrice[deliveryValue];
      }
    } else {
      return checkoutData["discount_price"] + deliveryPrice[deliveryValue];
    }
  }


  Future displayPayment(BuildContext context){
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Payment Method",
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
            SizedBox(height: 15,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: paymentValue == "qris" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: RadioListTile(
                    activeColor: Color.fromRGBO(43, 192, 159, 1),
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/payment_qris_icon.png"
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "QRIS",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                    value: 'qris',
                    groupValue: paymentValue,
                    onChanged: (value) {
                      setState(() {
                        paymentValue = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:  paymentValue == "card" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: RadioListTile(
                    activeColor: Color.fromRGBO(43, 192, 159, 1),
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/payment_credit_icon.png"
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "Credit/Debit Card",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                       
                      ],
                    ),
                    value: 'card',
                    groupValue: paymentValue,
                    onChanged: (value) {
                      setState(() {
                        paymentValue = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:  paymentValue == "cod" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: RadioListTile(
                    activeColor: Color.fromRGBO(43, 192, 159, 1),
                    contentPadding: EdgeInsets.zero,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/payment_cash_icon.png"
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "Cash on Delivery (COD)",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              
                            ],
                          ),
                        ),
  
                      ],
                    ),
                    value: 'cod',
                    groupValue: paymentValue,
                    onChanged: (value) {
                      setState(() {
                        paymentValue = value!;
                      });
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      )
    );
  }
  String discountIcon(String type){
    if(type == "delivery"){
      return "assets/delivery_icon.svg";
    } else {
      return "";
    }
  }

  // Widgets
  Widget discountItem(Map discount){
    return Container(
      margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedVoucher["id"] == discount["id"] ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: RadioListTile(
            activeColor: Color.fromRGBO(43, 192, 159, 1),
            contentPadding: EdgeInsets.zero,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        discountIcon(discount["voucher_type"])
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            discount["name"],
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          Text(
                            discount["description"],
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 11,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
                
              ],
            ),
            value: discount,
            groupValue: selectedVoucher,
            onChanged: (value) {
              setState(() {
                selectedVoucher = value!;
              });
              Navigator.pop(context);
            },
          ),
        );
  }
  Widget orderedItem(Map food){
    return Column(
      children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    constraints: BoxConstraints(
                    minHeight: 80,
                  ),
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food["name"],
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.black
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(43, 192, 159, 1),
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => removeDishes(context, food),
                              child: Container(
                                padding: EdgeInsets.only(left: 12),
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                              child: Text(
                                food["quantity"].toString(),
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => addDishes(context, food),
                              child: Container(
                                padding: EdgeInsets.only(right: 12),
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 65,
                      width: 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(food["img"]),
                          fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.circular(11)
                      ),
                    ),
                    SizedBox(height: 10,),                      
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(food["discount"] > 0) Text(
                          "Rp ${formatNumberWithDots(food["price"] * food["quantity"])}",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.black,
                            decorationThickness: 2
                          ),
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Rp ${formatNumberWithDots(((food["price"] - (food["price"] * food["discount"])) * food["quantity"]).floor())}",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Color.fromRGBO(43, 192, 159, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                  ],
                ),                      
              )
            ],
          ),
          SizedBox(height: 8,),
          Container(
            height: 1,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.2)
            ),
          ),
          SizedBox(height: 20,)
      ],
    );
  }
  Widget offerDishes(screenWidth){
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.only(left: 15, right: 0, top: 0, bottom: 10),
      width: screenWidth - 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.5), width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(5)
            ),
            child: Text(
              "End offer in 23.59",
              style: TextStyle(
                color: Colors.red,
                fontFamily: "Urbanist",
                fontSize: 11,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1 pc. Kroket Ayam",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Urbanist",
                        fontSize: 15
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "Add for",
                          style: TextStyle(
                            color: Color.fromRGBO(43, 192, 159, 1),
                            fontFamily: "Urbanist",
                            fontSize: 11
                          ),
                        ),
                        SizedBox(width: 4,),
                        Text(
                          "Rp 4000",
                          style: TextStyle(
                            color: Color.fromRGBO(43, 192, 159, 1),
                            fontFamily: "Urbanist",
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 2,
                            decorationColor: Color.fromRGBO(43, 192, 159, 1)
                          ),
                        ),
                        SizedBox(width: 4,),
                        Text(
                          "Rp 2.400",
                          style: TextStyle(
                            color: Color.fromRGBO(43, 192, 159, 1),
                            fontFamily: "Urbanist",
                            fontSize: 11
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                        elevation: 0,
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 1),
                      ),
                      child: Text(
                        "+",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget paymentDetails(int productSubtotal){
    return Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      "Payment Details",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Subtotal",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Rp"+formatNumberWithDots(productSubtotal),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Shipping Subtotal",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "Rp "+formatNumberWithDots(deliveryPrice[deliveryValue]),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4,),
                if(selectedVoucher != {}) Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount Total",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "-Rp "+formatNumberWithDots(selectedVoucher["discount"]),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                       color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Payment",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Rp "+formatNumberWithDots(totalCheckout("total", {"discount_price": productSubtotal})),
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(43, 192, 159, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
            
              ],
            ),
          );
  }
  Widget choicesDelivery(context){
    return GestureDetector(
      onTap: () => displayDelivery(context),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.15), width: 1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/box_icon.png",
                  ),
                  SizedBox(width: 10,),
                  Text(
                    deliveryName[deliveryValue],
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700
                      ),
                  )
                ],
              ),
                Row(
                children: [
                  Text(
                    "Rp "+formatNumberWithDots(deliveryPrice[deliveryValue]),
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Color.fromRGBO(43, 192, 159, 1),
                        fontSize: 13
                      ),
                  ),
                  Transform.rotate(
                    angle: 180 * 3.14159265359 / 180,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Color.fromRGBO(0, 0, 0, 0.6)
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
  Widget choicesVoucher(context){
    return GestureDetector(
      onTap: () => displayVoucher(context),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.15), width: 1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/voucher_icon.svg",
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    selectedVoucher["name"],
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700
                      ),
                  )
                ],
              ),
                Row(
                children: [
                  Transform.rotate(
                    angle: 180 * 3.14159265359 / 180,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Color.fromRGBO(0, 0, 0, 0.6)
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
  Widget choicesPayment(context){
    return GestureDetector(
      onTap: () => displayPayment(context),
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.15), width: 1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/payment_icon.svg",
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(width: 10,),
                  Text(
                    paymentName[paymentValue],
                    style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.w700
                      ),
                  )
                ],
              ),
                Row(
                children: [
                  Transform.rotate(
                    angle: 180 * 3.14159265359 / 180,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Color.fromRGBO(0, 0, 0, 0.6)
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
    );
  }
  Widget deliveryAddress(){
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/locationpage");
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.1), width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Color.fromRGBO(43, 192, 159, 1),
                    size: 30,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: authController.getUserData(_auth.currentUser!.uid),
                      builder: (context, snapshot){
                        if(snapshot.hasData){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Delivery Address",
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  Text(
                                    snapshot.data!.fullName,
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    "|",
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    snapshot.data!.phoneNumber,
                                    style: TextStyle(
                                      fontFamily: "Urbanist",
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2,),
                              FutureBuilder(
                                future: ((db.locations["current_location"] == []) || (db.locations["current_location"] == null)) ? placemarkFromCoordinates(48.8561, 2.2930) : placemarkFromCoordinates(db.locations["current_location"][0], db.locations["current_location"][1]),
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    List<Placemark> placemarks = snapshot.data!;
                                    var placemark = placemarks[0];

                                    return Text(
                                      "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}",
                                      style: TextStyle(
                                        fontFamily: "Urbanist",
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    );
                                  } else {
                                    print(snapshot.error);
                                    return Container(height: 0,);
                                  }
                                },
                              )
                            ],
                          );
                        } else {
                            return Container(height: 0);
                          }
                      } 
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                    angle: 180 * 3.14159265359 / 180,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 15,
                      color: Color.fromRGBO(0, 0, 0, 0.6)
                    ),
                  ),
              ],
            ),
            SizedBox(width: 5,)
         ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Map checkoutData = getOrderData(widget.data["id"]);

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,),
        height: 80,
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Color.fromRGBO(0,  0, 0, 0.15)))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total :",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12, 
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  "Rp "+formatNumberWithDots(totalCheckout("total", checkoutData)),
                  style: TextStyle(
                    color: Color.fromRGBO(43, 192, 159, 1),
                    fontSize: 20, 
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700
                  ),
                )
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = false;
                });
                var userData = await authController.getUserData(_auth.currentUser!.uid);
                var restaurantId = await restaurantController.getRestaurantID(widget.data["id"]);
                String? userName = userData!.fullName;
                Map orderData = {
                  "note": _note.text,
                  "restaurantId": restaurantId,
                  "date": DateTime.now(),
                  "driver": "asep gemoy",
                  "driverId": "ajdasjbdsaj2b13r831br",
                  "location": [12122, -231231],
                  "menu": [],
                  "name": userName,
                  "payment": paymentValue,
                  "shipFee": deliveryPrice[deliveryValue],
                  "status": "Belum Konfirmasi",
                  "promoDiscount": selectedVoucher["discount"],
                  "userId": _auth.currentUser!.uid
                };
                List foods = [];
                for(var entry in db.cartItems[widget.data["id"]].entries){
                  var key = entry.key;
                  var value = entry.value;
                  if(key != "done"){
                    value["note"] = "";
                    foods.add(value);
                  }
                }
                orderData["menu"] = foods;
                var sendOrder = await authController.sendOrder(orderData);
                if(sendOrder["status"]){
                  setState(() {
                    db.cartItems[widget.data["id"]]["done"] = true;
                    db.updateDatabase(); 
                  });
                  Navigator.pushNamed(context, "/waitingpage", arguments: widget.data);
                } else {
                  print(sendOrder["error"]);
                }
                setState(() {
                  loading = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ), 
              child: loading ? LoadingAnimationWidget.waveDots(
                          color: Colors.white,
                          size: 25,
                        ) : Text(
                "Payment",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15, 
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w700
                ),
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        title: Transform.translate(
          offset: Offset(-20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _overflowText(widget.data["name"], namelimit),
                style: TextStyle(
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.w700,
                  fontSize: 25
                ),
              ),
              SizedBox(height: 7,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  SizedBox(width: 10,),
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
                ],
              )
            ],
          ),
        ),
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: (){
           //Navigator.pushNamed(context, "/restaurantpage", arguments: widget.data);
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
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              children: [
                ...db.cartItems[widget.data["id"]].entries.map((entry){
                if(entry.key != "done"){
                  return orderedItem(entry.value);
                } else {
                  return Container(
                    height: 0,
                  );
                }
              }).toList()
              ],
            ),
          ),
          Container( // THIS CONTAINER
            width: 100,
            padding: EdgeInsets.only(left: 20, top: 10),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  offerDishes(screenWidth),
                  offerDishes(screenWidth),
                ],
              ),
            ),
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: deliveryAddress()
          ),
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Note (Optional)",
                    style: TextStyle(
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 15
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                      height: 40,
                      width: double.infinity,
                      padding: EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromRGBO(239, 239, 239, 1)
                      ),
                      child: TextField(
                              controller: _note,
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                color: Colors.black,
                                fontSize: 13
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                               
                                hintText: "Write here",
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 0.4)
                                )
                              ),
                            ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                choicesDelivery(context),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Subtotal :",
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w700
                        ),
                    ),
                    Text(
                      "Rp "+formatNumberWithDots(totalCheckout("subtotal", checkoutData)),
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          color: Color.fromRGBO(43, 192, 159, 1),
                          fontSize: 15,
                          fontWeight: FontWeight.w700
                        ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
                SizedBox(height: 15,),
                choicesVoucher(context),
                SizedBox(height: 10,),
                choicesPayment(context),
                SizedBox(height: 25,)
              ],
            ),
          ),
          paymentDetails(checkoutData["discount_price"]),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}