
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //late final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(color: Colors.red,)
      /*NestedScrollView(controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverStack(
              insetOnOverlap: false,
                children: [
                  SliverToBoxAdapter(
                    child: Image.asset("assets/images/fine-dining1.jpg"),
                  ),
                  MultiSliver(children: [
                    SliverToBoxAdapter(
                      child: TitleWidget()  ,
                    ),
                    SliverCrossAxisConstrained(maxCrossAxisExtent: SizeConfig.blockSizeHorizontal * 85,child: SliverPinnedHeader(child: SearchBarWidget(callBack: (){},)))
                  ])

            ]),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Container(color: Colors.yellow,height: SizeConfig.blockSizeVertical * 7,)
                      ],
                    );
                  }, childCount: 1),
            ),
            SliverPinnedHeader(child: Container(color: Colors.white, height: SizeConfig.blockSizeVertical * 3,)),
            SliverPersistentHeader(delegate: SearchBarHeader(
              Container(color: Colors.red,)
            ),pinned: true,),
            SliverPersistentHeader(delegate: SearchBarHeader(
                Container(color: Colors.grey,)
            ), pinned: false,),
            SliverCrossAxisConstrained(maxCrossAxisExtent: SizeConfig.blockSizeHorizontal * 56, child: SliverPersistentHeader(
              delegate: SearchBarHeader(
                Container(color: Colors.orangeAccent,)
              ),
            )),
            SliverPersistentHeader(delegate: SearchBarHeader(
                Container(color: Colors.greenAccent,)
            ), pinned: true,),
          ];
        },
        body: ListView.builder(itemBuilder: (context, index) {
          return Container(child: Text('${index}'),);
        },
          itemCount: 50,
        ),
      )*/
    );
  }
}
