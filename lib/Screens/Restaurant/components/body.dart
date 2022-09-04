import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goresto/Screens/components/commentSection.dart';
import 'package:goresto/Screens/components/roundedIcnBtn.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  var _current = 0;
  final CarouselController _controller = CarouselController();
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController;

  double pinnedHeaderHeight = 20;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
    },
  ];
  List<Map<String, String>> listComponents = [
    {"name": "Whatsapp", "icon": "Icons.whatsapp"},
    {"name": "Directions", "icon": "Icons.whatsapp"},
    {"name": "Report", "icon": "Icons.whatsapp"},
    {"name": "Reports", "icon": "Icons.whatsapp"},
  ];
  String testText =
      "The Liman Restaurant means port in the Turkish language, however the restaurant opens its doors to all aspects of the Mediterranean kitchen. The kitchen will be mostly focused on Mediterranean food; the owners of the restaurant are young professional chefs who can bring new, exciting tastes to Angel, Islington which will show through in the quality of food they prepare";
  @override
  Widget build(BuildContext context) {
    return ExtendedNestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: ((context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            snap: false,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    CarouselSlider(
                        carouselController: _controller,
                        items: testCities
                            .map((e) => Image.network(
                                  "https://youstickout.ma/rest/wp-content/uploads/2018/12/265833405_3164046847202905_8407767184837281245_n.jpg",
                                  fit: BoxFit.cover,
                                ))
                            .toList(),
                        options: CarouselOptions(
                            viewportFraction: 1.0,
                            height: SizeConfig.blockSizeVertical * 80,
                            autoPlay: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            })),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: SizeConfig.blockSizeVertical * 13,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Name",
                                                style: GoogleFonts
                                                    .montserratAlternates(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 18),
                                              ),
                                              const SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "Description",
                                                style: GoogleFonts
                                                    .montserratAlternates(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        color: const Color(
                                                            0xe8727171)),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Align(
                      alignment: Alignment(-0.888, 0.5),
                      child: CircleAvatar(
                        radius: 35,
                        foregroundImage:
                            AssetImage("assets/images/avatar_test.png"),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0.3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: testCities.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => _controller.animateToPage(entry.key),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: _current == entry.key ? 50.0 : 12.0,
                              height: 12.0,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          _current == entry.key ? 0.9 : 0.4)),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              centerTitle: true,
              collapseMode: CollapseMode.pin,
              //background: Container(color: Colors.white,),
            ),
            expandedHeight: SizeConfig.blockSizeVertical * 35,
            actions: <Widget>[
              RoundedIcnBtn(
                iconData: Icons.favorite,
                press: () {},
                opacity: double.parse('0.8'),
              ),
              RoundedIcnBtn(
                iconData: Icons.share,
                press: () {},
                opacity: double.parse('0.8'),
              ),
            ],
          ),
        ];
      }),
      pinnedHeaderSliverHeightBuilder: () {
        return pinnedHeaderHeight;
      },
      body: Column(
        children: <Widget>[
          TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            isScrollable: false,
            unselectedLabelColor: Colors.grey,
            tabs: const <Tab>[
              Tab(text: 'About'),
              Tab(text: 'Review'),
              Tab(
                text: 'Menu',
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 10,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Wrap(
                              children: [
                                "Facebook",
                                "Telephone",
                                "Website",
                                "Bookmark",
                                "Share",
                                "Laisser un avis",
                                "Claim listing",
                                "Report",
                              ]
                                  .map((f) => GestureDetector(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0, vertical: 10.0),
                                          margin: const EdgeInsets.only(
                                              left: 5.0,
                                              right: 5.0,
                                              top: 10.0,
                                              bottom: 10.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFF282f61),
                                                width: 2.0),
                                            borderRadius: const BorderRadius
                                                    .all(
                                                Radius.circular(
                                                    10.0) //                 <--- border radius here
                                                ),
                                          ),
                                          child: Text(
                                            f,
                                            style: GoogleFonts
                                                .montserratAlternates(
                                              color: const Color(0xFF000000),
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                        onTap: () {},
                                      ))
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                      _buildTabContext(),
                      ExpansionTile(
                        title: Text("Hello"),
                        leading: Icon(Icons.alarm),
                        children: [
                          ListTile(
                            leading: Text("Lundi"),
                            trailing: Text("Open 24h"),
                          ),
                          ListTile(
                            leading: Text("Lundi"),
                            trailing: Text("Open 24h"),
                          ),
                          ListTile(
                            leading: Text("Lundi"),
                            trailing: Text("Open 24h"),
                          ),
                          ListTile(
                            leading: Text("Lundi"),
                            trailing: Text("Open 24h"),
                          )
                        ],
                      ),
                      _buildMap(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      _buildTags(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      _buildCategories(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      _buildSocialMedia(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                    ],
                  ),
                ),
                CommentSection(testText: testText),
                Container(
                    child: AlignedGridView.custom(
                  shrinkWrap: true,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 5,
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 3),
                  gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => Container(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.of(context).push(createRoute("/item"));
                      },
                      onLongPress: () {
                      },
                      child: Hero(
                        transitionOnUserGestures: true,
                        tag: 'containerHero-${index}',
                        child: Column(
                          children: [
                            Image.asset("assets/images/fine-dining1.jpg"),
                            Text("Item Name"),
                            Row(
                              children: [
                                Text(
                                  "12.55",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                Text("10.55"),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Add to cart"))
                          ],
                        ),
                      ),
                    ),
                  ),
                  itemCount: 5,
                )),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildCategories() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 12),
        elevation: 13,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.view_module),
              title: Text("Categories"),
            ),
            Container(
              child: AlignedGridView.count(
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_border,
                            color: Colors.grey,
                          )),
                      Text("Category")
                    ],
                  );
                },
                itemCount: 1,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(25),
              ),
            ),
          ],
        ),
      );
  _buildTags() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 12),
        elevation: 13,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.view_module),
              title: Text("Tags"),
              visualDensity: VisualDensity(vertical: 0.3),
            ),
            Container(
              child: AlignedGridView.count(
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.directions_bike,
                            color: Colors.grey,
                          )),
                      Text("Bike Parking")
                    ],
                  );
                },
                itemCount: 8,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(25),
              ),
            ),
          ],
        ),
      );

  _buildSocialMedia() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 12),
        elevation: 13,
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.view_module),
              title: Text("Follow us"),
              visualDensity: VisualDensity(vertical: 0.3),
            ),
            Container(
              child: AlignedGridView.count(
                crossAxisCount: 2,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("hello world");
                    },
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.facebook,
                              color: Colors.blue,
                            ),
                            iconSize: 50),
                        Text("Social")
                      ],
                    ),
                  );
                },
                itemCount: 4,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(25),
              ),
            ),
          ],
        ),
      );

  _buildTabContext() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 12),
        elevation: 13,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.view_headline),
              title: Text('Description'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                testText,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      );
  _buildMap() => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(horizontal: 12),
        elevation: 13,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            const ListTile(
              leading: Icon(Icons.map),
              title: Text('Description'),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: SizeConfig.blockSizeHorizontal * 95,
              height: SizeConfig.blockSizeVertical * 50,
              child: GoogleMap(
                scrollGesturesEnabled: true,
                mapType: MapType.normal,
                gestureRecognizers: Set()
                  ..add(Factory<EagerGestureRecognizer>(
                      () => EagerGestureRecognizer())),
                initialCameraPosition: CameraPosition(
                    target: LatLng(52.2165157, 6.9437819), zoom: 14.5),
                markers: {
                  Marker(
                      markerId: MarkerId("source"),
                      position: LatLng(52.2165157, 6.9437819),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueYellow)),
                },
              ),
            ),
          ],
        ),
      );
}
