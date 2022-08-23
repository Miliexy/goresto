


import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CityGallery extends StatefulWidget {
  const CityGallery({
    Key? key,
    required this.width,
    required this.height, required this.testList,
    required this.widget,
  }) : super(key: key);
  final double width;
  final double height;
  final List<Map<String, String>> testList;
  final Widget widget;

  @override
  State<CityGallery> createState() => _CityGalleryState();
}

class _CityGalleryState extends State<CityGallery> {

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            autoPlayCurve: Curves.bounceInOut,
            scrollDirection: Axis.horizontal,
            scrollPhysics: BouncingScrollPhysics(),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            enableInfiniteScroll: false,
            viewportFraction: 0.85),
        items: widget.testList.map((e) {
          return buildCity(e);
        }).toList());
  }

  Stack buildCity(Map<String, String> e) {
    return Stack(children: [
          SizedBox(
            width: widget.width * 80,
            height: widget.height * 30,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(e["image"].toString()),
                      fit: BoxFit.cover),
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(23)),
            ),
          ),
          Positioned.fromRect(
            rect: Rect.fromCenter(
                center: Offset(widget.width * 40, widget.height * 15),
                width: widget.width * 60,
                height: widget.height* 25),
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Icon(Icons.location_on_outlined, size: 45, color: Colors.white,),
                  Text(e["name"].toString(), style: const TextStyle(color: Colors.white, fontSize: 20),),
                  Text(e["count"].toString(), style: const TextStyle(color: Colors.white, fontSize: 15))
                ],
              ),
            ),
          ),
        ]);
  }
}