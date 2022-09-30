import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/Restaurant/components/CalendarWidget.dart';
import 'package:goresto/Screens/Restaurant/components/StaticMapWidget.dart';
import 'package:goresto/Screens/components/commentSection.dart';
import 'package:goresto/Screens/components/roundedIcnBtn.dart';
import 'package:goresto/Screens/delivery/delivery_menu.dart';
import 'package:goresto/Screens/delivery/delivery_screen.dart';
import 'package:goresto/Screens/introduction_animation/components/defaultText.dart';
import 'package:goresto/Screens/reservastion/components/checkout_screen.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'menu_list.dart' as menu;

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
  final bool _isDisabled = false;

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
    final _searchAnimation = Tween(begin: Offset(0, 2), end: Offset(0, 0.21))
        .animate(CurvedAnimation(
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
                                backgroundImage: AssetImage(data["logo"]),
                                radius: SizeConfig.blockSizeVertical * 5,
                              )),
                          SliverAppBar(
                            collapsedHeight: SizeConfig.blockSizeVertical * 8,
                            pinned: true,
                            snap: true,
                            backgroundColor: Colors.white.withOpacity(_opacity),
                            floating: true,
                            automaticallyImplyLeading: false,
                            leading: InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.8)
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                              onTap: () => Navigator.of(context).pop(),
                            ),
                            actions: [
                              RoundedIcnBtn(
                                iconData: Icons.favorite,
                                press: () {},
                                opacity: double.parse('0.8'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: SizeConfig.blockSizeHorizontal * 2),
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
                                fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
                                color: kSecondaryColor.withOpacity(_opacity),
                                fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight,
                              ),
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
                      DescriptionWidget(
                        testText: data["description"],
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      TimeTableWidget(),
                      //MapLocationWidget(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      MapLocationWidget(),
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
                menu.MenuList()
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
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 15, vertical: SizeConfig.blockSizeVertical * 1),
              child: ElevatedButton(
                child: Text("Reserver",
                    style:Theme.of(context).primaryTextTheme.headline6),
                onPressed: _isDisabled
                    ? null
                    : () {
                  showModal(configuration: FadeScaleTransitionConfiguration(),
                    context: context, builder: (context) {
                    return Material(
                      type: MaterialType.transparency,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 100,
                        height: SizeConfig.blockSizeVertical * 88,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: (){
                                _scrollToTop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ConfirmationScreen(),
                                ));
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 40,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/reserved_table.jpg"),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.55), BlendMode.srcATop),
                                  )
                                ),
                                child: Center(
                                  child: Text("Reserver", style: Theme.of(context).primaryTextTheme.headline2,),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                _scrollToTop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DeliveryMenu(),
                                ));
                              },
                              child: Container(
                                height: SizeConfig.blockSizeVertical * 40,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/delivery2.jpg"),
                                      fit: BoxFit.fill,
                                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.55), BlendMode.srcATop),
                                    )
                                ),
                                child: Center(
                                  child: Text("Delivery", style: Theme.of(context).primaryTextTheme.headline2,),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },);
                      },
                style: ButtonStyle(
                  backgroundColor: _isDisabled
                      ? MaterialStateProperty.all(Colors.grey)
                      : MaterialStateProperty.all(kSecondaryColor),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeVertical * 4))),
                  fixedSize: MaterialStateProperty.all(Size(
                      SizeConfig.blockSizeHorizontal * 50,
                      SizeConfig.blockSizeVertical * 7)),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
