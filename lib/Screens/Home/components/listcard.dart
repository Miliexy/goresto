
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goresto/routes.dart';
import 'package:goresto/size_config.dart';

class listCard extends StatelessWidget {
  List<Map<String, String>>? testList;
  var element;
  int? listType;

  listCard( {Key? key, this.listType})
      : super(key: key);

  listCard.getElement({this.testList, Key? key, this.element, required this.listType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
        Navigator.of(context).push(createRoute((listType == 1 ? "/map": "/details")));
        },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 90,
            height: SizeConfig.blockSizeVertical * (listType == 1 ? 35 : 45),
            margin: const EdgeInsets.only(bottom: 6.0),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
                image: DecorationImage(
                    image: AssetImage(element["image"].toString()),
                    fit: BoxFit.cover)),
            child: listType == 1 ? buildCities(): buildRestau(),
          ),
        ),
      ),
    );
  }

  Center buildCities() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined, size: 45, color: Colors.white,),
            Text(element["name"].toString(), style:  GoogleFonts.montserratAlternates(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),),
            Text(element["count"].toString(), style:  GoogleFonts.montserratAlternates(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))
          ],
        )
    );
  }

  Stack buildRestau() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              height: SizeConfig.blockSizeVertical * 22,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    element["name"],
                                    style:
                                    GoogleFonts.montserratAlternates(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    element["description"].toString(),
                                    style:
                                    GoogleFonts.montserratAlternates(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                        color:
                                        const Color(0xe8727171)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        RatingBar(
                            ratingWidget: RatingWidget(
                                empty: const Icon(Icons.star_border),
                                half: const Icon(Icons.star_half),
                                full: const Icon(Icons.star)),
                            onRatingUpdate: (rating) {},
                            allowHalfRating: true,
                            ignoreGestures: true,
                            initialRating: 2,
                            itemSize: 20),
                        Text("2")
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, bottom: 15, right: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: const [
                                    CircleAvatar(
                                      child: Icon(Icons.bookmark_border),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text("Category"),
                                    ),
                                  ],
                                ),
                              ),
                              const CircleAvatar(
                                child: Icon(Icons.whatsapp),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              const CircleAvatar(
                                child: Icon(Icons.directions_outlined),
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
        const Align(
          alignment: Alignment(-0.888, 0),
          child: CircleAvatar(
            radius: 35,
            foregroundImage: AssetImage("assets/images/avatar_test.png"),
          ),
        )
      ],
    );
  }
}