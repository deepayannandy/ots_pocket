import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_state.dart';
import 'package:ots_pocket/bloc/equipment/add_new_equipment/add_new_equipment_bloc.dart';
import 'package:ots_pocket/bloc/equipment/equpments_event.dart';
import 'package:ots_pocket/models/customer_model.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/widget_util/add_name_text_form_field.dart';
import 'package:ots_pocket/widget_util/address_text_form_field.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/contactperson_text_form_field.dart';
import 'package:ots_pocket/widget_util/email_text_from_field.dart';
import 'package:ots_pocket/widget_util/phone_text_form_field.dart';
import 'package:ots_pocket/widget_util/quantity_text_form_field.dart';
import 'package:ots_pocket/widget_util/selectCustomer_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';

import 'main.dart';

class AddCustomer extends StatefulWidget {
  final String? branchid;
  const AddCustomer({@required this.branchid, Key? key}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final TextEditingController customerController = TextEditingController();
  final TextEditingController contactpersoncontroller = TextEditingController();
  final TextEditingController contactcontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();

  bool isloading = false;
  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;
  bool isnameControllerFormFieldNotEmpty = false;

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
            "Add New " + "Client",
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
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: Text(
                            //     "Cost Center: " + widget.branchid.toString(),
                            //     style: TextStyle(
                            //       color: Color(0xFF000000),
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 18.0,
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            CustomerTextFormField(
                              customerController: customerController,
                              hints: [],
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
    CustomerDetails newclient = CustomerDetails(
        Customer: customerController.text,
        contact: contactcontroller.text,
        contactperson: contactpersoncontroller.text,
        email: emailcontroller.text,
        address: addresscontroller.text);
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/customer/');
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
}
