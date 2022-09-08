import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliver_tools/sliver_tools.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    ));
    var itemCount = 0;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
          title: Text("Favourites", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light
          ),
          automaticallyImplyLeading: false,
        ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverPinnedHeader(child: Container(color: Colors.grey,))
          ];
        },
        body: itemCount == 0 ? Center( child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your List is Empty"),
          ],
        )) : ListView(
          children: [

          ],
        )
      )
    );
  }
}
