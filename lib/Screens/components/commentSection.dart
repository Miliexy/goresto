

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:goresto/size_config.dart';

class CommentSection extends StatefulWidget {
  const CommentSection({
    Key? key,
    required this.testText,
  }) : super(key: key);

  final String testText;

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  List<Map<String,String>> testComment = [
    {
      "user" : "user",
      "comment" : "The Liman Restaurant means port in the Turkish language, however the restaurant opens its doors to all aspects of the Mediterranean kitchen. The kitchen will be mostly focused on Mediterranean food; the owners of the restaurant are young professional chefs who can bring new, exciting tastes to Angel, Islington which will show through in the quality of food they prepare"
    },
    {
      "user" : "user",
      "comment" : "The Liman Restaurant means port in the Turkish language, however the restaurant opens its doors to all aspects of the Mediterranean kitchen. The kitchen will be mostly focused on Mediterranean food; the owners of the restaurant are young professional chefs who can bring new, exciting tastes to Angel, Islington which will show through in the quality of food they prepare"
    },
    {
      "user" : "user",
      "comment" : "The Liman Restaurant means port in the Turkish language, however the restaurant opens its doors to all aspects of the Mediterranean kitchen. The kitchen will be mostly focused on Mediterranean food; the owners of the restaurant are young professional chefs who can bring new, exciting tastes to Angel, Islington which will show through in the quality of food they prepare"
    },
    {
      "user" : "user",
      "comment" : "The Liman Restaurant means port in the Turkish language, however the restaurant opens its doors to all aspects of the Mediterranean kitchen. The kitchen will be mostly focused on Mediterranean food; the owners of the restaurant are young professional chefs who can bring new, exciting tastes to Angel, Islington which will show through in the quality of food they prepare"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.symmetric(horizontal: 12),
            elevation: 13,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Text('Customer Rating'),
                  title: Text('4.2'),
                  trailing: SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 13,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.comment),
                        Text("0")
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("4.2"),
                            Icon(Icons.star)
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2 ,
                        child: ListView.builder(itemBuilder: (context, index) {
                          return Row(
                            children: [
                              RatingBar(
                                  ratingWidget: RatingWidget(
                                      empty: const Icon(Icons.star_border),
                                      half: const Icon(Icons.star_half),
                                      full: const Icon(Icons.star)),
                                  onRatingUpdate: (rating) {},
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  initialRating: (5-index).toDouble(),
                                  itemSize: 20),
                              Text('${5-index}'),
                            ],
                          );
                        },
                          itemCount: 5,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                          physics: NeverScrollableScrollPhysics(),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: testComment.isEmpty ? true : false,
                child: Column(
                  children: [
                    Icon(Icons.mood_bad),
                    Text("No Comments")
                  ],
                ),
              )
            ],
          ),
          ListView.builder(itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.all(15),
              child: Column(
                children: [
                  ListTile(
                    leading: Text('${testComment[index]['user']}$index'),
                    trailing: RatingBar(
                        ratingWidget: RatingWidget(
                            empty: const Icon(Icons.star_border),
                            half: const Icon(Icons.star_half),
                            full: const Icon(Icons.star)),
                        onRatingUpdate: (rating) {},
                        allowHalfRating: true,
                        ignoreGestures: true,
                        initialRating: (5-index).toDouble(),
                        itemSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    child: Align(child: Text('${testComment[index]["comment"]}'), alignment: Alignment(-0.8, 0.2),),
                  ),
                ],
              ),
            );
          },
            itemCount: testComment.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
          )
        ],
      ),
    );
  }
}