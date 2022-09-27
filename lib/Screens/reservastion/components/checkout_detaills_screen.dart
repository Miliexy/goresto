import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:goresto/Screens/reservastion/components/checkout_screen.dart';
import 'package:goresto/constansts.dart';

import '../../../size_config.dart';

class CheckoutDetailsScreen extends StatelessWidget {
  const CheckoutDetailsScreen({Key? key, required TextEditingController dateController,
    required this.value,
    required TextEditingController timeController,}) : _dateController = dateController, _timeController = timeController,super(key: key);
  final TextEditingController _dateController;
  final int value;
  final TextEditingController _timeController;

  Future getData() async{
    return true;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xFFE7E7E7),
        appBar: AppBar(
          title: Text("Confirmation Page", style: Theme.of(context).textTheme.titleLarge,),
          leading: InkWell(child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).iconTheme.color,), onTap:()=> Navigator.of(context).pop(),),
          backgroundColor: Colors.white
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal *2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      title: Center(child: Text('Restaurant', style: Theme.of(context).textTheme.titleLarge,)),

                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal *4 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.calendar_month),
                                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                                  Text(_dateController.text)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Icon(Icons.people),
                                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                                  Text('${value} Personne')],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.access_time_outlined),
                                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                                  Text(_timeController.text)
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(width: SizeConfig.blockSizeHorizontal * 1,),
                                  Text("Le cuistot")
                                ],
                              ),
                            ],
                          ),
                          Container(
                              height: SizeConfig.blockSizeVertical * 25,
                              width: SizeConfig.blockSizeHorizontal * 25,
                              decoration: BoxDecoration(),
                              child: Image.asset(
                                  "assets/images/lecuissot_logo.png"))

                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      indent: SizeConfig.blockSizeHorizontal * 5,
                      endIndent: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical * 2,),
                    Center(
                      child: Text("User Details", style: Theme.of(context).textTheme.titleLarge,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal *4 , vertical: SizeConfig.blockSizeVertical * 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.people),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                              Text("Ilyasse Lahrach", style: Theme.of(context).textTheme.bodyLarge,)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Icon(Icons.phone),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                              Text('0600000000', style: Theme.of(context).textTheme.bodyLarge)],
                          ),
                          Row(
                            children: [
                              Icon(Icons.email),
                              SizedBox(width: SizeConfig.blockSizeHorizontal * 3,),
                              Text('Test@email.com',style: Theme.of(context).textTheme.bodyLarge)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.transparent,
              width: SizeConfig.blockSizeHorizontal * 100,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 15,
                    vertical: SizeConfig.blockSizeVertical * 1),
                child: ElevatedButton(
                  child: Text("Confirmer",
                      style: Theme.of(context).primaryTextTheme.headline6),
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pop(true);
                      });
                      return Dialog(
                        child: SizedBox(
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeHorizontal * 20,
                          child: FutureBuilder(
                            future: getData(),
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              List<Widget> children;
                              if (snapshot.hasData) {
                                children = <Widget>[
                                  const Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.green,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0, top: 16, right: 4.0),
                                    child: Text('Your order has been confirmed'),
                                  )
                                ];
                              } else if (snapshot.hasError) {
                                children = <Widget>[
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 60,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0, top: 16, right: 4.0),
                                    child: Text('Error: ${snapshot.error}'),
                                  )
                                ];
                              } else {
                                children = const <Widget>[
                                  SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: CircularProgressIndicator(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text('Saving your request'),
                                  )
                                ];
                              }
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: children,
                                ),
                              );
                            },
                          ),
                        ),);
                    },
                      barrierDismissible: false,
                    ).then((value) => Navigator.of(context).pushNamed("home"));
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
          )
        ],
      )
    );
  }
}
