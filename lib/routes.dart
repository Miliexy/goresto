import 'package:flutter/material.dart';
import 'package:goresto/Screens/Home/home_screen.dart';
import 'package:goresto/Screens/Welcome/welcome_screen.dart';
import 'package:goresto/Services/location.dart';

final Map<String, WidgetBuilder>  routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CurrentLocation.routeName : (context) => CurrentLocation(),

};

Route createRoute(){
  return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
  transitionsBuilder: (context, animation, secondaryAnimation, child){
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(position: animation.drive(tween),
    child: child,);
  });
}