import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/Restaurant/components/CalendarWidget.dart';
import 'package:goresto/Screens/components/commentSection.dart';
import 'package:goresto/Screens/components/roundedIcnBtn.dart';
import 'package:goresto/Screens/introduction_animation/components/defaultText.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'body.dart';

class Body2 extends StatefulWidget {
  const Body2({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;
  @override
  State<Body2> createState() => _Body2State();
}

class _Body2State extends State<Body2> with TickerProviderStateMixin {
  CarouselController carouselController = CarouselController();
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController;
  AnimationController? _animationController;
  double _scrollPosition = 0;
  double _opacity = 0;
  late final Map<String, dynamic> data;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_scrollListener);
    data = widget.data;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(() {
      _scrollListener();
    });
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController
        .animateTo(SizeConfig.blockSizeVertical * 30,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn)
        .then((value) => _animationController?.animateTo(0.5,
            duration: Duration(seconds: 1), curve: Curves.slowMiddle));
  }

  @override
  Widget build(BuildContext context) {
    final _searchAnimation =
        Tween(begin: Offset(0, 2), end: Offset(0, 0.21)).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.3,
        0.5,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    _opacity = _scrollPosition < SizeConfig.blockSizeVertical * 25
        ? _scrollPosition / (SizeConfig.blockSizeVertical * 25)
        : 1;
    return Stack(
      children: [
        NestedScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverStack(
                  children: [
                    MultiSliver(
                      children: [
                        SliverStack(children: [
                          SliverToBoxAdapter(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: SizeConfig.blockSizeVertical * 30,
                              ),
                              items: [
                                Image.asset(
                                  data["imagePath"],
                                  fit: BoxFit.cover,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                )
                              ],
                            ),
                          ),
                          SliverPositioned(
                              top: SizeConfig.blockSizeVertical * 25,
                              left: 20,
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    data["logo"]),
                                radius: SizeConfig.blockSizeVertical * 5,
                              )),
                          SliverAppBar(
                            collapsedHeight: SizeConfig.blockSizeVertical * 8,
                            pinned: true,
                            snap: true,
                            backgroundColor:
                                kSecondaryColor.withOpacity(_opacity),
                            floating: true,
                            automaticallyImplyLeading: false,
                            leading: Padding(
                              child: RoundedIcnBtn(
                                opacity: 0.8,
                                press:() => Navigator.pop(context),
                                iconData: Icons.arrow_back_ios_new,
                              ),
                              padding:  EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 1),
                            ),
                            actions: [
                              RoundedIcnBtn(
                                iconData: Icons.favorite,
                                press: () {},
                                opacity: double.parse('0.8'),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2),
                                child: RoundedIcnBtn(
                                  iconData: Icons.share,
                                  press: () {},
                                  opacity: double.parse('0.8'),
                                ),
                              ),
                            ],
                            title: Text(
                              data["name"],
                              style: TextStyle(
                                fontSize: 19,
                                  color: kPrimaryColor.withOpacity(_opacity)),
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                            ),
                            titleSpacing: 12,
                          ),
                        ]),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 6,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeVertical * 3),
                              child: Row(
                                children: [
                                  Text(
                                    data["name"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: fontTitleSize - 5),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2,
                                  left: SizeConfig.blockSizeVertical * 3),
                              child: Row(
                                children: [
                                  Text(
                                    data["title"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: const Color(0xe8727171)),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                        SliverPinnedHeader(
                          child: Container(
                            height: SizeConfig.blockSizeVertical * 8,
                            color: Colors.white,
                            child: TabBar(
                              controller: _tabController,
                              labelColor: kSecondaryColor,
                              indicatorColor: kSecondaryColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorWeight: 2.0,
                              isScrollable: false,
                              unselectedLabelColor: Colors.grey,
                              tabs: [
                                Text(
                                  "About",
                                  style: TextStyle(fontSize: fontTextSize),
                                ),
                                Text("Reviews"),
                                Text("Menu"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      InfoBar(),
                      DescriptionWidget(testText: data["description"],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      TimeTableWidget(),
                      //MapLocationWidget(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      ProductTagsWidget(data: data["Tags"]),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      ProductCategoriesWidget(data: data["categories"]),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      ProductSocialWidget(data: data["social"]),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 12,
                      ),
                    ],
                  ),
                ),
                CommentSection(testText: ysWelcomeText),
                Container(
                  color: Colors.pink,
                )
              ],
            )),
        /*SlideTransition(
          position: _searchAnimation,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.vertical,
            child: Container(
                height: SizeConfig.blockSizeVertical * 75,
                color: Colors.green,
              ),
          ),
        ),*/
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text("Reserver",
                    style:
                        TextStyle(fontSize: fontTitleSize, letterSpacing: 1.2)),
                onPressed: () {
                  //_scrollToTop();
                  Navigator.pushNamed(context, AppRouter.bookingRoute);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kSecondaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeVertical * 5))),
                  minimumSize: MaterialStateProperty.all(Size(
                      SizeConfig.blockSizeHorizontal * 80,
                      SizeConfig.blockSizeVertical * 8)),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
