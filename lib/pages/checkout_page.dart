// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutPage extends StatefulWidget {
  final Map data;

  CheckoutPage({required this.data, Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Variables
  int namelimit = 16;
  int categorylimit = 35;
  int items = 1;
  String deliveryValue = "self_pickup";
  Map deliveryName = {
    "self_pickup": "Self Pickup",
    "regular": "Regular Delivery",
    "priority": "Priority Delivery",
  };
  String paymentValue = "qris";
  Map paymentName = {
    "qris": "QRIS",
    "card": "Credit/Debit Card",
    "cod": "Cash on Delivery",
  };
  String voucherValue = "uid123";
  Map voucherName = {
    "uid123": "Free Delivery up to 8k",
    "uid456": "Free Delivery up to 8k",
  };

  // Actions
  String _overflowText(String text, int limit){
      if (text.length >= limit){
        return text.substring(0, limit - 3) + "...";
      } else {
        return text;
      }
    }
  void increaseItem(){
    setState(() {
      items++;
    });
  }
  void decreaseItem(){
    if(items > 1){
      setState(() {
      items--;
    });
    }
  }

  // Actions
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
                          "Rp 0",
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
                          "Rp 8.000",
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
                          "Rp 12.000",
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
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: voucherValue == "uid123" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
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
                                      "assets/delivery_icon.svg"
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          voucherName["uid123"],
                                          style: TextStyle(
                                            fontFamily: "Urbanist",
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        Text(
                                          "Minimum purchase 30k",
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
                          value: 'uid123',
                          groupValue: voucherValue,
                          onChanged: (value) {
                            setState(() {
                              voucherValue = value!;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:  voucherValue == "uid456" ? Color.fromRGBO(43, 192, 159, 1) : Color.fromRGBO(0, 0, 0, 0.15), width: 1
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
                                      "assets/delivery_icon.svg"
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          voucherName["uid456"],
                                          style: TextStyle(
                                            fontFamily: "Urbanist",
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        Text(
                                          "Minimum purchase 30k",
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
                          value: 'uid456',
                          groupValue: voucherValue,
                          onChanged: (value) {
                            setState(() {
                              voucherValue = value!;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                  
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


  // Widgets
  Widget orderedItem(){
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
                        widget.data["name"],
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
                              onTap: decreaseItem,
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
                                items.toString(),
                                style: TextStyle(
                                  fontFamily: "Urbanist",
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: increaseItem,
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
                          image: NetworkImage(widget.data["img"]),
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
                        if(widget.data["discount"] > 0) Text(
                          "Rp ${widget.data["price"]}",
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
                          "Rp ${(widget.data["price"] - (widget.data["price"] * widget.data["discount"])).round()}",
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
      padding: EdgeInsets.only(left: 15, right: 0, top: 0, bottom: 12),
      width: screenWidth - 60,
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
                        fontSize: 16
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
  Widget paymentDetails(){
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
                      "Rp 30.000",
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
                      "Rp 8.000",
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
                      "Shipping Discount Total",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        color: Color.fromRGBO(0, 0, 0, 0.5),
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "-Rp 8.000",
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
                      "Rp 30.000",
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
                    "Rp 8.000",
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
                    voucherName[voucherValue],
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


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                  "Rp 30.000",
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
              onPressed: (){
                Navigator.pushNamed(context, "/waitingpage");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: Text(
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
                _overflowText(widget.data["restaurant"]["name"], namelimit),
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
                        Icons.star,
                        color: Color.fromRGBO(226, 76, 0, 1),
                        size: 14,
                      ),
                      Text(
                        widget.data["restaurant"]["rating"].toString(),
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
                        Icons.location_on_outlined,
                        color: Color.fromRGBO(226, 76, 0, 1),
                        size: 14,
                      ),
                      Text(
                        "${widget.data["restaurant"]["distance"].toString()} km",
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
                orderedItem(),
                
                
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
                      "Rp 38.000",
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
          paymentDetails(),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}