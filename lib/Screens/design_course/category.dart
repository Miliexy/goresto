
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:geocoding/geocoding.dart';
import 'package:goresto/Screens/design_course/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/introduction_animation/components/defaultText.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';

import '../testData/dataList.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({Key? key}) : super(key: key);
  @override
  CategoryListViewState createState() => CategoryListViewState();
}

class CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 3,
          bottom: SizeConfig.blockSizeVertical * 3),
      child: Container(
        height: SizeConfig.blockSizeVertical * 20,
        width: double.infinity,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: getData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, right: 16, left: 16),
                itemCount: snapshot.data?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int? count =
                      restaurantsList.length > 10 ? 10 : snapshot.data?.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count!) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return CategoryView(restaurant: snapshot.data![index], callback: () {}, animation: animation, animationController: animationController!,);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  CategoryView(
      {Key? key,
      required this.restaurant,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Map<String, dynamic> restaurant;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
  List<Placemark> placemark = restaurant["placemark"];

    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.red,
              onTap: () => Navigator.pushNamed(context, AppRouter.detailsRoute, arguments: restaurant),
              onLongPress: () {
                showDialog(context: context, builder: (context) {
                  return Dialog(

                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: SizeConfig.blockSizeVertical * 30,
                            child: InkWell(
                              onTap: () {},
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ColorFiltered(colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.33),
                                      BlendMode.srcATop),child: Image.asset(restaurant["imagePath"], fit: BoxFit.fill,)),
                                  Padding(
                                    padding: EdgeInsets.only(left: SizeConfig.blockSizeVertical * 2),
                                    child: Align(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Spacer(),
                                            Row(
                                              children: [
                                                Text(restaurant["name"],style: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 3.5),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Flexible(child: Text("0606060600",style: TextStyle(color: Colors.white), )),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Address somewhere" ,style: TextStyle(color: Colors.white)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      Card(
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        //margin: EdgeInsets.symmetric(horizontal: 12),
                        elevation: 2,
                        clipBehavior: Clip.hardEdge,
                        child: Column(
                          children: [
                            const ListTile(
                              leading: Icon(Icons.view_headline),
                              title: Text('Description'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                ysWelcomeText + ysWelcomeText,
                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      ),Card(
                            elevation: 2,
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.view_module),
                                  title: Text("Categories"),
                                ),
                                Container(
                                  child: AlignedGridView.count(
                                    crossAxisCount: 2,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              child: Icon(Icons.bookmark_border),
                                              backgroundColor: kSecondaryColor,
                                            ),
                                            Text("Category")
                                          ],
                                        ),
                                        onTap: () {},
                                      );
                                    },
                                    itemCount: 2,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.all(25),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },);
              },
              child: SizedBox(
                width: SizeConfig.blockSizeHorizontal * 65,
                child: Stack(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: SizeConfig.blockSizeVertical * 7,
                        ),
                        Expanded(
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Color(0xFFF8FAFB),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16.0)),
                            ),
                            child: Stack(
                              children: [
                                SizedBox(
                                  child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.33),
                                          BlendMode.srcATop),
                                      child: Image.asset(
                                        restaurant["imagePath"],
                                        fit: BoxFit.fill,
                                      )),
                                  height: SizeConfig.blockSizeVertical * 9.5,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          restaurant["name"],
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontTextSize,
                                            letterSpacing: 0.27,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, bottom: 9, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: SizeConfig.blockSizeVertical * 3),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.add_location_rounded, size: 16,),
                                                    Text(
                                                      '${placemark[0].street}, ${placemark[0].locality}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 10,
                                                        letterSpacing: 0.27,
                                                        color: Colors.black,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1 ,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, right: 16, left: 32),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              'A partir de:',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600,
                                                fontSize: 10,
                                                letterSpacing: 0,
                                                color: kPrimaryLightColor,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${restaurant["minPrice"]} DH',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight:
                                                    FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                color: kSecondaryColor,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${restaurant["rating"]}',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15.5,
                                              letterSpacing: 0.27,
                                              color: DesignCourseAppTheme
                                                  .grey,
                                            ),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: kSecondaryColor,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment(-0.75,0),
                      child: SizedBox(
                        height: 64,
                        width: 64,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(16.0)),
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                restaurant["logo"],fit: BoxFit.contain,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
