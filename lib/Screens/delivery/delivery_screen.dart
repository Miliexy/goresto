import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/Screens/reservastion/components/checkout_detaills_screen.dart';
import 'package:intl/intl.dart';
import '../../../constansts.dart';
import '../../../size_config.dart';

class DeliveryScreenDetails extends StatefulWidget {
  const DeliveryScreenDetails({Key? key}) : super(key: key);

  @override
  State<DeliveryScreenDetails> createState() => _DeliveryScreenDetails();
}

class _DeliveryScreenDetails extends State<DeliveryScreenDetails> {
  List<int> list = List<int>.generate(20, (index) => index + 1);

  int index = 0;
  int value = 1;
  bool isDisabled = false;
  late TimeOfDay selectedTime;
  late DateTime selectedDate;
  TextEditingController _timeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _peopleController = TextEditingController();
  FixedExtentScrollController _pickerController = FixedExtentScrollController();

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
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? SizedBox(),
        );
      },
    );
    if (timeOfDay != null) {
      setState(() {
        _selectedTime = timeOfDay;
        _timeController.text = DateFormat("HH:mm").format(
            DateTime(2019, 08, 1, _selectedTime.hour, _selectedTime.minute));
      });
    }
  }

  void removePerson() {
    if (value == 1) {
      setState(() {
        isDisabled = true;
      });
      return;
    }
    if (value > 1) {
      setState(() {
        isDisabled = false;
        value--;
      });
    }
  }

  void addPerson() {
    setState(() {
      value++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    _dateController.text = "Date de reservation";
    _peopleController.text = value.toString();
    _timeController.text = "Heure de reservation";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7E7E7),
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
          ScrollConfiguration(
            behavior:
            ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Padding(
                  padding:
                  EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                  child: SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 30,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 90,
                                child: Center(
                                    child: TextFormField(
                                      showCursor: false,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.calendar_month_outlined,
                                        ),
                                      ),
                                      keyboardType: TextInputType.none,
                                      controller: _dateController,
                                      onTap: () {
                                        _selectDate(context);
                                      },
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
                                        prefixIcon: Icon(
                                          Icons.access_time_rounded,
                                        ),
                                      ),
                                      keyboardType: TextInputType.none,
                                      showCursor: false,
                                      controller: _timeController,
                                      onTap: () {
                                        _selectTime(context);
                                      },
                                    )),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Container(
                                width: SizeConfig.blockSizeHorizontal * 90,
                                child: Row(
                                  children: [
                                    Text(
                                      "Nombre de Personne",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    Spacer(),
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                        BorderRadius.circular(100),
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        onTap: () {
                                          removePerson();
                                        },
                                        child: Icon(Icons.remove,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Text(
                                      value.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius:
                                        BorderRadius.circular(100),
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        onTap: () {
                                          addPerson();
                                        },
                                        child: Icon(Icons.add,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                SizedBox(
                    height: SizeConfig.blockSizeVertical * 35,
                    child: Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.blockSizeHorizontal * 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal * 5),
                        child: Column(
                          children: [
                            ListTile(
                              title: Center(
                                  child: Text('User Details',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge)),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Full Name",
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.phone)),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r"[0-9]")),
                                      ],
                                      validator: (value) {
                                        print(value);
                                        if (!value!.isValidPhone) print("Errors");
                                        return value;
                                      },
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Email address",
                                          prefixIcon: Icon(Icons.email)),
                                      validator: (value) {
                                        print(value);
                                        if (!value!.isValidPhone) print("Errors");
                                        return value;
                                      },
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CheckoutDetailsScreen(
                            timeController: _timeController,
                            dateController: _dateController,
                            value: value,
                          ),
                        ));
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

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required TextEditingController dateController,
    required this.value,
    required TextEditingController timeController,
  })  : _dateController = dateController,
        _timeController = timeController,
        super(key: key);

  final TextEditingController _dateController;
  final int value;
  final TextEditingController _timeController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: SizeConfig.blockSizeVertical * 35,
        child: Card(
          margin: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                title: Center(
                    child: Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 4),
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
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text(_dateController.text)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.people),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text('${value} Personne')
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time_outlined),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text(_timeController.text)
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            Text("Le cuistot")
                          ],
                        ),
                      ],
                    ),
                    Container(
                        height: SizeConfig.blockSizeVertical * 25,
                        width: SizeConfig.blockSizeHorizontal * 25,
                        decoration: BoxDecoration(),
                        child: Image.asset("assets/images/lecuissot_logo.png"))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

extension ExtString on String {
  bool get isValidPhone {
    final phoneRegExp = RegExp(
        r'^(?:(?:(?:\+|00)212[\s]?(?:[\s]?\(0\)[\s]?)?)|0){1}(?:5[\s.-]?[2-3]|6[\s.-]?[13-9]){1}[0-9]{1}(?:[\s.-]?\d{2}){3}$');
    return phoneRegExp.hasMatch(this);
  }
}
