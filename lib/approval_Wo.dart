import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/home_screen.dart';
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/models/customer_model.dart';
import 'package:ots_pocket/models/wo_model.dart';
import 'package:ots_pocket/pdf_methods.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/remarks_text_form_field.dart';
import 'daily_customer_timesheet/daily_customer_timesheet_pdf.dart';
import 'models/csr_model.dart';
import 'models/daily_Customer_sheet.dart';

class ApproveWo extends StatefulWidget {
  final WODetails? newWo;
  const ApproveWo({required this.newWo, Key? key}) : super(key: key);

  @override
  State<ApproveWo> createState() => _ApproveWoState();
}

class _ApproveWoState extends State<ApproveWo> {
  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);
  bool managerapproval = false;
  final TextEditingController remarks = TextEditingController();

  bool isloading = false;
  List<DailyCustomerSheet> allsheets = [];

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;
  bool isnameControllerFormFieldNotEmpty = false;
  List<CustomerDetails>? allcustomers;
  Map<String, CustomerDetails> customerdat = new Map();

  CustomerDetails? selectedcustomer;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        title: Text(
          "WO Details",
          style: TextStyle(fontSize: 25, color: Colors.black87),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: isloading
          ? AppIndicator.circularProgressIndicator
          : Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(),
              child: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, bottom: 32.0, left: 32.0, right: 32.0),
                    child: Form(
                      key: patchFormKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Cost Center: " +
                                  widget.newWo!.branchID.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "PO#: " + widget.newWo!.poName.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Task: " + widget.newWo!.JT.toString(),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Start Date: " +
                                  widget.newWo!.startDate
                                      .toString()
                                      .split(" ")[0],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "End Date: " +
                                  widget.newWo!.endDate
                                      .toString()
                                      .split(" ")[0],
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          //   child: Text(
                          //     "Customer Rate Sheet: \n" +
                          //         (widget.csr == null
                          //             ? "Not Available"
                          //             : widget.csr!.cId.toString()),
                          //     style: TextStyle(fontSize: 18),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                            child: Text(
                              "Selected Employees",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Table(
                              columnWidths: const {
                                0: FlexColumnWidth(2),
                                1: FlexColumnWidth(3),
                              },
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1.5),
                              children: const [
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Employee",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Role",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                              ]),
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(3),
                            },
                            border: TableBorder.all(
                                color: Colors.black45, width: 1.5),
                            children: [
                              for (var item in widget.newWo!.workers!.toList())
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item[1],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item[3],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                            child: Text(
                              "Selected Consumables",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1.5),
                              children: const [
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Quantity",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                              ]),
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(1),
                            },
                            border: TableBorder.all(
                                color: Colors.black45, width: 1.5),
                            children: [
                              for (var item
                                  in widget.newWo!.consumeables!.toList())
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item[2],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item[1],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                            child: Text(
                              "Selected Equipments",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Table(
                              columnWidths: const {
                                0: FlexColumnWidth(3),
                                1: FlexColumnWidth(1),
                              },
                              border: TableBorder.all(
                                  color: Colors.black54, width: 1.5),
                              children: const [
                                TableRow(children: [
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(4.0),
                                    child: Text(
                                      "Quantity",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                              ]),
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(3),
                              1: FlexColumnWidth(1),
                            },
                            border: TableBorder.all(
                                color: Colors.black45, width: 1.5),
                            children: [
                              for (var item
                                  in widget.newWo!.equipements!.toList())
                                TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item[2],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      item[1],
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ]),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RemarksForm(
                            jdcontroller: remarks,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Approval Status: " +
                                  (!managerapproval
                                      ? "Pending"
                                      : "Manager Approved"),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: managerapproval
                                      ? Colors.green
                                      : Colors.orange),
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                            onPressed: () async {
                              setState(() {
                                managerapproval = !managerapproval;
                              });
                            },
                            child: const Text(
                              "Manager Approve",
                            ),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),

                          managerapproval
                              ? ElevatedButton(
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
                                  onPressed: () async {
                                    getCustomers();
                                  },
                                  child: const Text(
                                    "Generate Report",
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  bool patchButtonActive() {
    if (true) {
      return true;
    }
    return false;
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

  void getCustomers() async {
    setState(() {
      isloading = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http(
        '54.160.215.70:6622', '/api/report/dts/' + widget.newWo!.woID.toString());
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() async {
        allsheets = json
            .decode(response.body)
            .map<DailyCustomerSheet>(
                (json) => DailyCustomerSheet.fromJson(json))
            .toList();
        if (allsheets.length > 0) {
          setState(() {
            isloading = false;
          });
          final pdfFile = await DailyCustomerTimesheetPdf.generate(
              allsheets[0], remarks.text.toString());
          PdfMethods.openFile(pdfFile);
        }
      });
    } else {
      print(response.body);
    }
  }
}
