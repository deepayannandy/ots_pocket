import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/adduser_to_wo.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_state.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/csr_model.dart';
import 'package:ots_pocket/models/po_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/models/wo_model.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/jt_text_form_field.dart';
import 'package:ots_pocket/widget_util/selectPO_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_branch_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';

class AddWo extends StatefulWidget {
  final String username;
  const AddWo({required this.username, Key? key}) : super(key: key);

  @override
  State<AddWo> createState() => _AddWoState();
}

class _AddWoState extends State<AddWo> {
  final TextEditingController branchController = TextEditingController();
  final TextEditingController pocontroller = TextEditingController();
  final TextEditingController jtcontroller = TextEditingController();
  final TextEditingController startdate = TextEditingController();
  String message = "";
  DateTime selectedDate = DateTime.now();
  DateTime selectedendDate = DateTime.now();
  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  WODetails newWO = new WODetails();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  bool isloademployee = false;
  bool isloading = true;

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;
  bool isnameControllerFormFieldNotEmpty = false;
  List<PODetails>? allpo;
  List<UserDetails>? allusers;
  List<ConsumeablesDetails>? allconsums;
  Map<String, PODetails> podat = new Map();
  PODetails? selectedpo;

  List<CSRDetails>? clientcsr;
  List<String> selectedusers = [];
  List<List> selectedusersdetails = [];
  List<String> selectedcons = [];

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2099, 8));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2099, 8));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedendDate = picked;
      });
    }
  }

  @override
  void initState() {
    pocontroller.addListener(() {
      if (pocontroller.text.isNotEmpty &&
          podat.keys.contains(pocontroller.text)) {
        selectedpo = podat[pocontroller.text];

        setState(() {
          jtcontroller.text = selectedpo!.JT.toString();
          getcsr(selectedpo!.CustomerID.toString());
        });
      }
    });
    getusers();
    getCustomers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewConsumeableBloc, AddNewConsumeableState>(
      listener: (context, state) {
        if (state is AddNewConsumeableLoadingState) {
          return AppIndicator.onLoading(context);
        } else if (state is AddNewConsumeableSuccessState) {
          log("Manage");
          AppIndicator.popDialogContext();
          ShowToast.message(toastMsg: "Added!");
          Navigator.pop(context);
        } else if (state is AddNewConsumeableFailedState) {
          log("ConsumableChangesFailedState");
          AppIndicator.popDialogContext();
          showAlertPopUpForErrorMsg(
            context: context,
            title: "Update Failed",
            errorMsg: "${state.errorMsg}",
            onClickOk: () {
              Navigator.pop(context);
            },
          );
        } else {}
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          centerTitle: true,
          title: Text(
            "Add New WO",
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
                            SelectBranchTextFormField(
                              selectBranchController: branchController,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            POTextFormField(
                              pocontroller: pocontroller,
                              hints: podat.keys.toList(),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            JTTextFormField(jtController: jtcontroller),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Start Date: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  selectedDate.toString().split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () {
                                    _selectStartDate(context);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "End Date: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  selectedendDate.toString().split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),
                                  onPressed: () async {
                                    _selectEndDate(context);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            const SizedBox(
                              height: 16.0,
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
                              onPressed: patchButtonActive()
                                  ? () {
                                      validate();
                                    }
                                  : null,
                              child: const Text(
                                "Add Employee",
                              ),
                            ),
                            const SizedBox(
                              height: 26.0,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    message,
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 16),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  validate() {
    makewo();
    if (newWO == null) {
      Fluttertoast.showToast(msg: "Please Complete the steps!");
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddEmpWO(
                  csr: clientcsr!.length > 0 ? clientcsr![0] : null,
                  newWo: newWO,
                )));
  }

  bool patchButtonActive() {
    if (true) {
      return true;
    }
  }

  Future<void> getCustomers() async {
    setState(() {
      isloading = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/po/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        allpo = json
            .decode(response.body)
            .map<PODetails>((json) => PODetails.fromJson(json))
            .toList();
        print("aa" + allpo!.length.toString());
        if (allpo!.length > 0) {
          for (PODetails po in allpo!) {
            podat[po.poNumber!] = po;
            print(podat[po.poNumber!]);
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

  showEmployeedata(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 70, 10, 0),
            child: isloademployee
                ? AppIndicator.circularProgressIndicator
                : Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(
                              "Select Employee",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ))
                        ],
                      ),
                      new Divider(
                        color: Colors.black87,
                      ),
                      Expanded(
                          child: ListView.builder(
                              itemCount: allusers!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 2, 4, 2),
                                  child: Container(
                                    child: ListTile(
                                      trailing: IconButton(
                                        icon: selectedusers.contains(
                                                allusers![index]
                                                    .fullname
                                                    .toString())
                                            ? Icon(
                                                Icons.check_box,
                                                color: Colors.green,
                                              )
                                            : Icon(Icons.add_box),
                                        onPressed: () {
                                          setState(() {
                                            selectedusers.contains(
                                                    allusers![index]
                                                        .fullname
                                                        .toString())
                                                ? selectedusers.remove(
                                                    allusers![index]
                                                        .fullname
                                                        .toString())
                                                : selectedusers.add(
                                                    allusers![index]
                                                        .fullname
                                                        .toString());
                                            Navigator.pop(context);
                                          });
                                        },
                                      ),
                                      leading: CircleAvatar(
                                        radius: 20,
                                        child: Text(
                                          allusers![index]
                                              .fullname
                                              .toString()[0],
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: Color(0xFF157B4F),
                                        foregroundColor: Colors.black,
                                      ),
                                      title: Text(
                                        allusers![index].fullname.toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                        color: Color(
                                            0xff13a693), //                   <--- border color
                                        width: 1.0,
                                      ),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0.0, 1.0), //(x,y)
                                          blurRadius: 1.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }))
                    ],
                  ),
          );
        });
  }

  Future<void> getusers() async {
    setState(() {
      isloademployee = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/user/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        allusers = json
            .decode(response.body)
            .map<UserDetails>((json) => UserDetails.fromJson(json))
            .toList();
        isloademployee = false;
      });
    } else {
      print(response.body);
    }
  }

  Future<void> getcsr(String id) async {
    // Fluttertoast.showToast(msg: id);
    setState(() {
      isloademployee = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/csr/' + id);
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        clientcsr = json
            .decode(response.body)
            .map<CSRDetails>((json) => CSRDetails.fromJson(json))
            .toList();
        isloademployee = false;
        if (clientcsr!.length < 1)
          message = "No Customer Rate Sheet Found!";
        else
          message =
              "Rate Sheet Found for " + clientcsr![0].CustomerName.toString();
      });
    } else {
      print(response.body);
    }
  }

  void makewo() {
    // Fluttertoast.showToast(msg: "Creating Wo");
    newWO.poID = podat[pocontroller.text]!.poID;
    newWO.branchID = branchController.text;
    newWO.poName = pocontroller.text;
    newWO.JT = jtcontroller.text;
    newWO.startDate = selectedDate.toString();
    newWO.endDate = selectedendDate.toString();
    print(newWO.toString());
  }
}
