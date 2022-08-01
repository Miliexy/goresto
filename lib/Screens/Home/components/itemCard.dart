import 'package:flutter/material.dart';


class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.radius,
    required this.height,
    required this.width, required this.index,
  }) : super(key: key);

  final Radius radius;
  final double height;
  final double width;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 30,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(radius),
          border: Border.all(color: Colors.black, width: 0.5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      width: width * 85,
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(children: [
          Column(
            children: [
              Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/image.webp"),
                          fit: BoxFit.cover))),
              Container(
                color: Colors.white,
                width: constraints.maxWidth,
                height: constraints.maxHeight * 0.4,
              )
            ],
          ),
          Transform.translate(
              offset: Offset(constraints.biggest.width * 0.08,
                  constraints.biggest.height * 0.45),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                    AssetImage("assets/images/image.webp"),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Restaurant's Name"+ index.toString()),
                            Container(width: constraints.maxWidth * 0.5,child: Text("European fare and notable wines.", overflow: TextOverflow.fade, maxLines: 1,))
                          ],
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              SizedBox(
                                  width: width * 15,
                                  child: IconButton(
                                    icon: Icon(Icons.whatsapp),
                                    onPressed: () {},
                                    iconSize: 30,
                                  )),
                              SizedBox(
                                  width: width * 15,
                                  child: IconButton(
                                    icon: Icon(Icons.location_on_outlined),
                                    iconSize: 30,
                                    onPressed: () {},
                                  )),
                            ],
                          ),
                        ),
                      ]),
                ],
              )),
        ]),
      ),
    );
  }
}