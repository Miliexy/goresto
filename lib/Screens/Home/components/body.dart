import 'package:flutter/material.dart';
import 'package:goresto/Screens/components/default_button.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double cheight;
    double cwidth;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: cheight = SizeConfig.blockSizeVertical * 35,
            width: SizeConfig.blockSizeHorizontal * 100,
            color: Colors.black,
            child: Column(
              children: [
                Stack(
                  children: [
                    FittedBox(child: Image.asset("assets/images/image.webp")),
                    Column(
                      children: [
                        Container(
                         color: Colors.green,
                          height: cheight * 0.5,
                          child: Text(cheight.toString()),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.grey,
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                enabledBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: cheight = SizeConfig.blockSizeVertical * 20,
            width: cwidth = SizeConfig.blockSizeHorizontal * 100,
            color: Colors.orange,
            child: Column(
              children: [SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.green
                  ),
                ),
                height: cheight * 0.5,
                width: cwidth ,

              )],
            ),
          ),
        ]),
      ),
    );
  }
}
