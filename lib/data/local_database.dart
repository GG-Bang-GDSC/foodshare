import 'package:hive_flutter/hive_flutter.dart';

class LocalDatabase {
  // Hive box
  final _myBox = Hive.box("myBox");

  // History items
  List historyItems = [];

  // Initial data
  void createInitialData(){
    historyItems = [];
  }

  // load data
  void loadData(){
    historyItems = _myBox.get("history_items");
  }

  // update database
  void updateDatabase(){
    _myBox.put("history_items", historyItems);
  }

}