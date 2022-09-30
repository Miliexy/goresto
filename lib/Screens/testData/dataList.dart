import 'dart:ffi';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:goresto/Services/location.dart';
import 'package:goresto/constansts.dart';

enum citiesList { Casablanca, Rabat, Marrakech, Tanger }

List<Map<String, dynamic>> restaurantsList = [
  {
    "name": "Le Cuistot Traditionnel",
    "title": "Le patrimoine est dans l'assiette",
    "description":
        '''Dans l’atmosphère particulière du Cuistot Traditionnel à la fois chaleureuse et décontractée, le choix s’offre à vous.
Nous associons en effet les grands classiques de l’art culinaire marocain et authentique, le tout fait maison avec des ingrédients de qualité choisis méticuleusement''',
    "coords": {"latitude": 33.592666, "longitude": -7.621390},
    "imagePath": "assets/images/lecuissot.jpg",
    "logo": "assets/images/lecuissot_logo.png",
    "Tags": [
      tagsList[0],
    ],
    "minPrice": 19,
    "maxPrice": 549,
    "city": citiesList.Casablanca,
    "categories": [categoriesList[3],categoriesList[1]],
    "rating": 4.5,
    "social": [
      {
        "FaceBook": "https://www.facebook.com/lecuistotraditionnel",
        "icon": FontAwesomeIcons.facebook,
        "color": 0xFF4267B2
      },
      {
        "Instagram": "https://www.instagram.com/le_cuistot_traditionnel",
        "icon": FontAwesomeIcons.instagram,
        "color": 0xFF833ab4
      },
      {
        "Site": "https://lecuistot-traditionnel.com/",
        "icon": FontAwesomeIcons.globe,
        "color": kSecondaryColor.value
      }
    ]
  },
  {
    "name": "Monrrol",
    "title": "Le patrimoine est dans l'assiette",
    "description":
        '''Dans l’atmosphère particulière du Cuistot Traditionnel à la fois chaleureuse et décontractée, le choix s’offre à vous.
Nous associons en effet les grands classiques de l’art culinaire marocain et authentique, le tout fait maison avec des ingrédients de qualité choisis méticuleusement''',
    "coords": {"latitude": 33.5826015, "longitude": -7.6407117},
    "imagePath": "assets/images/fine-dining2.jpg",
    "logo": "assets/images/restaurant_Avatar1.png",
    "Tags": [
      tagsList[0],
    ],
    "minPrice": 19,
    "maxPrice": 549,
    "city": citiesList.Casablanca,
    "categories": [categoriesList[3],categoriesList[1]],
    "rating": 4.5,
    "social": [
      {
        "FaceBook": "https://www.facebook.com/lecuistotraditionnel",
        "icon": FontAwesomeIcons.facebook,
        "color": 0xFF4267B2
      },
      {
        "Instagram": "https://www.instagram.com/le_cuistot_traditionnel",
        "icon": FontAwesomeIcons.instagram,
        "color": 0xFF833ab4
      },
      {
        "Site": "https://lecuistot-traditionnel.com/",
        "icon": FontAwesomeIcons.globe,
        "color": kSecondaryColor.value
      }
    ]
  },
  {
    "name": "Capiano",
    "title": "Le patrimoine est dans l'assiette",
    "description":
        '''Dans l’atmosphère particulière du Cuistot Traditionnel à la fois chaleureuse et décontractée, le choix s’offre à vous.
Nous associons en effet les grands classiques de l’art culinaire marocain et authentique, le tout fait maison avec des ingrédients de qualité choisis méticuleusement''',
    "coords": {"latitude": 33.5629841, "longitude": -7.5990361},
    "imagePath": "assets/images/fine-dining3.jpg",
    "logo": "assets/images/restaurant_Avatar2.png",
    "Tags": [
      tagsList[0],
    ],
    "minPrice": 19,
    "maxPrice": 549,
    "city": citiesList.Casablanca,
    "categories": [categoriesList[3],categoriesList[1]],
    "rating": 4.5,
    "social": [
      {
        "FaceBook": "https://www.facebook.com/lecuistotraditionnel",
        "icon": FontAwesomeIcons.facebook,
        "color": 0xFF4267B2
      },
      {
        "Instagram": "https://www.instagram.com/le_cuistot_traditionnel",
        "icon": FontAwesomeIcons.instagram,
        "color": 0xFF833ab4
      },
      {
        "Site": "https://lecuistot-traditionnel.com/",
        "icon": FontAwesomeIcons.globe,
        "color": kSecondaryColor.value
      }
    ]
  },
];

List categoriesList = ["Asian", "American", "French", "Moroccan", "Italian"];

List<Map<String, dynamic>> tagsList = [
  {"tag": "Bike Parking", "isSelected": false},
  {"tag": "Coupons", "isSelected": false},
  {"tag": "Parking Street", "isSelected": false},
  {"tag": "Wireless Internet", "isSelected": false},
  {"tag": "Accepts Credit Cards", "isSelected": false}
];

Future<List<Map<String, dynamic>>> getData() async {
  restaurantsList.forEach((e) async {
    List<Placemark> placeMark = await GetLocation().decodingLocationFromLatLng(
        e["coords"]["latitude"], e["coords"]["longitude"]);
    e.putIfAbsent("placemark", () => placeMark);
  });
  return restaurantsList;
}
