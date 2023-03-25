import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_state.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/models/customer_model.dart';
import 'package:ots_pocket/models/po_model.dart';
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

class AddPo extends StatefulWidget {
  final String username;
  const AddPo({required this.username, Key? key}) : super(key: key);

  @override
  State<AddPo> createState() => _AddPoState();
}

class _AddPoState extends State<AddPo> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController customerController = TextEditingController();
  final TextEditingController jobtypecontroller = TextEditingController();
  final TextEditingController contactpersoncontroller = TextEditingController();
  final TextEditingController contactcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final TextEditingController pocontroller = TextEditingController();
  final TextEditingController jtcontroller = TextEditingController();
  final TextEditingController jdcontroller = TextEditingController();

  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  bool isloading = true;

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;
  bool isnameControllerFormFieldNotEmpty = false;
  List<CustomerDetails>? allcustomers;
  Map<String, CustomerDetails> customerdat = new Map();

  CustomerDetails? selectedcustomer;
  @override
  void initState() {
    customerController.addListener(() {
      if (customerController.text.isNotEmpty &&
          customerdat.keys.contains(customerController.text)) {
        selectedcustomer = customerdat[customerController.text];

        setState(() {
          contactpersoncontroller.text =
              selectedcustomer!.contactperson.toString();
          emailcontroller.text = selectedcustomer!.email.toString();
          contactcontroller.text = selectedcustomer!.contact.toString();
          addresscontroller.text = selectedcustomer!.address.toString();
        });
      }
    });
    getCustomers();
    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    customerController.dispose();
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
            "Add New PO",
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
                            SelectJobTypeTextFormField(
                              selectJobTypeController: jobtypecontroller,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SelectBranchTextFormField(
                              selectBranchController: branchController,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            POFormField(poController: pocontroller),
                            const SizedBox(
                              height: 16.0,
                            ),
                            CustomerTextFormField(
                              customerController: customerController,
                              hints: customerdat.keys.toList(),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            ContactpersonTextFormField(
                              nameController: contactpersoncontroller,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            EmailTextFromField(
                                emailController: emailcontroller),
                            const SizedBox(
                              height: 16.0,
                            ),
                            PhoneTextFormField(
                                phoneNumberController: contactcontroller),
                            const SizedBox(
                              height: 16.0,
                            ),
                            AddressTextFormField(
                              nameController: addresscontroller,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            JTTextFormField(jtController: jtcontroller),
                            const SizedBox(
                              height: 16.0,
                            ),
                            JobDescTextFormField(jdcontroller: jdcontroller),
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
                              onPressed: patchButtonActive()
                                  ? () {
                                      validate();
                                    }
                                  : null,
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
    addPo();
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

  Future<void> addPo() async {
    Fluttertoast.showToast(msg: "Creating new PO#");
    setState(() {
      isloading = true;
    });
    PODetails newpo = PODetails(
      poNumber: pocontroller.text.trim(),
      CustomerID: selectedcustomer!.cId.toString(),
      JD: jdcontroller.text.toString(),
      JT: jtcontroller.text.toString(),
      contact: contactcontroller.text.toString(),
      contactperson: contactpersoncontroller.text.toString(),
      email: emailcontroller.text.toString(),
      address: addresscontroller.text.trim(),
      timestamp: new DateTime.now().toString(),
      branchID: branchController.text.trim(),
      typeofpo: jobtypecontroller.text.toString(),
      managerid: widget.username,
      wos: [],
      deos: [],
    );
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/po/');
    var response =
        await http.post(url, headers: headers, body: jsonEncode(newpo));
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
}
