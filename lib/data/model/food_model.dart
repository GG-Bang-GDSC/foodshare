import 'package:cloud_firestore/cloud_firestore.dart';

class foodModel {
  final int restaurantId;
  final String name;
  final String img;
  final String description;
  final int price;
  final int stock;
  final num discount;
  final int afterPrice;

  const foodModel({
    required this.restaurantId,
    required this.name,
    required this.img,
    required this.description,
    required this.price,
    required this.stock,
    required this.discount,
    required this.afterPrice,
  });

  toJson(){
    return {
      "restaurantId": restaurantId,
      "description": description,
      "name": name,
      "img": img,
      "price": price,
      "discount": discount,
      "afterPrice": afterPrice,
      "stock": stock
    };
  }

  factory foodModel.fromSnapshot(DocumentSnapshot<Map> document) {
    final data = document.data()!;
    return foodModel(
      restaurantId: data["restaurantId"],
      description: data["description"],
      name: data["name"],
      img: data["img"],
      price: data["price"],
      discount: data["discount"],
      afterPrice: data["afterPrice"],
      stock: data["stock"]
    );
  }
}