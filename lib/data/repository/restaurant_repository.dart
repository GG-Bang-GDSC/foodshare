import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodshare/data/model/restaurant_model.dart';
import 'package:get/get.dart';

class RestaurantRepository{

  final _db = FirebaseFirestore.instance;

  createRestaurant(restaurantModel restaurant) async {
    await _db.collection("restaurants").add(restaurant.toJson());
  }

  Future<restaurantModel> getRestaurantDetail(int id) async {
    final snapshot = await _db.collection("restaurants").where("id", isEqualTo:  id).get();
    final restaurantData = snapshot.docs.map((e) => restaurantModel.fromSnapshot(e)).single;
    return restaurantData;
  }
  Future getRestaurantID(int id) async {
    final snapshot = await _db.collection("restaurants").where("id", isEqualTo:  id).get();
    final restaurantData = snapshot.docs.single.id;
    return restaurantData;
  }

  Future<List<restaurantModel>> getRestaurants() async {
    final snapshot = await _db.collection("restaurants").get();
    final restaurantData = snapshot.docs.map((e) => restaurantModel.fromSnapshot(e)).toList();
    return restaurantData;
  }
}