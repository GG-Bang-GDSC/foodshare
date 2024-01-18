// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class WaitingPage extends StatefulWidget {
  WaitingPage({super.key});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  bool _showFirstWidget = true;
  bool _showSecondWidget = true;

  @override
  void initState() {
    super.initState();

    // Duration for each widget's fade-in animation
    const Duration duration = Duration(seconds: 2);

    _controller1 = AnimationController(vsync: this, duration: duration);
    _controller2 = AnimationController(vsync: this, duration: duration);
    _controller3 = AnimationController(vsync: this, duration: duration);

    // Start animations sequentially
    _controller1.forward();
    _controller1.addStatusListener((status) {
      setState(() {
          _showFirstWidget = false;
        });
      if (status == AnimationStatus.completed) {
        _controller2.forward();
        _controller3.forward();
      }
    });

    _controller2.addStatusListener((status) {
      
      if (status == AnimationStatus.completed) {
        setState(() {
          _showSecondWidget = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  // Widgets
  Widget _orderItem(){
    return Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg/1200px-Outdoors-man-portrait_%28cropped%29.jpg"
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ayam Oseng Kangkung",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14
                        ),
                      ),
                      Text(
                        "x 4",
                        style: TextStyle(
                          fontFamily: "Urbanist",
                          fontSize: 14
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                      "Rp 30.000",
                      style: TextStyle(
                        fontFamily: "Urbanist",
                        fontSize: 13
                      ),
                  ),
                ),
              )
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        clipBehavior: Clip.none,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leadingWidth: 75,
        leading: Container(
          margin: EdgeInsets.only(top: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/mainpage");
            },
            child: Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.all(8), 
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 5, 
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                size: 20,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Icon(
              Icons.more_vert,
              size: 30,
            ),
          ),
          SizedBox(width: 20,)
        ],
      ),
      floatingActionButton: FadeTransition(
        opacity: _controller3,
        child: Container(
          width: screenWidth - 33,
          decoration: BoxDecoration(
            color: Color.fromRGBO(44, 39, 57, 1),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg/1200px-Outdoors-man-portrait_%28cropped%29.jpg"
                          ),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Jeremy Either",
                              style: TextStyle(
                                fontFamily: "Urbanist",
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 17,
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "4.8",
                                  style: TextStyle(
                                    fontFamily: "Urbanist",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/chat_icon.png"
                          ),
                          SizedBox(width: 10,),
                          Icon(
                            Icons.local_phone,
                            color: Color.fromRGBO(255, 173, 0, 1),
                            size: 27,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 290,
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40)
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(43, 192, 159, 1),
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.history,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: List.generate(15~/1, (index) => Container(
                                        height: 6,
                                        child: Container(
                                              color: index%2==0?Colors.black38
                                              :Colors.transparent,
                                              width: 1,
                                            ),
                                      )),
                                    ),
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delivery Time 12:46",
                                          style: TextStyle(
                                            fontFamily: "Urbanist",
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Distance from you: ",
                                              style: TextStyle(
                                                fontFamily: "Urbanist",
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "2.1 km",
                                              style: TextStyle(
                                                fontFamily: "Urbanist",
                                                fontSize: 14,
                                                color: Colors.red
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 21,),
                                        Text(
                                          "Catering",
                                          style: TextStyle(
                                            fontFamily: "Urbanist",
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 21,),
                                        Text(
                                          "Order placed",
                                          style: TextStyle(
                                            fontFamily: "Urbanist",
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            SizedBox(height: 15,),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(43, 192, 159, 1),
                                        borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Lesehan Ci Lin",
                                          style: TextStyle(
                                            fontFamily: "Urbanist",
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                            _orderItem(),
                            _orderItem(),
                            _orderItem(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage("assets/map_fake.png")
                )
              ),
            ),
            if(_showFirstWidget) Positioned(
                child: FadeTransition(
                  opacity: _controller1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      margin: EdgeInsets.only(top: 100),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text(
                        "Congratulation, you’ve got the coupons",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.white,
                            fontSize: 16,
                          ),
                      ),
                    ),
                  ),
                ),
              ),
              if(_showSecondWidget) Positioned(
                child: FadeTransition(
                  opacity: _controller2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      margin: EdgeInsets.only(top: 100),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(43, 192, 159, 1),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Text(
                        "Driver found!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Urbanist",
                            color: Colors.white,
                            fontSize: 16,
                          ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}