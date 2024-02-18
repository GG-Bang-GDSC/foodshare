import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodshare/data/model/food_model.dart';
import 'package:foodshare/data/model/restaurant_model.dart';
import 'package:get/get.dart';

class FoodRepository{

  final _db = FirebaseFirestore.instance;

  createFood(foodModel food) async {
    await _db.collection("foods").add(food.toJson());
  }

  Future<List<foodModel>> getFoods(int restaurantId) async {
    final snapshot = await _db.collection("foods").where("restaurantId", isEqualTo:  restaurantId).get();
    final foodData = snapshot.docs.map((e) => foodModel.fromSnapshot(e)).toList();
    return foodData;
  }
  Future<List<foodModel>> getFoodsHappyHour(double discount) async {
    final snapshot = await _db.collection("foods").where("discount", isGreaterThanOrEqualTo: discount).get();
    final foodData = snapshot.docs.map((e) => foodModel.fromSnapshot(e)).toList();
    return foodData;
  }

  Future<List> searchFoods(String keyword, int filter) async {
    Map restaurantMap = {}; 
    final snapshot = await _db.collection("foods").get();
    final foodDataRaw = snapshot.docs.map((e) => foodModel.fromSnapshot(e)).toList();
    final foodData = foodDataRaw.where((food) => food.name.toLowerCase().contains(keyword.toLowerCase())).toList();
    for(int i = 0; i < foodData.length;i++){
      if(restaurantMap.containsKey(foodData[i].restaurantId)){
        restaurantMap[foodData[i].restaurantId].add(foodData[i]);
      } else {
        restaurantMap[foodData[i].restaurantId] = [foodData[i]];
      }
    }

    List results = [];

    for (var entry in restaurantMap.entries) {
      var key = entry.key;
      var value = entry.value;
      final snapshotR = await _db.collection("restaurants").where("id", isEqualTo:  key).get();
      var restaurantData = snapshotR.docs.map((e) => restaurantModel.fromSnapshot(e)).single;
      Map restaurantResult = restaurantData.toJson();
      restaurantResult["foods"] = value;
      results.add(restaurantResult);
    }
    if(filter == 1){
      results =  List.from(results)..sort((a, b) => a['distance'].compareTo(b['distance']));
    } else if(filter == 2){
      results = results.where((item) => item['rating'] >= 4.5).toList();
    } else {
      results = results;
    }

    //print(results);
    
    return results;
  }
}