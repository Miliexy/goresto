import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goresto/Screens/Favourite/favourite_screen.dart';
import 'package:goresto/Screens/Orders/orders_screen.dart';
import 'package:goresto/Screens/Profile/profile_screen.dart';
import 'package:goresto/Screens/Search/search_screen.dart';
import 'package:goresto/Screens/auth/auth_main_screen.dart';
import 'package:goresto/Screens/design_course/components/AdsSection.dart';
import 'package:goresto/Screens/design_course/components/SearchWidget.dart';
import 'package:goresto/Screens/design_course/newHomeTest.dart';
import 'package:goresto/Screens/design_course/restaurant_info.dart';
import 'package:flutter/material.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/hotel_app_theme.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';
import '../../routes.dart';
import 'components/AppBar.dart';
import 'components/category.dart';
import 'components/popularList.dart';
import 'dart:ui';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);
  static String routeName = "/newHome";

  @override
  NewHomeScreenState createState() => NewHomeScreenState();
}

class NewHomeScreenState extends State<NewHomeScreen> {
  final ScrollController _scrollController = ScrollController();

  double _scrollPosition = 0, _opacity = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_scrollListener);
    super.initState();
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

  var currentIndex = 0;
  late final List<Widget> _children = [
    HomePage(scrollController: _scrollController),
    OrdersScreen(),
    FavouriteScreen(),
    AuthMainScreen()
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _opacity = _scrollPosition < SizeConfig.blockSizeVertical * 18
        ? _scrollPosition / (SizeConfig.blockSizeVertical * 18)
        : 1;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: Color(0xff000000),
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarColor: Colors.white70.withOpacity(_opacity),
              statusBarIconBrightness:
                  _opacity == 1 ? Brightness.dark : Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent),
        preferredSize: Size.zero,
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: SizedBox(
        height: SizeConfig.blockSizeVertical * 10,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          elevation: 5,
          selectedIconTheme: IconThemeData(color: kSecondaryColor),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.tag), label: "Historique"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favoris"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidUser), label: "Profil"),
          ],
          onTap: onTabTapped,
          currentIndex: currentIndex,
        ),
      ),
      body: _children[currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

void moveTo(context) {
  Navigator.push<dynamic>(
    context,
    MaterialPageRoute<dynamic>(
      builder: (BuildContext context) => CourseInfoScreen(),
    ),
  );
}

class HomePage extends StatefulWidget {
  final ScrollController scrollController;

  const HomePage({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = widget.scrollController;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('${MediaQueryData.fromWindow(window).padding.top} ad');
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverStack(
          insetOnOverlap: false,
          children: [
            SliverToBoxAdapter(
              child: Container(
                clipBehavior: Clip.hardEdge,
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 40,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.srcATop),
                  child: Image.asset(
                    "assets/images/fine-dining1.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            MultiSliver(children: [
              SliverPinnedHeader(
                child: SizedBox(
                  height: MediaQueryData.fromWindow(window).padding.top,
                ),
              ),
              SliverCrossAxisConstrained(
                maxCrossAxisExtent: SizeConfig.blockSizeHorizontal * 30,
                alignment: -0.5,
                child: SliverToBoxAdapter(
                  child: TitleWidget(),
                ),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: AppBar().preferredSize.height,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Nos Restaurant',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontTitleSize,
                      letterSpacing: 0.27,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              )),
              SliverCrossAxisConstrained(
                child: SliverPinnedHeader(
                    child: SearchBarWidget(
                  callBack: () {},
                )),
                maxCrossAxisExtent: SizeConfig.blockSizeHorizontal * 89,
              )
            ])
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [AdsSection(), CategoryWidget(), PopularWidget()],
          ),
        )
      ],
    );
  }
}

class SliverAppBarHeader extends SliverPersistentHeaderDelegate {
  var min;

  SliverAppBarHeader({required this.min});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Column(
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical * 10,
        ),
        SearchBarWidget(callBack: () {}),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => AppBar().preferredSize.height * 3;

  @override
  // TODO: implement minExtent
  double get minExtent => min;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
