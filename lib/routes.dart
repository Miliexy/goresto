import 'package:flutter/material.dart';
import 'package:goresto/Screens/Home/home_screen.dart';
import 'package:goresto/Screens/Locations/location_screen.dart';
import 'package:goresto/Screens/Restaurant/restaurant_screen.dart';
import 'package:goresto/Screens/Welcome/welcome_screen.dart';
import 'package:goresto/Services/location.dart';

final Map<String, WidgetBuilder>  routes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  CurrentLocation.routeName : (context) => const CurrentLocation(),
  RestaurantScreen.routeName : (context) => const RestaurantScreen(),
  GeoLocationScreen.routeName : (context) => const GeoLocationScreen(),
};

Route createRoute(String route){
  return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => routes.entries.firstWhere((element) => element.key==route).value(context),
  transitionsBuilder: (context, animation, secondaryAnimation, child){
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween),
    child: child,);
  });
}

class RoutePaths {
  static final welcome = WelcomeScreen.routeName;
  static var home = HomeScreen.routeName;
  static var location = GeoLocationScreen.routeName;
  static var restaurant = RestaurantScreen.routeName;



}
