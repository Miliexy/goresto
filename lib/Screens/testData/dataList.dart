import 'dart:ffi';

import 'package:geocoding/geocoding.dart';
import 'package:goresto/Services/location.dart';



enum citiesList {Casablanca, Rabat, Marrakech, Tanger}

List<Map<String, dynamic>> restaurantsList = [
  {
    "name": "Boddaci",
    "coords": {
      "latitude" : 52.2165157,
      "longitude" : 6.9437819
    },
    "imagePath": "assets/images/fine-dining1.jpg",
    "logo" : "assets/images/restaurant_Avatar1.png",
    "Tags": [
      tagsList[0].values,
    ],
    "minPrice": 19,
    "maxPrice": 549,
    "city": citiesList.Casablanca,
    "categories": [categoriesList.contains("moroccan")],
    "rating" : 4.5
  },
  {
    "name": "Monrrol",
    "coords": {
      "latitude" : 33.5826015,
      "longitude" : -7.6407117
    },
    "imagePath": "assets/images/fine-dining2.jpg",
    "logo" : "assets/images/restaurant_Avatar1.png",
    "Tags": [
      tagsList[3].values,
    ],
    "minPrice": 19,
    "maxPrice": 549,
    "city": citiesList.Rabat,
    "categories": [categoriesList.contains("asian")],
    "rating" : 2
  },

  {
    "name": "Capiano",
    "coords": {
      "latitude" : 33.5629841,
      "longitude" : -7.5990361
    },
    "imagePath": "assets/images/fine-dining3.jpg",
    "logo" : "assets/images/restaurant_Avatar2.png",
    "Tags": [
      tagsList[0].values,
    ],
    "minPrice": 20,
    "maxPrice": 549,
    "city": citiesList.Tanger,
    "categories": [categoriesList.contains("italian")],
    "rating" : 3
  },
];

List categoriesList = ["asian", "american", "french", "moroccan", "italian"];

List<Map<String, dynamic>> tagsList = [
  {"tag": "Bike Parking", "isSelected": false},
  {"tag": "Coupons", "isSelected": false},
  {"tag": "Parking Street", "isSelected": false},
  {"tag": "Wireless Internet", "isSelected": false},
  {"tag": "Accepts Credit Cards", "isSelected": false}
];

Future<List<Map<String, dynamic>>> getData() async{
  restaurantsList.forEach((e) async {
      List<Placemark> placeMark = await GetLocation().decodingLocationFromLatLng(e["coords"]["latitude"], e["coords"]["longitude"]);
      e.putIfAbsent("placemark", () => placeMark);

  });
  return restaurantsList;
}
