import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final firebase_db = FirebaseDatabase.instance.ref();
  List restaurantItems = [];
  List foodItems = [];

  Future<void> fetchData() async {
    final restaurant = await firebase_db.child('restaurants').get();
    final food = await firebase_db.child('foods').get();
    if(restaurant.exists) {
      restaurantItems = restaurant.value as List;
    } 
    if(food.exists){
      foodItems = food.value as List; 
    }
  }
}