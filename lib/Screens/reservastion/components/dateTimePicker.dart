import 'package:animations/animations.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goresto/size_config.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late double _height;
  late double _width;

  late String _setTime, _setDate;

  late String _hour, _minute, _time;

  late String dateTime;

  DateTime? selectedDate ;

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

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
        _dateController.text = DateFormat.yMd().format(picked);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = "Date de reservation";

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
      super.dispose();
      _dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dateTime = DateFormat.yMd().format(DateTime.now());
    return Container(
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 80,
                height: SizeConfig.blockSizeVertical * 7,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _dateController,
                  onSaved: (val) {
                    _setDate = val!;
                  },
                  decoration: InputDecoration(
                      disabledBorder:
                      UnderlineInputBorder(borderSide: BorderSide.none),
                      // labelText: 'Time',
                    prefixIcon: Icon(Icons.calendar_month)
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}