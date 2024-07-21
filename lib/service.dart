import 'dart:developer';

// ignore: library_prefixes
import 'package:flutter/services.dart' as rootBundle;

import 'data.dart';

class Service {
  static Future<RestaurantPost> getRestaurant() async {
    try {
      final response = await rootBundle.rootBundle
          .loadString('jsonfile/local_restaurant.json');
      final RestaurantPost listRestaurant = restaurantPostFromJson(response);
      return listRestaurant;
    } catch (e) {
      log("message: $e");
      return RestaurantPost(restaurants: <Restaurant>[]);
    }
  }
}
