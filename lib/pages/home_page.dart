// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodshare/data/controller/restaurant_controller.dart';
import 'package:foodshare/data/firebase.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:foodshare/data/model/restaurant_model.dart';
import 'package:hive/hive.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("myBox");
  LocalDatabase db = LocalDatabase();

  @override
  void initState(){
    if(_myBox.get("history_items") == null){
      db.createInitialData();
      db.updateDatabase();
    } else{
      db.loadData();
    }

    super.initState();
    setState(() {
    getLocation();
    });
  }

  // Variables
  int namelimit = 22;
  //FirebaseService fdb = FirebaseService();
  List restaurantItems = [];
  RestaurantController restaurantController = RestaurantController();
  Location currentLocation = Location();
  
  // Actions
  void getLocation() async{
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){
      setState(() {
        db.locations["current_location"] = [loc.latitude ?? 0.0, loc.longitude ?? 0.0];
        db.updateDatabase();
      });
    });
  }
  String _overflowText(String text, int limit){
    if (text.length >= limit){
      return text.substring(0, limit - 3) + "...";
    } else {
      return text;
    }
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
    }; 
    print(_restaurantData);
    Navigator.pushNamed(context, "/restaurantpage", arguments: _restaurantData);
  }

  // Widgets
  Widget topPicks(Map data){
    return GestureDetector(
      onTap: () => checkDishes(data["id"], data["name"], data["img"], data["distance"], data["category"], data["discount"], data["rating"]),
      child: Container(
            margin: EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 270,
                  height: 140,
                  padding: EdgeInsets.only(right: 10, top: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        data["img"],
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 130,
                        height: 23,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomRight: Radius.circular(100),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "10 Coupons only",
                            style: TextStyle(
                                fontFamily: "Urbanist",
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w700
                              ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 11,),
                Container(
                  width: 270,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _overflowText(data["name"], namelimit),
                            style: TextStyle(
                              fontFamily: "Urbanist",
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0,-3),
                            child: Text(
                              "Free Delivery . 15-30 min",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                color: Colors.black,
                                fontSize: 13
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color.fromRGBO(0, 0, 0, 0.07)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              data["rating"].toString(),
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                fontWeight: FontWeight.w700,
                                fontSize: 13
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
    );
  }
  Widget cuisine(){
    return Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://png.monster/wp-content/uploads/2022/06/png.monster-608.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              SizedBox(height: 4,),
              Text(
                "Bakery",
                style: TextStyle(
                    fontFamily: "Urbanist",
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
        );
  }
  Widget nearme(){
    return Container(
          margin: EdgeInsets.only(right: 15),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://img.pikbest.com/ai/illus_our/20230427/e42a65c1e4b8c80d3522f4bc09e609db.jpg!sw800",
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
              SizedBox(height: 4,),
              Text(
                "Bakery",
                style: TextStyle(
                    fontFamily: "Urbanist",
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700
                ),
              )
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.transparent,
        toolbarHeight: 140,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/locationpage");
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deliver to",
                          style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Current Location",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(width: 5,),
                            Transform.translate(
                              offset: Offset(0, -2),
                              child: Transform.rotate(
                                angle: -90 * 3.1415926535 / 180,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 12,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                ),

                  Row(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 3),
                        child: SvgPicture.asset(
                          "assets/home_love_icon.svg",
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      SizedBox(width: 8,),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "/mycartpage");
                        },
                        child: Transform.translate(
                          offset: Offset(0, 3),
                          child: SvgPicture.asset(
                            "assets/shopping_bag_icon.svg",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/searchpage");
              },
              child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromRGBO(239, 239, 239, 1)
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20,),
                      GestureDetector(
                  //     onTap: search_action,
                        child: Icon(
                          Icons.search,
                          color: Color.fromRGBO(0, 0, 0, 1),
                          size: 25,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "What do you want to eat today?",
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              fontSize: 16
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.restaurant,
                        color: Color.fromRGBO(43, 192, 159, 1),
                        size: 25,
                      ),
                      SizedBox(width: 23,),
                    ],
                  ),
                ),
            ),
          ],
        ),
        leadingWidth: 0,
        leading: Container(),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Top picks for you",
              style: TextStyle(
                fontFamily: "Urbanist",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          SizedBox(height: 15,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: FutureBuilder<List<restaurantModel>>(
                future: restaurantController.getRestaurants(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Row(
                      children: snapshot.data!.map((item){
                        Map restaurant = {
                          "id": item.id,
                          "category": item.category,
                          "name": item.name,
                          "img": item.img,
                          "distance": item.distance,
                          "discount": item.discount,
                          "rating": item.rating
                        };
                        return topPicks(restaurant);
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                }
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose from cuisine",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
                // ElevatedButton(
                //   onPressed: (){},
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                //     minimumSize: Size(50, 30),
                //     elevation: 0,
                //     padding: EdgeInsets.symmetric(horizontal: 12)
                //   ),
                //   child: Text(
                //     "See all",
                //     style: TextStyle(
                //       fontFamily: "Urbanist",
                //       color: Colors.white,
                //       fontSize: 15,
                //   ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(height: 15,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                SizedBox(width: 20,),
                cuisine(),
                cuisine(),
                cuisine(),
                cuisine(),
                cuisine(),
                cuisine(),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Near me",
                  style: TextStyle(
                    fontFamily: "Urbanist",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
                // ElevatedButton(
                //   onPressed: (){},
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color.fromRGBO(43, 192, 159, 1),
                //     minimumSize: Size(50, 30),
                //     elevation: 0,
                //     padding: EdgeInsets.symmetric(horizontal: 12)
                //   ),
                //   child: Text(
                //     "See all",
                //     style: TextStyle(
                //       fontFamily: "Urbanist",
                //       color: Colors.white,
                //       fontSize: 15,
                //   ),
                //   ),
                // )
              ],
            ),
          ),
          SizedBox(height: 15,),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                SizedBox(width: 20,),
                nearme(),
                nearme(),
                nearme(),
              ],
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}