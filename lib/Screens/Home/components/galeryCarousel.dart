import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/Home/components/itemCard.dart';

class GalleryCarousel extends StatelessWidget {
  const GalleryCarousel({
    Key? key,
    required this.testList,
    required this.radius,
    required this.height,
    required this.width,
  }) : super(key: key);

  final List<Map<String, String>> testList;
  final Radius radius;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayCurve: Curves.bounceInOut,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        enableInfiniteScroll: false,
      ),
      items: testList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ItemCard(
                radius: radius,
                height: height,
                width: width,
                index: 1,
                info: i);
          },
        );
      }).toList(),
    );
  }
}
