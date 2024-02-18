// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/restaurant_controller.dart';
import 'package:foodshare/data/model/restaurant_model.dart';

class AddRestaurantPage extends StatefulWidget {
  AddRestaurantPage({super.key});

  @override
  State<AddRestaurantPage> createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  // Variables
  TextEditingController _id = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _discount = TextEditingController();
  TextEditingController _distance = TextEditingController();
  TextEditingController _img = TextEditingController();
  TextEditingController _rating = TextEditingController();
  // bool _passwordVisible = false;
  // bool _passwordConfirmVisible = false;

  @override
  Widget build(BuildContext context) {
    void toLoginPage(){
      Navigator.pushNamed(context, "/signinpage");
    }
    void addRestaurant(){
      final restaurant = restaurantModel(
        id: int.parse(_id.text),
        name: _name.text,
        category: _name.text.split(","),
        discount: _discount.text,
        distance: num.parse(_distance.text),
        img: _img.text,
        rating: double.parse(_rating.text),
        location: [0,0]
      );
      RestaurantController restaurantController = RestaurantController();
      restaurantController.createRestaurant(restaurant);
      Navigator.pushNamed(context, "/mainpage");
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(right: 20, left: 20, top: 80, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 18),
                    child: SvgPicture.asset(
                      "assets/foodshare_logo.svg",
                      fit: BoxFit.scaleDown,
                      width: 35,
                    ),
                  ),
                  SizedBox(width: 20,),
                  Text(
                    "Add Restaurant",
                    style: TextStyle(
                      color: Color.fromRGBO(43, 192, 159, 1),
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 40
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Id",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color.fromRGBO(59, 0, 125,1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _id,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30),
                        hintText: "Enter restaurant id..."
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color.fromRGBO(59, 0, 125,1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _name,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Enter restaurant name...",
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color.fromRGBO(59, 0, 125,1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _category,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Enter restaurant category...",
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Img",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color.fromRGBO(59, 0, 125,1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _img,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Enter restaurant img...",
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Distance",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color.fromRGBO(59, 0, 125,1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _distance,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Enter restaurant distance...",
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Discount",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color.fromRGBO(59, 0, 125,1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _discount,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Enter restaurant discount...",
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rating",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.w700,
                      fontSize: 20
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: double.infinity,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: Color.fromRGBO(59, 0, 125,1),
                        width: 1.0,
                      ),
                    ),
                    child: TextField(
                      controller: _rating,
                      style: TextStyle(
                        fontFamily: "Urbanist"
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                        hintText: "Enter restaurant rating...",
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: 15,),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: addRestaurant,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                  elevation: 0,
                  minimumSize: const Size.fromHeight(55),
                ), 
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Urbanist",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                )
              ),
              SizedBox(height: 25,),
              Text(
                "or using",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Urbanist",
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              ),
              SizedBox(height: 25,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: SvgPicture.asset(
                      "assets/facebook_logo.svg",
                      fit: BoxFit.scaleDown
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: SvgPicture.asset(
                      "assets/google_logo.svg",
                      fit: BoxFit.scaleDown
                    ),
                  ),
                  SizedBox(width: 15,),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: SvgPicture.asset(
                      "assets/instagram_logo.svg",
                      fit: BoxFit.scaleDown
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      fontFamily: "Urbanist",
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: toLoginPage,
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        fontFamily: "Urbanist",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(43, 192, 159, 1),
                        decorationThickness: 3.0
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}