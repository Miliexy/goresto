import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/Restaurant/components/body.dart';
import 'package:goresto/Screens/components/commentSection.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../constansts.dart';
import '../components/roundedIcnBtn.dart';

class MenuProduct extends StatefulWidget {
  const MenuProduct({Key? key, required List<dynamic> data}) : super(key: key);
  static String routeName = "/item";

  @override
  State<MenuProduct> createState() => _MenuProductState();
}

class _MenuProductState extends State<MenuProduct>
    with TickerProviderStateMixin {
  CarouselController carouselController = CarouselController();
  final ScrollController _scrollController = ScrollController();
  late final TabController _tabController;
  AnimationController? _animationController;
  double _scrollPosition = 0;
  double _opacity = 0;
  var data;
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
    _tabController = TabController(length: 2, vsync: this);
    _scrollController.addListener(_scrollListener);
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
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
            physics: NeverScrollableScrollPhysics(), slivers: [
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
                            "assets/images/fine-dining1.jpg",
                            fit: BoxFit.cover,
                            width: SizeConfig.blockSizeHorizontal * 100,
                          )
                        ],
                      ),
                    ),
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
                              color: Colors.white.withOpacity(0.8)),
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
                        "Couscous",
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.fontFamily,
                          color: kSecondaryColor.withOpacity(_opacity),
                          fontWeight: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.fontWeight,
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
                              "Couscous",
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
                              "Prix",
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                Column(
                  children: [
                    DescriptionWidget(testText: "testText"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 5,
                          width: SizeConfig.blockSizeHorizontal * 15,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kSecondaryColor,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            child: Icon(Icons.remove, color: kSecondaryColor),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Text(
                          '1',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 5,
                          width: SizeConfig.blockSizeHorizontal * 15,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kSecondaryColor,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {},
                            child: Icon(Icons.add, color: kSecondaryColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                CommentSection(testText: "ysWelcomeText"),
              ],
            ),
          )
        ]),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.transparent,
            width: SizeConfig.blockSizeHorizontal * 100,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 15,
                  vertical: SizeConfig.blockSizeVertical * 1),
              child: ElevatedButton(
                child: Text("Suivant",
                    style: Theme.of(context).primaryTextTheme.headline6),
                onPressed: () {
                },
                style: ButtonStyle(
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
    )
    );
  }
}
