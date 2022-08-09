import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/components/roundedIcnBtn.dart';
import 'package:goresto/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin{
  var _current = 0;
  final CarouselController _controller = CarouselController();
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController;

  double pinnedHeaderHeight= 20;

  @override
  void initState() {
    super.initState();
    _tabController =  TabController(length: 2, vsync: this);
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
    {
      "name" : "Whatsapp",
      "icon" : "Icons.whatsapp"
    },
    {
      "name" : "Directions",
      "icon" : "Icons.whatsapp"
    },
    {
      "name" : "Report",
      "icon" : "Icons.whatsapp"
    },
    {
      "name" : "Reports",
      "icon" : "Icons.whatsapp"
    },
  ];
  String testText = "The Liman Restaurant means port in the Turkish language, however the restaurant opens its doors to all aspects of the Mediterranean kitchen. The kitchen will be mostly focused on Mediterranean food; the owners of the restaurant are young professional chefs who can bring new, exciting tastes to Angel, Islington which will show through in the quality of food they prepare";
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
              title: const Text("gello"),
              flexibleSpace: FlexibleSpaceBar(
                title: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://youstickout.ma/rest/wp-content/uploads/2018/12/58380829_2358455387762059_655540836913643520_n.jpg"),
                    radius: 25),
                titlePadding: const EdgeInsets.only(bottom: 5, left: 60),
                background: Stack(children: [
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
                  Positioned(
                    top: SizeConfig.blockSizeVertical * 45,
                    left: SizeConfig.blockSizeHorizontal * 40,
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
                  ),
                ]),
                collapseMode: CollapseMode.pin,
              ),
              expandedHeight: SizeConfig.blockSizeHorizontal * 90,
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RoundedIcnBtn(
                  iconData: Icons.search,
                  press: () {},
                  opacity: double.parse('0.8'),
                ),
              ),
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
        pinnedHeaderSliverHeightBuilder: (){
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
              Tab(text: 'Tab0'),
              Tab(text: 'Tab1'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTabContext(),
                      Text(testText),
                      Text(testText),
                      Text(testText),
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    //store Page state
                    key: const PageStorageKey<String>('Tab1'),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext c, int i) {
                      return Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        child:
                        Text('${const Key('Tab1')}: ListView$i'),
                      );
                    },
                    itemCount: 50,
                  ),
                ),
              ],
            ),
          )
        ],
      ),);
  }

  _buildTabContext() => Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        const ListTile(
          leading: Icon(Icons.view_headline),
          title: Text('Description'),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(testText,style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ],
    ),
  );
}
