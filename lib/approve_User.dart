import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/patch_User_details/user_patch_bloc.dart';
import 'package:ots_pocket/bloc/user/patch_User_details/user_patch_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/models/user_approval_details_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/payrateST_text_form_field.dart';
import 'package:ots_pocket/widget_util/salary_text_form_field.dart';

import 'package:ots_pocket/widget_util/select_designation_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';

class UserApproval extends StatefulWidget {
  final UserDetails? selectedUserData;
  final String? pagename;
  const UserApproval(
      {@required this.selectedUserData, @required this.pagename, Key? key})
      : super(key: key);

  @override
  State<UserApproval> createState() => _UserApprovalState();
}

class _UserApprovalState extends State<UserApproval> {
  final TextEditingController selectDesignationController =
      TextEditingController();
  final TextEditingController payrateController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  //for enable and disable the registration button based on contains in test from fields
  bool isSelectDesignationTextFormFieldNotEmpty = false;
  bool ispayrateTextFormFieldNotEmpty = false;
  bool issalaryTextFormFieldNotEmpty = false;

  @override
  void initState() {
    selectDesignationController.addListener(() {
      setState(() {
        isSelectDesignationTextFormFieldNotEmpty =
            selectDesignationController.text.isNotEmpty;
      });
    });
    payrateController.addListener(() {
      setState(() {
        ispayrateTextFormFieldNotEmpty = payrateController.text.isNotEmpty;
      });
    });
    salaryController.addListener(() {
      setState(() {
        issalaryTextFormFieldNotEmpty = salaryController.text.isNotEmpty;
      });
    });
    super.initState();

    if (widget.pagename == "Manage User") {
      selectDesignationController.text = widget.selectedUserData!.desig!;
      payrateController.text = widget.selectedUserData!.payrateST
          .toString()
          .split('numberDecimal:')[1]
          .replaceFirst("}", "");
      salaryController.text = widget.selectedUserData!.salary
          .toString()
          .split('numberDecimal:')[1]
          .replaceFirst("}", "");
    }
  }

  @override
  void dispose() {
    selectDesignationController.dispose();
    payrateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> namepart = widget.selectedUserData!.fullname!.split(" ");

    return BlocListener<UserPatchBloc, UserPatchState>(
      listener: (context, state) {
        if (state is UserPatchLoadingState) {
          return AppIndicator.onLoading(context);
        } else if (state is UserPatchSuccessState) {
          log("UserApproved");
          AppIndicator.popDialogContext();
          ShowToast.message(toastMsg: "User profile approved");
          Navigator.pop(context);
        } else if (state is UserPatchFailedState) {
          log("UserChangesFailedState");
          AppIndicator.popDialogContext();
          showAlertPopUpForErrorMsg(
            context: context,
            title: "Changes Failed",
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
            widget.pagename!,
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
        body: Container(
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: widget.pagename == "Manage User" ? 130 : 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: Text(namepart[0].substring(0, 1) +
                                          namepart[1].substring(0, 1)),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                                child: VerticalDivider(color: Colors.black),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "User Name: \n" +
                                        widget.selectedUserData!.fullname!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "User email: " +
                                        widget.selectedUserData!.email!,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Cost Center: " +
                                        widget.selectedUserData!.empBranch!,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  widget.pagename == "Manage User"
                                      ? (Text(
                                          "Current Payrate: " +
                                              widget.selectedUserData!.payrateST
                                                  .toString()
                                                  .split('numberDecimal:')[1]
                                                  .replaceFirst("}", " USD"),
                                          style: TextStyle(fontSize: 12),
                                        ))
                                      : Container(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  widget.pagename == "Manage User"
                                      ? (Text(
                                          "Current Salary: " +
                                              widget.selectedUserData!.salary
                                                  .toString()
                                                  .split('numberDecimal:')[1]
                                                  .replaceFirst("}", " USD"),
                                          style: TextStyle(fontSize: 12),
                                        ))
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SelectDesignationTextFormField(
                        selectDesignationController:
                            selectDesignationController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      PayrateSTTextFormField(
                        payrateSTNumberController: payrateController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SalaryTextFormField(
                          salaryNumberController: salaryController),
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
                        child: Text(
                          widget.pagename == "User Approval Form"
                              ? "Approve"
                              : "Update",
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
    if (patchFormKey.currentState!.validate()) {
      UserApprovalDetails userdetails = UserApprovalDetails(
          desig: selectDesignationController.text.trim(),
          payrateST: payrateController.text.trim(),
          salary: salaryController.text.trim(),
          sId: widget.selectedUserData?.sId,
          active: true);

      BlocProvider.of<UserPatchBloc>(context)
          .add(UserPatchEvent(approvalDetails: userdetails));
    }
  }

  bool patchButtonActive() {
    if (isSelectDesignationTextFormFieldNotEmpty &&
        (ispayrateTextFormFieldNotEmpty || issalaryTextFormFieldNotEmpty)) {
      return true;
    }
    return false;
  }
}
