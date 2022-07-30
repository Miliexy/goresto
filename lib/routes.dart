import 'package:flutter/material.dart';
import 'package:goresto/Screens/Home/home_screen.dart';
import 'package:goresto/Screens/Welcome/welcome_screen.dart';

final Map<String, WidgetBuilder>  routes = {
  WelcomeScreen.routeName: (context) => WelcomeScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),

};
