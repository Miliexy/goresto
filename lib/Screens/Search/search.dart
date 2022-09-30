import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:goresto/Screens/Search/components/searchBarUi.dart';
import 'package:goresto/Screens/Search/search_calendar.dart';
import 'package:goresto/Screens/Search/search_screen.dart';
import 'package:goresto/Screens/testData/Restaurant.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchScreenEmpty extends StatelessWidget {
  const SearchScreenEmpty({Key? key}) : super(key: key);
  static String routeName = "/search";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            statusBarColor: Colors.transparent
          )
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [SliverStack(
              children: [
                SliverPositioned.fill(child: Container(color: Colors.white24.withOpacity(1),)),
                MultiSliver(
                  pushPinnedChildren: false,
                  children: [
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: SearchBarHeader(
                        SearchBarUI(hintText: "something",enabled: true ,),

                      ),
                    ),

                  ],
                ),
              ],
            )];
          },
          body: Stack(
            children: [
              ListView.builder(itemBuilder: (context, index) {
                return ListTile();
              },
                itemCount: 1,
              ),
              Positioned(bottom: SizeConfig.blockSizeVertical * 5,
                right: SizeConfig.blockSizeHorizontal * 5,child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                  fixedSize: MaterialStateProperty.all(Size(SizeConfig.blockSizeHorizontal * 40, SizeConfig.blockSizeVertical * 5))
                ),
                child: Text("Suivant", style: Theme.of(context).primaryTextTheme.titleMedium,),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchCalendar(),));
                },
              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
