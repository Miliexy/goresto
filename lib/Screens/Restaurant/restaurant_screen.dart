import 'package:flutter/material.dart';
import 'package:goresto/Screens/Restaurant/components/body.dart';
import 'package:goresto/size_config.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);
  static String routeName = "/details";


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}


