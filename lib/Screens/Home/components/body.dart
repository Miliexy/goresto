import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/Home/components/homeTop.dart';
import 'package:goresto/size_config.dart';

import 'itemCard.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.blockSizeVertical;
    double width = SizeConfig.blockSizeHorizontal;
    var radius = Radius.circular(20);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          HomeTop(image: AssetImage("assets/images/image.webp")),
          SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 1.5)),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.my_location)),
            ),
          ),
          SizedBox(
            height: height * 3.8,
          ),
          SectionTitle(
            width: width,
            press: () {},
            text: 'Recommended For you',
          ),
          SizedBox(height: 10),
          ItemCard(radius: radius, height: height, width: width, index: 1,),
          CarouselSlider(
            options: CarouselOptions(autoPlayCurve: Curves.bounceInOut,
            enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height),
            items: [1,2,3,4,5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return ItemCard(radius: radius, height: height, width: width, index: i);
                },
              );
            }).toList(),
          )
          //HomeTop(image: AssetImage("assets/images/image.webp"))
        ]),
      ),
    );
  }
}


class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key? key,
    required this.width,
    required this.text,
    required this.press,
  }) : super(key: key);

  final double width;
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 4.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                fontSize: width * 5,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          GestureDetector(
            onTap: press,
            child: Text("See more",
                style: TextStyle(fontSize: width * 4, color: Colors.black)),
          )
        ],
      ),
    );
  }
}
