import 'package:foodshare/data/model/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  // Hive box
  final _myBox = Hive.box("myBox");

  // History items
  List historyItems = [];

  // Cart items
  Map cartItems = {};

  // Location
  Map locations = {
    "current_location": [],
  };

  // Initial data
  void createInitialData(){
    historyItems = [];
    cartItems = {};
    locations = {
      "current_location": [],
    };
  }

  // load data
  void loadData(){
    historyItems = _myBox.get("history_items");
    cartItems = _myBox.get("cart_items");
    locations = _myBox.get("locations");
  }

  // update database
  void updateDatabase(){
    _myBox.put("history_items", historyItems);
    _myBox.put("cart_items", cartItems);
    _myBox.put("locations", locations);
  }

}