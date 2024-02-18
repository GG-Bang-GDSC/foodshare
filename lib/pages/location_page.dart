// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:location/location.dart';

class LocationPage extends StatefulWidget {
  LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState(){
    if(_myBox.get("locations") == null){
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
  final _myBox = Hive.box("myBox");
  LocalDatabase db = LocalDatabase();
  GoogleMapController? _controller;
  Location currentLocation = Location();
  Set<Marker> _markers= {
    Marker(
      markerId: MarkerId('Home'),
      position: LatLng(-7.770717, 110.377724)
    )
  };
 
 
  void getLocation() async{
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc){
      _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(loc.latitude ?? 0.0,loc.longitude?? 0.0),
        zoom: 18.0,
      )));
      setState(() {
        _markers.add(Marker(markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)
        ));
        db.locations["current_location"] = [loc.latitude ?? 0.0, loc.longitude ?? 0.0];
        db.updateDatabase();
      });
       });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition:CameraPosition(
            target: ((db.locations["current_location"] == []) || (db.locations["current_location"] == null)) ? LatLng(48.8561, 2.2930) : LatLng(db.locations["current_location"][0], db.locations["current_location"][1]),
            zoom: 18,
          ),
          onMapCreated: (GoogleMapController controller){
            _controller = controller;
          },
          markers: _markers,
        ) ,
      ),
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: ugmLocation,
      //     zoom: 18
      //   ),
      //   markers: _markers,
      //   // onMapCreated: (GoogleMapController controller){
      //   //   _controller = controller;
      //   // },
      // ),
    );
  }
}