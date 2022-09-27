import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/components/roundedIcnBtn.dart';
import 'package:goresto/Screens/reservastion/components/checkout_screen.dart';
import 'package:goresto/Screens/reservastion/components/dateTimePicker.dart';
import 'package:goresto/constansts.dart';
import 'package:goresto/hotel_app_theme.dart';
import 'package:goresto/size_config.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Services/Secret.dart';
import '../../Services/SecretLoader.dart';

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
  List<int> list = List<int>.generate(20, (index) => index + 1);

  int index = 0;
  late TimeOfDay selectedTime = TimeOfDay.now();
  late DateTime selectedDate;
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _peopleController = TextEditingController();
  FixedExtentScrollController _pickerController = FixedExtentScrollController();
  late String _countryCode;

  late String _invalidPhoneMessage;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        print(picked);
        _dateController.text = DateFormat('EEEE, d MMMM, yyyy').format(picked);
      });
  }
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool isSwitched = false;
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay =
    await showTimePicker(context: context, initialTime: _selectedTime,
      builder: (context, child) {
        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child ?? SizedBox()  ,);
      },);
    if(timeOfDay != null){
      setState(() {
        _selectedTime = timeOfDay;
        _timeController.text = DateFormat("HH:mm").format(DateTime(2019, 08, 1, _selectedTime.hour, _selectedTime.minute));

      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    _countryCode = 'MA';
    _invalidPhoneMessage = "Invalid Phone Number";
    _dateController.text = "Date de reservation";
    _peopleController.text = "Nombre de Personne";
    _timeController.text = "Heure de reservation";
  }
  Future _fetchData() async {
    Secret secret = await SecretLoader(secretPath: "secrets.json").load();
    print('${secret.apiKey}');
    return secret.apiKey;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ElevatedButton(
        child: Text("Suivant"),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ConfirmationScreen(),));
        },
      ),
      appBar: AppBar(
        title: Text("Select Date"),
      ),
      body: SizedBox(
        width: SizeConfig.blockSizeHorizontal * 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 90,
                child: Center(
                    child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        gapPadding: 5),
                    prefixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: kSecondaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.none,
                  controller: _dateController,
                  onTap: () {
                    _selectDate(context);
                  },
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: SizeConfig.blockSizeVertical * 2.3),
                )),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 4,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 90,
                child: Center(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            gapPadding: 5),
                        prefixIcon: Icon(
                          Icons.access_time_rounded,
                          color: kSecondaryColor,
                        ),
                      ),
                      keyboardType: TextInputType.none,
                      showCursor: false,
                      controller: _timeController,
                      onTap: () {
                        _selectTime(context);
                      },
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: SizeConfig.blockSizeVertical * 2.3),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 90,
                child: Center(
                    child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        gapPadding: 5),
                    prefixIcon: Icon(
                      Icons.people,
                      color: kSecondaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.none,
                  controller: _peopleController,
                  onTap: () {
                    _pickerController.jumpToItem(index);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: SizedBox(
                            height: SizeConfig.blockSizeVertical * 25,
                            width: SizeConfig.blockSizeHorizontal * 40,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 15,
                                  child: CupertinoPicker(
                                    looping: true,
                                    children: List<Widget>.generate(
                                        20,
                                        (index) => Center(
                                              child: Text(
                                                '${index + 1}',
                                                style: TextStyle(
                                                    fontSize: SizeConfig
                                                            .blockSizeVertical *
                                                        2,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )),
                                    onSelectedItemChanged: (index) {
                                      setState(() {
                                        this.index = index;
                                        _peopleController.text =
                                            '${index + 1} personne';
                                      });
                                      print(this.index);
                                    },
                                    useMagnifier: false,
                                    itemExtent:
                                        SizeConfig.blockSizeVertical * 5,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Confirm"))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: SizeConfig.blockSizeVertical * 2.3),
                )),
              ),
            ),
          ],
        ),
      ),
    );
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

  List<int> list = List<int>.generate(20, (index) => index + 1);

  int index = 0;

  updateVal(int val) {
    setState(() {
      index = val;
    });
  }

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
        physics: NeverScrollableScrollPhysics(),
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
                    "Reservation",
                    style: TextStyle(color: kPrimaryLightColor),
                  )
                ],
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 0,
                ),
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
                                width: SizeConfig.blockSizeHorizontal * 40,
                                decoration: BoxDecoration(
                                    border: Border.all(color: kSecondaryColor),
                                    color: isDelivery
                                        ? kSecondaryColor
                                        : kPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            SizeConfig.blockSizeVertical * 2),
                                        bottomLeft: Radius.circular(
                                            SizeConfig.blockSizeVertical * 2))),
                                child: Center(
                                    child: Text(
                                  "Reservation",
                                  style:
                                      TextStyle(fontSize: fontTitleSize - 10),
                                ))),
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
                                    color: isTakeaway
                                        ? kSecondaryColor
                                        : kPrimaryColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            SizeConfig.blockSizeVertical * 2),
                                        bottomRight: Radius.circular(
                                            SizeConfig.blockSizeVertical * 2))),
                                child: Center(
                                    child: Text(
                                  "Takeaway",
                                  style: TextStyle(
                                      fontSize: fontTitleSize - 9,
                                      fontWeight: FontWeight.w500),
                                ))),
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.grey[200],
                          child: Center(
                              child:
                                  ListTile(title: Text("Restaurant's Name"))),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.phone),
                              IntlPhoneField(
                                invalidNumberMessage: _invalidPhoneMessage,
                                decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    constraints: BoxConstraints.tight(Size(
                                        SizeConfig.blockSizeHorizontal * 80,
                                        SizeConfig.blockSizeHorizontal * 15))),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                initialCountryCode: _countryCode,
                                onChanged: (phone) {
                                  setState(() {
                                    _invalidPhoneMessage =
                                        "Invalid Phone Number";
                                  });
                                  if (phone.number.characters.first == '0')
                                    setState(() {
                                      _invalidPhoneMessage =
                                          "Phone number can't start with 0";
                                    });
                                  print(phone.number);
                                },
                                onSubmitted: (p0) {
                                  if (p0.characters.first == '0')
                                    print("error");
                                },
                                onCountryChanged: (value) {
                                  setState(() {
                                    _countryCode = value.code;
                                    print(_countryCode);
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      DateTimePicker(),
                      Container(
                        child: InkWell(
                          child: TextFormField(
                            keyboardType: TextInputType.none,
                            showCursor: false,
                            initialValue: '${index} personne',
                            onTap: null,
                            enabled: false,
                            focusNode: FocusNode(canRequestFocus: false),
                            decoration:
                                InputDecoration(prefixIcon: Icon(Icons.people)),
                          ),
                          onTap: () {
                            print("Tapped");
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: StatefulBuilder(
                                    builder: (context, setState) => SizedBox(
                                      height: SizeConfig.blockSizeVertical * 20,
                                      width:
                                          SizeConfig.blockSizeHorizontal * 60,
                                      child: Column(
                                        children: [
                                          Text("Nombre de personne"),
                                          Text(list[index].toString()),
                                          SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    10,
                                            child: CupertinoPicker(
                                              onSelectedItemChanged: (index) {
                                                setState(() {
                                                  this.index = index;
                                                  updateVal(index);
                                                });
                                                print(this.index);
                                              },
                                              useMagnifier: false,
                                              itemExtent:
                                                  SizeConfig.blockSizeVertical *
                                                      5,
                                              looping: true,
                                              children: list
                                                  .map((e) => Center(
                                                        child: Text(
                                                          '${e}',
                                                          style: TextStyle(
                                                              fontSize: SizeConfig
                                                                      .blockSizeVertical *
                                                                  2,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
