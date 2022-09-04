import 'package:goresto/Screens/design_course/newHomeTest.dart';
import 'package:goresto/Screens/design_course/restaurant_info.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/search/hotel_home_screen.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'components/AppBar.dart';
import 'components/category.dart';
import 'components/popularList.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);
  static String routeName = "/newHome";

  @override
  NewHomeScreenState createState() => NewHomeScreenState();
}

class NewHomeScreenState extends State<NewHomeScreen> {

  var currentIndex = 0;
  late final List<Widget> _children = [

    HomePage(callBack: callBack),
    const SearchScreen(),
    const MyHomePage()
  ];
  void callBack()
  {
    setState(() {
      currentIndex = 1;
    });
  }

  @override

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "search"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "fav"),
        ],
        onTap: onTabTapped ,
        currentIndex: currentIndex,
      ),
      body: _children[currentIndex],
    );
  }

  void onTabTapped(int index) {
    setState(() {currentIndex = index;});
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

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    Key? key, required  this.callBack,
  }) : super(key: key);
  final Function callBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(13.0),
          bottomLeft: Radius.circular(13.0),
          topLeft: Radius.circular(13.0),
          topRight: Radius.circular(13.0),
        ),
      ),
      height: SizeConfig.blockSizeVertical * 6,
      constraints: BoxConstraints(
          maxWidth: SizeConfig.blockSizeHorizontal * 89
      ),
      child: TextFormField(
        maxLines: 1,
        expands: false,
        style: TextStyle(
          fontFamily: 'WorkSans',
          fontWeight: FontWeight.bold,
          fontSize: SizeConfig.blockSizeVertical * 2,
          color: kSecondaryColor,
        ),
        keyboardType: TextInputType.text,
        readOnly: true,
        showCursor: true,
        onTap: () {
          callBack();
        },
        decoration: InputDecoration(
            hintText: "search",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            prefixIcon:  Icon(Icons.search, size: SizeConfig.blockSizeVertical * 3,),
            suffixIcon: IconButton(
              icon: Icon(Icons.my_location, size: fontTextSize,),
              onPressed: () {},
            )),
        onEditingComplete: () {},
      ),
    );
  }
}

class HomePage2 extends StatelessWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(color: Colors.red, height: SizeConfig.blockSizeVertical *15 ,),
              ),
              SliverAppBar(
                title: SearchBarWidget(callBack: () {}),
                pinned: true,
              ),

              SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('Grid Item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('List Item $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.callBack}) : super(key: key);
  final Function callBack;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverStack(children: [
          SliverToBoxAdapter(child: Container(
            clipBehavior: Clip.hardEdge,
            width: SizeConfig.blockSizeHorizontal*100,
            height: SizeConfig.blockSizeVertical *30,
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
            child: Image.asset("assets/images/fine-dining1.jpg", fit: BoxFit.cover,),
          ),),
          MultiSliver(children: [
            SliverToBoxAdapter(
              child: SizedBox(height: SizeConfig.blockSizeVertical * 3,),
            ),
            SliverToBoxAdapter(
              child: TitleWidget(),
            ),
            SliverPinnedHeader(
              child: SizedBox(height: SizeConfig.blockSizeVertical * 9,),
            ),
            SliverCrossAxisConstrained(maxCrossAxisExtent: SizeConfig.blockSizeHorizontal * 88,child: SliverPinnedHeader(child: SearchBarWidget(callBack: callBack,)))
          ])
        ],insetOnOverlap: false,),
        SliverToBoxAdapter(child: Column(
          children: [
            CategoryWidget(),
            PopularWidget()
          ],
        ),)
      ],
    );
  }
}





