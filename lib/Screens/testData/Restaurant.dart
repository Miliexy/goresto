import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  late String cityName;
}

class Tag {
  late String tagName;

}

List<Restaurant> restaurantList = [
  Restaurant()
];