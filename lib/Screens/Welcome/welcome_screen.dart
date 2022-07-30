import 'package:flutter/material.dart';
import 'package:goresto/Screens/Welcome/components/body.dart';
import 'package:goresto/size_config.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String routeName = "/welcome";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
