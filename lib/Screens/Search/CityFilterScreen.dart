import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:goresto/Screens/Search/components/searchBarUi.dart';
import 'package:goresto/Screens/Search/search_screen.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CityFilterScreen extends StatefulWidget {
  const CityFilterScreen({Key? key}) : super(key: key);

  @override
  State<CityFilterScreen> createState() => _CityFilterScreenState();
}

class _CityFilterScreenState extends State<CityFilterScreen> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                          SearchBarUI(hintText: "Ou ?",enabled: true),
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
                  return ListTile(leading: Icon(FontAwesomeIcons.city,), title: Text("City Name"), onTap: () {

                  },);
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
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen2(),));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
