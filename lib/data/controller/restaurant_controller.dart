import 'package:foodshare/data/model/restaurant_model.dart';
import 'package:foodshare/data/repository/restaurant_repository.dart';
import 'package:get/get.dart';

class RestaurantController extends GetxController {
 // static RestaurantController get instance => Get.find();

  final restaurantRepo = Get.put(RestaurantRepository());

  Future<void> createRestaurant(restaurantModel restaurant) async {
    await restaurantRepo.createRestaurant(restaurant);
  }

  getRestaurantDetail(int id){
    return restaurantRepo.getRestaurantDetail(id);
  }

  Future getRestaurantID(int id) async {
    var restaurantData = await restaurantRepo.getRestaurantID(id);
    return restaurantData;
  }

  Future<List<restaurantModel>> getRestaurants() async {
    return await restaurantRepo.getRestaurants();
  }
}