import 'package:flutter/material.dart';
import 'package:goresto/Screens/Home/components/cityGallery.dart';
import 'package:goresto/Screens/Home/components/galeryCarousel.dart';
import 'package:goresto/Screens/Home/components/homeTop.dart';
import 'package:goresto/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Map<String, String>> testList = [
    {
      "name": "Something",
      "description": "a something restaurant",
      "image": "assets/images/image.webp"
    },
    {
      "name": "Another",
      "description": "a Another restaurant",
      "image": "assets/images/placeholder.png"
    }
  ];
  List<Map<String, String>> testCities = [
    {
      "name": "Casablanca",
      "count": "3 restaurants",
      "image": "assets/images/image.webp"
    },
    {
      "name": "Tangier",
      "count": "2 restaurants",
      "image": "assets/images/image.webp"
    },
    {
      "name": "Marrakech",
      "count": "2 restaurants",
      "image": "assets/images/image.webp"
    }
  ];

  @override
  Widget build(BuildContext context) {
    double height = SizeConfig.blockSizeVertical;
    double width = SizeConfig.blockSizeHorizontal;
    var radius = const Radius.circular(20);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          const HomeTop(image: AssetImage("assets/images/image.webp")),
          const SizedBox(height: 15),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "search",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(width: 1.5)),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.my_location),
                    onPressed: () {},
                  )),
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
          const SizedBox(height: 15),
          //ItemCard(radius: radius, height: height, width: width, index: 1,),
          GalleryCarousel(
              testList: testList, radius: radius, height: height, width: width),
          const SizedBox(height: 15),
          SectionTitle(width: width, text: "Villes", press: () {}),
          const SizedBox(height: 15),
          CityGallery(width: width, height: height, testList: testCities,),
          const SizedBox(height: 15),
          SectionTitle(width: width, text: "Categorie", press: () {}),
          const SizedBox(height: 15),
          CityGallery(width: width, height: height, testList: testCities,)
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
