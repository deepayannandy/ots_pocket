import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_state.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/home_screen.dart';
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/models/customer_model.dart';
import 'package:ots_pocket/models/po_model.dart';
import 'package:ots_pocket/models/wo_model.dart';
import 'package:ots_pocket/widget_util/address_text_form_field.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/contactperson_text_form_field.dart';
import 'package:ots_pocket/widget_util/email_text_from_field.dart';
import 'package:ots_pocket/widget_util/jd_text_form_field%20copy.dart';
import 'package:ots_pocket/widget_util/jt_text_form_field.dart';
import 'package:ots_pocket/widget_util/phone_text_form_field.dart';
import 'package:ots_pocket/widget_util/po_text_form_field.dart';
import 'package:ots_pocket/widget_util/selectCustomer_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_branch_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_job_type_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';

import 'models/csr_model.dart';

class createWo extends StatefulWidget {
  final WODetails? newWo;
  final CSRDetails? csr;
  const createWo({required this.newWo, required this.csr, Key? key})
      : super(key: key);

  @override
  State<createWo> createState() => _createWoState();
}

class _createWoState extends State<createWo> {
  // final TextEditingController quantityController = TextEditingController();
  // final TextEditingController branchController = TextEditingController();
  // final TextEditingController customerController = TextEditingController();
  // final TextEditingController jobtypecontroller = TextEditingController();
  // final TextEditingController contactpersoncontroller = TextEditingController();
  // final TextEditingController contactcontroller = TextEditingController();
  // final TextEditingController emailcontroller = TextEditingController();
  // final TextEditingController addresscontroller = TextEditingController();
  // final TextEditingController pocontroller = TextEditingController();
  // final TextEditingController jtcontroller = TextEditingController();
  // final TextEditingController jdcontroller = TextEditingController();

  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  bool isloading = false;

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
          "Review WO",
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
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Text(
                              "Customer Rate Sheet: \n" +
                                  (widget.csr == null
                                      ? "Not Available"
                                      : widget.csr!.cId.toString()),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
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
                              addWo();
                            },
                            child: const Text(
                              "Create WO",
                            ),
                          ),
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

  Future<void> getCustomers() async {
    setState(() {
      isloading = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/customer/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        allcustomers = json
            .decode(response.body)
            .map<CustomerDetails>((json) => CustomerDetails.fromJson(json))
            .toList();
        print("aa" + allcustomers!.length.toString());
        if (allcustomers!.length > 1) {
          for (CustomerDetails customer in allcustomers!) {
            customerdat[customer.Customer!] = customer;
          }
        }

        isloading = false;
      });
    } else {
      print(response.body);
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

  Future<void> addWo() async {
    Fluttertoast.showToast(msg: "Creating new WO#");
    setState(() {
      isloading = true;
    });
    print(widget.newWo!.poID);
    WODetails newWO = WODetails(
        poID: widget.newWo!.poID,
        poName: widget.newWo!.poName,
        JT: widget.newWo!.JT,
        startDate: widget.newWo!.startDate,
        endDate: widget.newWo!.endDate,
        workers: widget.newWo!.workers,
        timecards: [],
        consumeables: widget.newWo!.consumeables,
        equipements: widget.newWo!.equipements,
        rentedEquipements: [],
        branchID: widget.newWo!.branchID,
        managerid: "Admin",
        csrid:
            widget.csr == null ? "Not Available" : widget.csr!.cId.toString());
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/wo/');
    var response =
        await http.post(url, headers: headers, body: jsonEncode(newWO));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Success");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    } else {
      Fluttertoast.showToast(msg: "Fail");
      print(response.body);
    }
    setState(() {
      isloading = false;
    });
  }
}
