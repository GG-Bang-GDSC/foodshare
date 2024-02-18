import 'package:cloud_firestore/cloud_firestore.dart';

class userModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String profilePhoto;
  final List vouchers;
  final List contribution;
  final List likes;
  final List location;

  const userModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.profilePhoto,
    required this.vouchers,
    required this.contribution,
    required this.likes,
    required this.location,
  });

  toJson(){
    return {
      "id": id,
      "full_name": fullName,
      "phone_number": phoneNumber,
      "email": email,
      "profile_photo": profilePhoto,
      "vouchers": vouchers,
      "contribution": contribution,
      "likes": likes,
      "location": location,
    };
  } 

  factory userModel.fromSnapshot(DocumentSnapshot<Map> document) {
    final data = document.data()!;

    if(data["phone_number"] == null){
      data["phone_number"] = "";
    }
    
    return userModel(
      id: data["id"],
      fullName: data["full_name"],
      phoneNumber: data["phone_number"],
      email: data["email"],
      profilePhoto: data["profile_photo"],
      vouchers: data["vouchers"],
      contribution: data["contribution"],
      likes: data["likes"],
      location: data["location"]
    );
  }
}