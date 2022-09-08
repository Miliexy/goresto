import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/components/roundedIcnBtn.dart';
import 'package:goresto/Screens/reservastion/components/dateTimePicker.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/size_config.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);
  static String routeName = "/booking";

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  late DateTime _dateTime;
  late String _setTime;
  late String _hour, _minute, _time;

  late TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController _timeController = TextEditingController();

  late String _countryCode;

  late String _invalidPhoneMessage;

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container());
        });
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute), [
          HH,
          ':',
          nn,
        ]).toString();
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _countryCode = 'MA';
    _invalidPhoneMessage = "Invalid Phone Number";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));
    return Scaffold(body: Body());
  }

  Container buildContainer() {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IntlPhoneField(
          invalidNumberMessage: _invalidPhoneMessage,
          decoration: InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          initialCountryCode: _countryCode,
          onChanged: (phone) {
            setState(() {
              _invalidPhoneMessage = "Invalid Phone Number";
            });
            if (phone.number.characters.first == '0')
              setState(() {
                _invalidPhoneMessage = "Phone number can't start with 0";
              });
            print(phone.number);
          },
          onSubmitted: (p0) {
            if (p0.characters.first == '0') print("error");
          },
          onCountryChanged: (value) {
            setState(() {
              _countryCode = value.code;
              print(_countryCode);
            });
          },
        ),
        DateTimePicker(),
      ],
    ));
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  ScrollController _scrollController = ScrollController();
  late bool isDelivery, isTakeaway;
  late String _countryCode;
  late String _invalidPhoneMessage;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDelivery = true;
    isTakeaway = !isDelivery;
    _countryCode = 'MA';
    _invalidPhoneMessage = "Invalid Phone Number";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: kPrimaryColor,
              leading: RoundedIcnBtn(
                iconData: Icons.arrow_back_ios_new,
                press: () => Navigator.of(context).pop(),
                opacity: 0.8,
              ),
              elevation: 10,
              centerTitle: true,
              pinned: true,
              title: Column(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(color: kPrimaryLightColor),
                  ),
                  Text("address", style: TextStyle(color: kPrimaryLightColor))
                ],
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top:SizeConfig.blockSizeVertical * 5),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.blockSizeVertical * 5,),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 10,
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(
                            enableFeedback: !isDelivery,
                            child: Container(
                                width: SizeConfig.blockSizeHorizontal * 30,
                                decoration: BoxDecoration(
                                  border: Border.all(color: kSecondaryColor),
                                  color: isDelivery ? kSecondaryColor: kPrimaryColor,
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(SizeConfig.blockSizeVertical * 2), bottomLeft: Radius.circular(SizeConfig.blockSizeVertical * 2))
                                ),
                                child: Center(child: Text("Livraison", style: TextStyle(fontSize: fontTitleSize - 9),))),
                            onTap: () {
                              setState(() {
                                print("Hello");
                                isTakeaway = false;
                                isDelivery = !isTakeaway;
                              });
                            },
                          ),
                          InkWell(
                            enableFeedback: !isTakeaway,
                            child: Container(
                                width: SizeConfig.blockSizeHorizontal * 30,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kSecondaryColor),
                                    color: isTakeaway ? kSecondaryColor: kPrimaryColor,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(SizeConfig.blockSizeVertical * 2), bottomRight: Radius.circular(SizeConfig.blockSizeVertical * 2))
                                ),
                                child: Center(child: Text("Takeaway", style: TextStyle(fontSize: fontTitleSize - 9, fontWeight: FontWeight.w500),))),
                            onTap: () {
                              setState(() {
                                print("World");
                                setState(() {
                                  isTakeaway = true;
                                  isDelivery = !isTakeaway;
                                });
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 50,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.view_headline),
                          title: Text('Description'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "sad",
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2.5,),
                Container(
                  height: SizeConfig.blockSizeVertical * 25,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.view_headline),
                          title: Text('My Orders'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "sad",
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 2.5,),
                Container(
                  height: SizeConfig.blockSizeVertical * 25,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.view_headline),
                          title: Text('contact Information'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: IntlPhoneField(
                            invalidNumberMessage: _invalidPhoneMessage,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            initialCountryCode: _countryCode,
                            onChanged: (phone) {
                              setState(() {
                                _invalidPhoneMessage = "Invalid Phone Number";
                              });
                              if (phone.number.characters.first == '0')
                                setState(() {
                                  _invalidPhoneMessage = "Phone number can't start with 0";
                                });
                              print(phone.number);
                            },
                            onSubmitted: (p0) {
                              if (p0.characters.first == '0') print("error");
                            },
                            onCountryChanged: (value) {
                              setState(() {
                                _countryCode = value.code;
                                print(_countryCode);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
