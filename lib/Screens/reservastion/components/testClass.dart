import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}


class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _controller = TextEditingController();
  DateTime _dateTime = DateTime.now();
  final dateFormat = DateFormat("EEEE, dd MMM yyyy");
  var availableBookTime = [
  ];
  int _totalBill = 0;
  bool _enableCreateOrderBtn = false;
  var currentTime = "00.00";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            title: Text("Checkout"),
            backgroundColor: Colors.white,
            centerTitle: true,
            foregroundColor: Colors.white,
          ),
          SliverPadding(
            padding:
            const EdgeInsets.only(right: 24, left: 24, bottom: 24, top: 8),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Venue Name",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/icons/pin.png",
                              width: 24,
                              height: 24,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text("", ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Pick a date",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          _selectDate();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.blue,
                              borderRadius:
                              BorderRadius.circular(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.date_range_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                _dateTime == null
                                    ? "date not selected.."
                                    : dateFormat.format(_dateTime).toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Pick a Time",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ])),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 0),
            blurRadius: 10,
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Total:",
                ),
                Text(
                  "Rp $_totalBill",
                ),
              ],
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 45),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(10))),
                  onPressed: !_enableCreateOrderBtn
                      ? null
                      : () {
                    List<String> selectedTime = [];
                    for (int i = 0; i < availableBookTime.length; i++) {
                      if (availableBookTime[i].value) {
                        selectedTime.add(availableBookTime[i].title);
                      }
                    }
                  },
                  child: Text(
                    "Create Order",
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      margin: const EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectDate() async {
    await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 6))
        .then((value) {
      setState(() {
        _dateTime = value!;
      });
    });
  }
}
