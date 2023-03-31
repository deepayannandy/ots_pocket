import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_state.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/certification_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/widget_util/End_Time_Form_Field.dart';
import 'package:ots_pocket/widget_util/Start_Time_Form_Field.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/certificationid_text_form_field.dart';
import 'package:ots_pocket/widget_util/certificationname_text_form_field.dart';
import 'package:ots_pocket/widget_util/designation_catagory_bootom_sheet.dart';
import 'package:ots_pocket/widget_util/instructor_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_designationc_cat_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';

import 'main.dart';

class AddCertification extends StatefulWidget {
  final String? branchid;
  const AddCertification({@required this.branchid, Key? key}) : super(key: key);

  @override
  State<AddCertification> createState() => _AddCertificationState();
}

class _AddCertificationState extends State<AddCertification> {
  final TextEditingController certificatenameController =
      TextEditingController();
  final TextEditingController certificateidController = TextEditingController();
  final TextEditingController employeename = TextEditingController();
  final TextEditingController instructor = TextEditingController();
  final TextEditingController startdate = TextEditingController();
  final TextEditingController enddate = TextEditingController();
  final TextEditingController department = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime selectedendDate = DateTime.now();
  List<String> Employees = [];
  Map empid = new Map();
  List<UserDetails>? allusers;
  bool isloading = false;
  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;
  bool isnameControllerFormFieldNotEmpty = false;

  @override
  void initState() {
    getusers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2099, 8));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startdate.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2099, 8));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedendDate = picked;
        enddate.text = picked.toString().split(" ")[0];
      });
    }
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
            "Add New Certification",
            style: TextStyle(fontSize: 18, color: Colors.black87),
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
        body: isloading == true
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
                        child: Column(
                          children: [
                            TextFormField(
                              onTap: () {
                                branchBottomSheetDialog(
                                  context: context,
                                  onSelectBranchValue: (value) {
                                    employeename.text = value;
                                  },
                                );
                              },
                              controller: employeename,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                hintText: "Employee",
                                labelText: "Select Employee",
                                suffixIcon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            CertificateNameTextFormField(
                              nameController: certificatenameController,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            CertificateidTextFormField(
                              nameController: certificateidController,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SelectDesignationCatTextFormField(
                              selectDesignationController: department,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child:
                                        Start_Time(nameController: startdate)),
                                IconButton(
                                    onPressed: () {
                                      _selectStartDate(context);
                                    },
                                    icon: Icon(Icons.date_range))
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: End_Time(nameController: enddate)),
                                IconButton(
                                    onPressed: () {
                                      _selectEndDate(context);
                                    },
                                    icon: Icon(Icons.date_range))
                              ],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            instructorTextFormField(nameController: instructor),
                            const SizedBox(
                              height: 48.0,
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
                                validate();
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
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  validate() {
    addClient();
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

  Future<void> addClient() async {
    Fluttertoast.showToast(msg: "Uploading ...");
    setState(() {
      isloading = true;
    });
    CertificationModel newclient = CertificationModel(
        CertificateName: certificatenameController.text,
        Certificateid: certificateidController.text,
        employeeid: empid[employeename.text],
        employeename: employeename.text,
        startdate: startdate.text,
        Office: widget.branchid,
        Department: department.text,
        Supervisor: instructor.text,
        enddate: enddate.text);
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/certification/');
    var response =
        await http.post(url, headers: headers, body: jsonEncode(newclient));
    if (response.statusCode == 200 || response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Success");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Fail");
      print(response.body);
    }
    setState(() {
      isloading = false;
    });
  }

  void branchBottomSheetDialog(
      {BuildContext? context, ValueChanged<String>? onSelectBranchValue}) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      context: context!,
      isScrollControlled: true,
      enableDrag: true,
      builder: (builder) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select Employee",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFFD4D4D8),
                    thickness: 1.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: Employees!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                onSelectBranchValue!
                                    .call("${Employees![index]}");
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Text(
                                  "${Employees![index]}",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xFF000000),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xFFD4D4D8),
                              thickness: 1.0,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> getusers() async {
    // Fluttertoast.showToast(msg: "servercall");
    setState(() {
      isloading = true;
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

        allusers!.forEach((element) {
          empid[element.fullname] = element.sId;
          Employees.add(element.fullname.toString());
        });
        isloading = false;
      });
    } else {
      print(response.body);
    }
  }
}
