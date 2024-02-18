import 'package:foodshare/data/local_database.dart';
import 'package:foodshare/data/model/user_model.dart';
import 'package:foodshare/data/repository/auth_repository.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  AuthRepository authRepo = AuthRepository();
  LocalDatabase db = LocalDatabase();

  List checkNull(Map data, String type){
    bool valid = true;
    Map signUpNull = {
      "email": false,
      "full_name": false,
      "password": false,
      "password_confirmation": false,
      "phone_number": false,
    };
    Map signInNull = {
      "email": false,
      "password": false,
    };
    var entryVar = type == "signin" ? signInNull : signUpNull;
    for(var entry in entryVar.entries){
      var key = entry.key;
      var value = data[key];
      if((value == null) || (value.length < 1)){
        valid = false;
        entryVar[key] = true;
      }
    }

    return [valid, entryVar];
  }
  List checkFormat(Map data, String type){
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    bool valid = true;
    Map signUpError = {
      "email": false,
      "full_name": false,
      "password": false,
      "password_confirmation": false,
      "phone_number": false,
    };
    if(!emailRegExp.hasMatch(data["email"])){
      signUpError["email"] = true;
      valid = false;
    }
    if(type == "signup"){
      if((data["password"].length < 8) || (data["password"].length > 24)){
        signUpError["password"] = true;
        valid = false;
      }
      if(data["password"] != data["password_confirmation"]){
        signUpError["password_confirmation"] = true;
        valid = false;
      }
    }
  
    return [valid, signUpError];
  }

  Future<userModel?> getUserData(String id) async {
    print("ID : "+id);
    userModel? userData = await authRepo.getUserData(id);
    return userData;
  }

  Future updateUserData(Map userData) async {
    authRepo.updateUserData(userData);
  }
  
  Future signUpWithEmail(Map data) async {
    if(!checkNull(data, "signup")[0]){
      return {
        "message": "wrong request format",
        "data": ["null", checkNull(data, "signup")[1]]
      };
    }
    if(!checkFormat(data, "signup")[0]){
      return {
        "message": "wrong request format",
        "data": ["format", checkFormat(data, "signup")[1]]
      };
    }

    var signUp = await authRepo.signUpWithEmail(data["email"], data["password"], data);
    if(signUp is Map){
      return signUp;
    } else {
      return {"message": "success"};
    }
  }


  Future signInWithEmail(Map data) async {
    if(!checkNull(data, "signin")[0]){
      return {
        "message": "wrong request format",
        "data": ["null", checkNull(data, "signin")[1]]
      };
    }
    if(!checkFormat(data, "signin")[0]){
      return {
        "message": "wrong request format",
        "data": ["format", checkFormat(data, "signin")[1]]
      };
    }
    var signIn = await authRepo.signInWithEmail(data["email"], data["password"]);
    if(signIn.containsKey("error")){
      return signIn;
    } else {
      return {"message": "success", "data": signIn};
    }
  }


  Future signInWithGoogle() async {
    var signIn = await authRepo.signInWithGoogle();
    return signIn;
  }


  void signOut(){
    authRepo.signOut();
  }

  
  bool IsLogged(){
    return authRepo.IsLogged();
  }

  Future sendOrder(Map orderData){
    return authRepo.sendOrder(orderData);
  }
}