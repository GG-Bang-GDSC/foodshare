import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodshare/data/local_database.dart';
import 'package:foodshare/data/model/food_model.dart';
import 'package:foodshare/data/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final _auth =  FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  LocalDatabase db = LocalDatabase();


  Future sendOrder(Map orderData) async {
    try {
      var order = await _db.collection("orders").add({
        "note": orderData["note"],
        "restaurantId": orderData["restaurantId"],
        "date": orderData["date"],
        "driver": orderData["driver"],
        "driverId": "Gzap0LO1WCp4sBTue47x",
        "location": orderData["location"],
        "menu": orderData["menu"],
        "name": orderData["name"],
        "payment": orderData["payment"],
        "shipFee": orderData["shipFee"],
        "status": orderData["status"],
        "promoDiscount": orderData["promoDiscount"],
        "userId":orderData["userId"],
      });

      return {"status": true};
    } catch(e){
      print("ERROR");
      return {"status": false, "error": e};
    }
  }

  Future<userModel?> getUserData(String id) async {
    try {
      final snapshot = await _db.collection("users").where("id", isEqualTo:  id).get();
      var userDocs = snapshot.docs.map((e) => userModel.fromSnapshot(e));
      if(snapshot.docs.length > 1){
        userDocs = userDocs.take(1);
      }
      final userData = userDocs.single;

      return userData;
    } catch(e){
      print("ERROR : ");
      print(e);
      return null;
    }
  }

  Future signUpWithEmail(String email, String password, Map data) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _db.collection("users").add(
        {
          "id": credential.user!.uid,
          "full_name": data["full_name"],
          "phone_number": data["phone_number"],
          "email": email,
          "profile_photo": "https://register.user.mpkjateng.com/assets/images/user.jpg",
          "vouchers": [],
          "contribution": [],
          "likes": [],
          "location": [],
        }
      );
      userModel? userData = await getUserData(credential.user!.uid);
      print(userData);
      // db.createInitialUserData();
      // db.userData = userData;
      // print(db.userData);
      // db.updateDatabase();

      return credential.user;
    } catch(e){
      return {"error": e};
    }
  }
  

  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // userModel userData = await getUserData(credential.user!.uid);
      // db.loadData();
      // db.createInitialUserData();
      // db.userData = userData;
      // db.updateDatabase();

      return {"user": credential.user};
    } catch(e){
      return {"error": e};
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
        );

        await _auth.signInWithCredential(credential);
        var cek = await getUserData(_auth.currentUser!.uid);
        if(cek == null){
            await _db.collection("users").add(
            {
              "id": _auth.currentUser!.uid,
              "full_name": _auth.currentUser!.displayName,
              "phone_number": _auth.currentUser!.phoneNumber,
              "email": _auth.currentUser!.email,
              "profile_photo": _auth.currentUser!.photoURL,
              "vouchers": [],
              "contribution": [],
              "likes": [],
              "location": [],
            }
          );
        // userModel userData = await getUserData(_auth.currentUser!.uid);
        // db.createInitialUserData();
        // db.userData = userData;
        // db.updateDatabase();
        }
        

        return {"message": "success"};
      }
    } catch(e){
      return {"error": e};
    }
  }

  Future updateUserData(Map userData) async {
    print("UPDATE");
    print(userData);
    var dataToUpdate = await _db.collection("users").where("id", isEqualTo: _auth.currentUser!.uid).get();
    if(dataToUpdate.docs.isNotEmpty){
      var updateData = _db.collection("users").doc(dataToUpdate.docs.first.id);
      await updateData.update(
       {
        "full_name": userData["full_name"],
        "email": userData["email"],
        "phone_number": userData["phone_number"],
       }
      );
      print('Document updated successfully.');
    } else {
      print('No documents found with the specified condition.');
    }
  }

  void signOut(){
    _auth.signOut();
  }


  bool IsLogged(){
    User? user = _auth.currentUser;
    if(user == null){
      return false;
    } else {
      print(user);
      return true;
    }
  }
}
