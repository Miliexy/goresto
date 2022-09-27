import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Restaurant {
  var key = UniqueKey();
  late String restaurantName;
  late String restaurantDescription;
  late String restaurantImagePath;
  late LatLng latLng;

  late List<Tag> tags;
  late List<City> cities;

  Restaurant();

}

class City {
  final String cityName;

  const City({
    required this.cityName
});
}

class Tag {
  late String tagName;

}

List<Restaurant> restaurantList = [
  Restaurant()
];

class RestaurantType {

  final String typeName;

  const RestaurantType({
    required this.typeName
});

  static RestaurantType fromJson(Map<String, dynamic> json) =>RestaurantType(typeName: json["name"]);
}


class RestaurantApi{
  static Future<List<RestaurantType>> getUserSuggestions(String query ) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if(response.statusCode ==200) {
      final List data = json.decode(response.body);
      return data
          .map(
        (e) => RestaurantType.fromJson(e),
      )
          .where((element) {
        final nameLower = element.typeName.toLowerCase();
        final queryLower = query.toLowerCase();
        return nameLower.contains(queryLower);
      }).toList();
    } else{
      throw Exception();
    }
  }
}