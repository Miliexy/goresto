import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/Restaurant/components/Body2.dart';
import 'package:goresto/size_config.dart';

class RestaurantScreen extends StatelessWidget {
  RestaurantScreen({Key? key, required this.data}) : super(key: key);
  static String routeName = "/details";
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
          ),
        ),
      ),
      body: Body2(data: data),

    );
  }
}


