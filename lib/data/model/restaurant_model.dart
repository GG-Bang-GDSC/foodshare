import 'package:cloud_firestore/cloud_firestore.dart';

class restaurantModel {
  final int id;
  final List category;
  final String name;
  final String img;
  final num distance;
  final String discount;
  final double rating;
  final List location;

  const restaurantModel({
    required this.id,
    required this.category,
    required this.name,
    required this.img,
    required this.distance,
    required this.discount,
    required this.rating,
    required this.location
  });

  toJson(){
    return {
      "id": id,
      "category": category,
      "name": name,
      "img": img,
      "distance": distance,
      "discount": discount,
      "rating": rating,
      "location": location
    };
  }

  factory restaurantModel.fromSnapshot(DocumentSnapshot<Map> document) {
    final data = document.data()!;
    return restaurantModel(
      id: data["id"],
      category: data["category"],
      name: data["name"],
      img: data["img"],
      distance: data["distance"],
      discount: data["discount"],
      rating: data["rating"],
      location: data["location"]
    );
  }
}