import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/timecard_model.dart';
import 'package:ots_pocket/widget_util/End_Time_Form_Field.dart';
import 'package:ots_pocket/widget_util/Start_Time_Form_Field.dart';
import 'package:ots_pocket/widget_util/Travel_Time_Form_Field.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/jt_text_form_field.dart';
import 'package:ots_pocket/widget_util/name_text_form_field.dart';

import 'models/user_details_model.dart';

class AddTimeCardScreen extends StatefulWidget {
  final String? userid;
  final String? costcenter;
  final bool? ismanager;
  const AddTimeCardScreen(
      {required this.userid,
      required this.costcenter,
      required this.ismanager,
      Key? key})
      : super(key: key);

  @override
  State<AddTimeCardScreen> createState() => _AddTimeCardScreenState();
}

class _AddTimeCardScreenState extends State<AddTimeCardScreen> {
  bool isLoaded = true;
  TimeOfDay? Time;
  TimeOfDay? StartPicked;
  TimeOfDay? EndPicked;
  UserDetails? myDetails;
  double st = 0.0;
  double ot = 0.0;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController taskcontroller = TextEditingController();
  final TextEditingController starttime =
      TextEditingController(text: "08 : 00");
  final TextEditingController endtime = TextEditingController(text: "17 : 00");
  final TextEditingController traveltime = TextEditingController(text: "0");

  @override
  void initState() {
    getPO();
    Time = TimeOfDay.now();
    super.initState();
  }

  Future refresh() async {
    getPO();
  }

  String timeformater(TimeOfDay time) {
    String timeinstring = time.hour.toString().padLeft(2, "0") +
        " : " +
        time.minute.toString().padLeft(2, "0");

    return timeinstring;
  }

  void calculatetime(TimeOfDay starttime, TimeOfDay endtime) {
    double _timeDiff = 0;
    if (endtime.hour < starttime.hour) {
      double _doubleYourTime =
          starttime.hour.toDouble() + (starttime.minute.toDouble() / 60);
      double _doubleNowTime =
          endtime.hour.toDouble() + (endtime.minute.toDouble() / 60);

      _timeDiff = (_doubleYourTime - _doubleNowTime) - 24;
    } else {
      double _doubleYourTime =
          endtime.hour.toDouble() + (endtime.minute.toDouble() / 60);
      double _doubleNowTime =
          starttime.hour.toDouble() + (starttime.minute.toDouble() / 60);

      _timeDiff = _doubleYourTime - _doubleNowTime;
    }
    double hr = double.parse(_timeDiff.toDouble().toStringAsFixed(2));
    if (hr > 8)
      ot = double.parse((hr - 8).toStringAsFixed(2));
    else
      ot = 0.0;
    st = hr - ot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text(
          "Add Time Cards",
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Color(0xFF157B4F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isLoaded
          ? AppIndicator.circularProgressIndicator
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                children: [
                  NameTextFormField(nameController: namecontroller),
                  SizedBox(
                    height: 15,
                  ),
                  JTTextFormField(
                    jtController: taskcontroller,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Start_Time(
                          nameController: starttime,
                        ),
                      ),
                      TextButton(
                          onPressed: () async {
                            StartPicked = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (StartPicked != null) {
                              setState(() {
                                starttime.text = timeformater(
                                    StartPicked!); //set the value of text field.
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                          child: Icon(
                            Icons.timer,
                            size: 30,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: End_Time(
                        nameController: endtime,
                      )),
                      TextButton(
                          onPressed: () async {
                            EndPicked = await showTimePicker(
                              initialTime: TimeOfDay.now(),
                              context: context,
                            );

                            if (EndPicked != null) {
                              setState(() {
                                endtime.text = timeformater(
                                    EndPicked!); //set the value of text field.
                                calculatetime(StartPicked!, EndPicked!);
                              });
                            } else {
                              print("Time is not selected");
                            }
                          },
                          child: Icon(
                            Icons.timer,
                            size: 30,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Travel_Time(nameController: traveltime),
                  SizedBox(
                    height: 20,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'ST: ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: st.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' Hours\t\t'),
                        TextSpan(
                          text: 'OT: ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: ot.toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' Hours'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 26.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold),
                      minimumSize: const Size.fromHeight(48.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      surfaceTintColor: Color(0xFF157B4F),
                    ),
                    onPressed: () {
                      if (st > 0)
                        addTC();
                      else
                        Fluttertoast.showToast(
                            msg: "Please Select the Start and End Time");
                    },
                    child: const Text(
                      "Add",
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
      drawer: MyDrower1(),
    );
  }

  Widget getAddressCard(String Branch) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Cost Center: " + Branch,
        style: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }

  Future<void> getPO() async {
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('localhost:6622', '/api/user/mydata/me');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        myDetails = UserDetails.fromJson(jsonDecode(response.body));
        // Fluttertoast.showToast(msg: myDetails!.fullname.toString());
        namecontroller.text = myDetails!.fullname.toString();
        taskcontroller.text = myDetails!.projid.toString().length > 0
            ? myDetails!.projid.toString()
            : "Bench Time";
        isLoaded = false;
      });
    } else {}
  }

  Future<Map<String, String>> _getHeaderConfig() async {
    String? token = await appStorage?.retrieveEncryptedData('token');
    Map<String, String> headers = {};
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers.putIfAbsent("auth-token", () => '$token');
    }
    return headers;
  }

  Future<void> addTC() async {
    Fluttertoast.showToast(msg: "Creating new PO#");
    setState(() {
      isLoaded = true;
    });
    TimecardData newCard = TimecardData(
      empid: myDetails!.sId,
      empname: myDetails!.fullname,
      st: st,
      ot: ot,
      tt: traveltime.text.toString(),
      starttime: starttime.text.toString(),
      endtime: endtime.text.toString(),
      wo: taskcontroller.text.toString(),
      submitdate: DateTime.now().toString(),
      shift: "day",
    );
    var headers = await _getHeaderConfig();
    var url = Uri.http('localhost:6622', '/api/timecard/');
    var response =
        await http.post(url, headers: headers, body: jsonEncode(newCard));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Success");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Fail");
      print(response.body);
    }
    setState(() {
      isLoaded = false;
    });
  }
}
