// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CheckoutPage extends StatefulWidget {
  CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String selectedValue = 'card';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: screenWidth - 33,
        height: 55,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, "/waitingpage");
          },
          backgroundColor: Color.fromRGBO(43, 192, 159, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Proceed to Payment",
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Text(
              "Payment Options",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w900,
                fontSize: 27,
                color: Colors.black
              ),
            ),
            SizedBox(height: 18,),
            Text(
              "Payment Method",
              style: TextStyle(
                fontFamily: "Urbanist",
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 22
              ),
            ),
            SizedBox(height: 13,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile(
                  activeColor: Color.fromRGBO(43, 192, 159, 1),
                  contentPadding: EdgeInsets.zero,
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/payment_credit_icon.png"
                          ),
                          SizedBox(width: 15,),
                          Text(
                            "Credit / Debit card",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 16,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.15)
                        ),
                      )
                    ],
                  ),
                  value: 'card',
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Color.fromRGBO(43, 192, 159, 1),
                  contentPadding: EdgeInsets.zero,
                  title: Column(
                    children: [
                      Row(
                        children: [
                         Image.asset(
                            "assets/payment_cash_icon.png"
                          ),
                          SizedBox(width: 15,),
                          Text(
                            "Cash on Delivery",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 16,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.15)
                        ),
                      )
                    ],
                  ),
                  value: 'cash',
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                RadioListTile(
                  activeColor: Color.fromRGBO(43, 192, 159, 1),
                  contentPadding: EdgeInsets.zero,
                  title: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/payment_qris_icon.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          SizedBox(width: 15,),
                          Text(
                            "QRIS",
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              fontSize: 16,
                              color: Colors.black
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 13,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.15)
                        ),
                      )
                    ],
                  ),
                  value: 'qris',
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }
}