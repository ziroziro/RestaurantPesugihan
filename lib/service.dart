import 'dart:developer';

import 'package:http/http.dart' as http;

import 'data.dart';

class Service {
  static const String url =
      'https://raw.githubusercontent.com/dicodingacademy/assets/main/flutter_fundamental_academy/local_restaurant.json';

  static Future<RestaurantPost> getRestaurant() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final RestaurantPost listRestaurant =
            restaurantPostFromJson(response.body);
        return listRestaurant;
      } else {
        log("message: Failed");
        return RestaurantPost(restaurants: <Restaurant>[]);
      }
    } catch (e) {
      log("message: $e");
      return RestaurantPost(restaurants: <Restaurant>[]);
    }
  }
}
