import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goresto/Screens/MapTest/map.dart';
import 'package:goresto/Screens/Search/calendar_popup_view.dart';
import 'package:goresto/Screens/Search/components/searchBarUi.dart';
import 'package:goresto/Screens/Search/filters_screen.dart';
import 'package:goresto/Screens/Search/hotel_list_view.dart';
import 'package:goresto/Screens/testData/dataList.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'package:goresto/hotel_app_theme.dart';

class SearchScreen2 extends StatefulWidget {
  const SearchScreen2({Key? key}) : super(key: key);

  @override
  SearchScreen2State createState() => SearchScreen2State();
}

class SearchScreen2State extends State<SearchScreen2>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  AnimationController? _animationController;
  final ScrollController _scrollController = ScrollController();
  var buttonState = false;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    _animationController!.animateTo(0.0);
  }

  @override
  void initState() {
    buttonState = false;
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final _searchAnimation =
        Tween(begin: Offset(0, 0), end: Offset(-2, 0)).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Interval(
        0.3,
        0.5,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        minimum: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 6),
        top: false,
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: NestedScrollView(
                            controller: _scrollController,
                            headerSliverBuilder:
                                (BuildContext context, bool innerBoxIsScrolled) {
                              return [
                                SliverStack(
                                  children: [
                                    SliverPositioned.fill(
                                        child: Container(
                                      color: Colors.white24.withOpacity(1),
                                    )),
                                    MultiSliver(
                                      pushPinnedChildren: false,
                                      children: [
                                        SliverPersistentHeader(
                                          pinned: true,
                                          floating: true,
                                          delegate: SearchBarHeader(
                                            SearchBarUI(enabled: true,
                                              hintText: "Something",
                                            ),
                                          ),
                                        ),
                                        SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                              (BuildContext context, int index) {
                                            return Column(
                                              children: <Widget>[
                                                getTimeDateUI(),
                                              ],
                                            );
                                          }, childCount: 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ];
                            },
                            body: Stack(
                              children: [
                                SlideTransition(
                                  position: _searchAnimation,
                                  child: Container(
                                    color: GorestoAppTheme.buildDarkTheme()
                                        .backgroundColor,
                                    child: ListView.builder(
                                      itemCount: restaurantsList.length,
                                      padding: const EdgeInsets.only(top: 8),
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        animationController?.forward();
                                        final int count =
                                            restaurantsList.length > 10
                                                ? 10
                                                : restaurantsList.length;
                                        final Animation<double> animation =
                                            Tween<double>(begin: 0.0, end: 1.0)
                                                .animate(CurvedAnimation(
                                                    parent: animationController!,
                                                    curve: Interval(
                                                        0.1 +
                                                            (1 / (count * 10)) *
                                                                (index / 10),
                                                        0.3,
                                                        curve: Curves
                                                            .fastOutSlowIn)));
                                        return RestaurantListView(
                                          callback: () {},
                                          restaurantData: restaurantsList[index],
                                          animation: animation,
                                          animationController:
                                              animationController!,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                MapTest(
                                    animationController: _animationController!),
                              ],
                            )))
                  ],
                ),
              ),
              Align(
                alignment: Alignment(0, 0.9),
                child: Container(
                  width: SizeConfig.blockSizeHorizontal * 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.1,0.2)
                      )
                    ]
                  ),
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 3.5, vertical: SizeConfig.blockSizeVertical * 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Icon(Icons.tune),
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Navigator.push<dynamic>(
                              context,
                              MaterialPageRoute<dynamic>(
                                  builder: (BuildContext context) => FiltersScreen(),
                                  fullscreenDialog: true),
                            );
                          },
                        ),
                        InkWell(
                          child: buttonState ? Icon(Icons.view_agenda) : Icon(Icons.map),
                          onTap: (){
                            if (_animationController!.value < 0.5) {
                              setState(() {
                                buttonState = true;
                              });
                              _animationController!.animateTo(0.8).then((value) =>
                                  _scrollController.animateTo(210,
                                      duration: Duration(seconds: 1),
                                      curve: Curves.easeIn));
                              ;
                            } else {
                              setState(() {
                                buttonState = false;
                              });
                              _scrollController.animateTo(1,
                                  duration: Duration(seconds: 1), curve: Curves.easeIn);
                              print("position:" + _scrollController.toString());
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(Icons.calendar_month, color: Theme.of(context).iconTheme.color,),
                              Text(
                                '${DateFormat("dd, MMM").format(startDate)}',
                                  style: Theme.of(context).textTheme.bodyMedium
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
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Text(
                                'Ville',
                                  style: Theme.of(context).textTheme.bodyMedium
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
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: [

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: GorestoAppTheme.buildDarkTheme()
                                    .primaryColor),
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
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => Dialog(
        child: CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(3000),
          onDateChanged: (value) {
            setState(() {
              startDate = value;
            });
          },

        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: GorestoAppTheme.buildDarkTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32.0),
                      ),
                      onTap: () {
                        animationController?.animateTo(0.5);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.locationDot),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchBarHeader extends SliverPersistentHeaderDelegate {
  SearchBarHeader(this.searchBar);
  final Widget searchBar;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: searchBar,
      color: Colors.white24.withOpacity(1),
    );
  }

  @override
  double get maxExtent => SizeConfig.blockSizeVertical * 12;

  @override
  double get minExtent => SizeConfig.blockSizeVertical * 12;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => SizeConfig.blockSizeVertical * 15;

  @override
  double get minExtent => SizeConfig.blockSizeVertical * 15;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
