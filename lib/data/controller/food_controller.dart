import 'package:foodshare/data/model/food_model.dart';
import 'package:foodshare/data/repository/food_repository.dart';
import 'package:get/get.dart';

class FoodController extends GetxController {
 // static FoodController get instance => Get.find();

  final foodRepo = Get.put(FoodRepository());

  Future<void> createFood(foodModel food) async {
    await foodRepo.createFood(food);
  }

  Future<List<foodModel>> getFoods(int restaurantId) async {
    return await foodRepo.getFoods(restaurantId);
  }

  Future<List<foodModel>> getFoodsHappyHour(double discount) async {
    return await foodRepo.getFoodsHappyHour(discount);
  }

  Future<List> searchFoods(String keyword, int filter) async {
    return await foodRepo.searchFoods(keyword, filter);
  }
}