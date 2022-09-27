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
          elevation: 0,
          title: Text(
              "Favourites",
              style: Theme.of(context).textTheme.titleLarge

          ),
          centerTitle: true,
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPinnedHeader(
                    child: Container(
                      color: Colors.grey,
                    ))
              ];
            },
            body: itemCount == 0
                ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ColorFiltered(
                      child: Image.asset("assets/images/empty_list.png"),
                      colorFilter: ColorFilter.mode(
                          Colors.grey.withAlpha(5),
                          BlendMode.difference
                      ),),
                    Text("Your List is Empty"),
                  ],
                ))
                : ListView(
              children: [],
            )));
  }
}
