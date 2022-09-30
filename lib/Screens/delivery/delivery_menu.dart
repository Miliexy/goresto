import 'package:flutter/material.dart';
import 'package:goresto/Screens/delivery/delivery_screen.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';

class DeliveryMenu extends StatefulWidget {
  const DeliveryMenu({Key? key}) : super(key: key);

  @override
  State<DeliveryMenu> createState() => _DeliveryMenuState();
}

class _DeliveryMenuState extends State<DeliveryMenu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Reservation Details",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: InkWell(
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white),
      body: Stack(
        children: [
          ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(height: SizeConfig.blockSizeVertical * 0.2,);
            },
            shrinkWrap: true,
            padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical * 2, left: SizeConfig.blockSizeHorizontal * 3, right: SizeConfig.blockSizeHorizontal * 3),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  showModalBottomSheet(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
                  ),
                    clipBehavior: Clip.hardEdge,
                    context: context, builder:(context) {
                    return Column(
                      children: [
                        Card(
                          margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2.5, vertical: SizeConfig.blockSizeVertical * 2),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 92,
                                    width: 92,
                                    child: Image.asset("assets/images/fine-dining1.jpg"),
                                  ),
                                  Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2, top: SizeConfig.blockSizeVertical * 1),
                                      child: Text("Couscous 7 legumes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),),),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical*2,)
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Message"),
                              SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                              TextFormField(
                                maxLines: 8,
                                minLines: 5,
                                decoration: InputDecoration(
                                  hintText: "not spicy"
                                ),
                                keyboardType: TextInputType.multiline,
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 15,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kSecondaryColor,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                borderRadius:
                                BorderRadius.circular(12),
                                onTap: () {
                                },
                                child: Icon(Icons.remove,
                                    color: kSecondaryColor),
                              ),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 2,
                            ),
                            Text(
                              '1',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 2,
                            ),
                            Container(
                              height: SizeConfig.blockSizeVertical * 5,
                              width: SizeConfig.blockSizeHorizontal * 15,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: kSecondaryColor,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                borderRadius:
                                BorderRadius.circular(12),
                                onTap: () {
                                },
                                child: Icon(Icons.add,
                                    color: kSecondaryColor),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2,
                        ),
                        ElevatedButton(onPressed: (){

                        }, child: Text("Add to Cart"),
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(SizeConfig.blockSizeHorizontal * 80,SizeConfig.blockSizeVertical * 7))
                        ),)
                      ],
                    );
                  },);
                },
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          clipBehavior: Clip.hardEdge,
                          height: SizeConfig.blockSizeVertical *10,
                          width: SizeConfig.blockSizeHorizontal* 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Image.asset("assets/images/fine-dining1.jpg")
                      ),
                      Expanded(
                        child: Padding(
                          padding:  EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2, left: SizeConfig.blockSizeHorizontal * 2, right: SizeConfig.blockSizeHorizontal *2),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Item Name", style: Theme.of(context).textTheme.titleMedium,),
                                  Text("35.00 MAD")
                                ],
                              ),

                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: 10,
          ),
          Visibility(
              visible: MediaQuery.of(context).viewInsets.bottom == 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.transparent,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal * 15,
                        vertical: SizeConfig.blockSizeVertical * 1),
                    child: ElevatedButton(
                      child: Text("Suivant",
                          style: Theme.of(context).primaryTextTheme.headline6),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryScreenDetails(),));

                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.blockSizeVertical * 4))),
                        fixedSize: MaterialStateProperty.all(Size(
                            SizeConfig.blockSizeHorizontal * 50,
                            SizeConfig.blockSizeVertical * 7)),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
