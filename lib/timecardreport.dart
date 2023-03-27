import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/etc_model.dart';
import 'package:ots_pocket/pdf_methods.dart';
import 'package:ots_pocket/time_card/time_card_pdf.dart';
import 'package:ots_pocket/widget_util/End_Time_Form_Field.dart';
import 'package:ots_pocket/widget_util/Start_Time_Form_Field.dart';

import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/selectEmployee_text_form_field.dart';

import 'daily_customer_timesheet/daily_customer_timesheet_pdf.dart';
import 'models/paycycle_model.dart';
import 'models/user_details_model.dart';

class EmpTimeCardReport extends StatefulWidget {
  final String? userid;
  final String? costcenter;
  final bool? ismanager;
  const EmpTimeCardReport(
      {required this.userid,
      required this.costcenter,
      required this.ismanager,
      Key? key,
      String? username})
      : super(key: key);

  @override
  State<EmpTimeCardReport> createState() => _EmpTimeCardReportState();
}

class _EmpTimeCardReportState extends State<EmpTimeCardReport> {
  bool isLoaded = false;
  PayCycle? paycycle;
  ETCModel? etsdata;
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController startdate = TextEditingController(text: "");
  final TextEditingController enddate = TextEditingController(text: "");
  String empid = "";
  List<UserDetails>? employees;
  Map userdata = new Map();
  @override
  void initState() {
    super.initState();
    namecontroller.addListener(
      () => {
        if (userdata.keys.contains(namecontroller.text))
          {
            // Fluttertoast.showToast(msg: "Get Id"),
            empid = userdata[namecontroller.text]
          }
      },
    );
    getPC();
    getemployee();
  }

  Future refresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text(
          "Employee Timecard",
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
                  EmployeeTextFormField(
                    customerController: namecontroller,
                    hints: userdata.keys.toList().cast(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(child: Start_Time(nameController: startdate)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child: End_Time(nameController: enddate)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.date_range))
                    ],
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
                      backgroundColor: Color(0xFF157B4F),
                    ),
                    onPressed: () {
                      if (empid.length > 0) {
                        Fluttertoast.showToast(msg: "Lets find");
                        getETS();
                      } else
                        Fluttertoast.showToast(
                            msg: "Please Select the Employee Name");
                    },
                    child: const Text(
                      "Generate Report",
                    ),
                  ),
                ],
              ),
            ),
      drawer: MyDrower1(),
    );
  }

  Future<void> getPC() async {
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/paycycle/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        paycycle = PayCycle.fromJson(jsonDecode(response.body));
        startdate.text = paycycle!.startdate.toString();
        enddate.text = paycycle!.enddate.toString();
        isLoaded = false;
      });
    } else {}
  }

  Future<void> getETS() async {
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http(
        '54.160.215.70:6622',
        '/api/report/ets/' +
            empid +
            "&" +
            namecontroller.text.trim() +
            "&" +
            startdate.text.trim() +
            "&" +
            enddate.text.trim());
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        etsdata = ETCModel.fromJson(jsonDecode(response.body));
        Fluttertoast.showToast(msg: etsdata.toString());
        isLoaded = false;
      });
      final pdfFile = await TimeCardPdf.generate(etsdata!);
      PdfMethods.openFile(pdfFile);
    } else {
      Fluttertoast.showToast(msg: response.body);
    }
  }

  Future<void> getemployee() async {
    // Fluttertoast.showToast(msg: "Fetching user data");
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    // Fluttertoast.showToast(msg: widget.username.toString());
    var url = Uri.http('54.160.215.70:6622', '/api/user/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        employees = json
            .decode(response.body)
            .map<UserDetails>((json) => UserDetails.fromJson(json))
            .toList();
        // Fluttertoast.showToast(msg: _timecard!.length.toString());
        // Fluttertoast.showToast(msg: "get" + _allpo.toString());
        userdata.clear();
        employees!.forEach((element) {
          userdata[element.fullname] = element.sId;
        });
        // Fluttertoast.showToast(msg: userdata.length.toString());
        isLoaded = false;
      });
    } else {
      Fluttertoast.showToast(msg: response.body);
    }
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
}
