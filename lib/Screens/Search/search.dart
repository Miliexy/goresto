import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/Search/components/searchBarUi.dart';
import 'package:goresto/Screens/Search/search_screen.dart';
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
                        SearchBarUI(),
                      ),
                    ),

                  ],
                ),
              ],
            )];
          },
          body: ListView.builder(itemBuilder: (context, index) {
            return ListTile(title: Text("Chinese"),);
          },
            itemCount: 1,
          ),
        ),
      ),
    );
  }
}
