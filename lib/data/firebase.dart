import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final firebase_db = FirebaseFirestore.instance;
  List restaurantItems = [];
  List foodItems = [];

  Future<void> fetchData() async {
    try {
      final restaurant = await firebase_db.collection('restaurants').get();
      final food = await firebase_db.collection('foods').get();

      if (restaurant.docs.isNotEmpty) {
        restaurantItems = restaurant.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      }

      if (food.docs.isNotEmpty) {
        foodItems = food.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }
}
  // final db = FirebaseFirestore.instance;
  // Map restaurants = {};
  // List foods = [];
  // Future<void> searchData(String keyword) async {
  //     await db.collection("foods").get().then((event) {
  //       for (var doc in event.docs) {
  //         //print("${doc.id} => ${doc.data()}");
  //         if(doc.data()["name"].toLowerCase().contains(keyword.toLowerCase())){
  //           if(restaurants[doc.data()["restaurantId"]] != null){
  //             restaurants[doc.data()["restaurantId"]].add(doc.data());
  //           } else {
  //             restaurants[doc.data()["restaurantId"]] = [doc.data()];
  //           }
  //         }
  //       }
  //     });
  //     restaurants.forEach((key, value) async {
  //       await db.collection("restaurants").get().then((event) {
  //       for (var doc in event.docs) {
  //         //print("${doc.id} => ${doc.data()}");
  //         // if(doc.data()["name"].contains(keyword)){
  //         //   if(restaurants[doc.data()["restaurantId"]] != null){
  //         //     restaurants[doc.data()["restaurantId"]].add(doc.data());
  //         //   } else {
  //         //     restaurants[doc.data()["restaurantId"]] = [doc.data()];
  //         //   }
  //         // }
  //         if(doc.data()["id"] == key){
  //           Map restaurantData = doc.data() as Map;
  //           restaurantData["foods"] = value;
  //           foods.add(restaurantData);
  //         }
  //       }
  //     });
//       });
//   }
// }