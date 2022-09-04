import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goresto/Screens/Home/components/body.dart';
import 'package:goresto/Screens/Home/components/cityGallery.dart';
import 'package:goresto/Screens/Home/components/galeryCarousel.dart';
import 'package:goresto/Screens/Home/components/homeTop.dart';
import 'package:goresto/Screens/Home/components/listcard.dart';
import 'package:goresto/Screens/Home/components/tile.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';
import 'dart:math' as math;

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  State<HomeTest> createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  List<Map<String, String>> testList = [
    {
      "name": "Something",
      "description": "a something restaurant",
      "image": "assets/images/fine-dining1.jpg"
    },
    {
      "name": "Another",
      "description": "a Another restaurant",
      "image": "assets/images/fine-dining1.jpg"
    }
  ];
  List<Map<String, String>> testCities = [
    {
      "name": "Casablanca",
      "count": "3 restaurants",
      "image": "assets/images/fine-dining2.jpg"
    },
    {
      "name": "Tangier",
      "count": "2 restaurants",
      "image": "assets/images/fine-dining3.jpg"
    },
    {
      "name": "Marrakech",
      "count": "2 restaurants",
      "image": "assets/images/fine-dining4.jpg"
    }
  ];
  List<Map<String, String>> listCategories = [
    {
      "category": "Moroccan",
      "icon": "",
      "image": "assets/images/fine-dining4.jpg",
      "gridCount": "2"
    },
    {
      "category": "American",
      "icon": "",
      "image": "assets/images/fine-dining1.jpg",
      "gridCount": "1"
    },
    {
      "category": "italian",
      "icon": "",
      "image": "assets/images/fine-dining2.jpg",
      "gridCount": "1"
    },
    {
      "category": "French",
      "icon": "",
      "image": "assets/images/fine-dining3.jpg",
      "gridCount": "2"
    },
  ];
  double height = SizeConfig.blockSizeVertical;
  double width = SizeConfig.blockSizeHorizontal;
  var radius = const Radius.circular(20);

  @override
  Widget build(BuildContext context) {
    int _index = 0;
    return SafeArea(
        child: ExtendedNestedScrollView(
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 15),
          SizedBox(
            height: height * 3.8,
          ),
          SectionTitle(
            width: width,
            press: () {},
            text: 'Recommended For you',
          ),
          const SizedBox(height: 15),
          carSlider(testList: testList, widget: listCard(), listType: 0),
          const SizedBox(height: 15),
          carSlider(testList: testCities, widget: listCard(), listType: 1),
          const SizedBox(height: 15),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 21.0),
                child: Text(
                  "Our categories: ",
                  style: GoogleFonts.montserratAlternates(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 21.0, right: 21, top: 15),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: listCategories
                  .map((e) => StaggeredGridTile.count(
                        mainAxisCellCount: 1,
                        crossAxisCellCount: int.parse(e["gridCount"]!),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                  image: AssetImage(e["image"].toString()),
                                  fit: BoxFit.fill)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.event_seat_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                e["category"].toString(),
                                style: GoogleFonts.montserratAlternates(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            floating: true,
            expandedHeight: SizeConfig.blockSizeVertical * 40,
            automaticallyImplyLeading: false,
            flexibleSpace: Stack(
              fit: StackFit.expand,
              children: const [
                HomeTop(image: AssetImage("assets/images/fine-dining4.jpg")),
              ],
            ),
          ),
          SliverSafeArea(
            sliver:
                SliverPersistentHeader(delegate: searchHeader(), pinned: true),
            minimum: const EdgeInsets.only(
              top: 30,
              bottom: 30,
            ),
            top: true,
          )
        ];
      },
    ));
  }
}

class carSlider extends StatelessWidget {
  const carSlider({
    Key? key,
    required this.testList,
    required this.widget,
    required this.listType,
  }) : super(key: key);

  final Widget widget;

  final listType;

  final List<Map<String, String>> testList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: testList
            .map((e) => listCard.getElement(
                  element: e,
                  listType: listType,
                ))
            .toList(),
        options: CarouselOptions(
          height: SizeConfig.blockSizeVertical * (listType == 1 ? 35 : 45),
          viewportFraction: 0.9,
          scrollPhysics: BouncingScrollPhysics(),
          enableInfiniteScroll: false,
        ));
  }
}

class searchHeader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      width: SizeConfig.blockSizeHorizontal * 100,
      height: SizeConfig.blockSizeVertical * 40,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 8.0),
        child: TextField(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();

            Navigator.of(context).push(createRoute("/search"));
          },
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
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 65;

  @override
  // TODO: implement minExtent
  double get minExtent => 63;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
