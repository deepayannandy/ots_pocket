import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/registration/registration_bloc.dart';
import 'package:ots_pocket/bloc/user/registration/registration_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/login_screen.dart';
import 'package:ots_pocket/models/user_registration_model.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/confirm_password_text_form_field.dart';
import 'package:ots_pocket/widget_util/designation_text_form_field.dart';
import 'package:ots_pocket/widget_util/email_text_from_field.dart';
import 'package:ots_pocket/widget_util/image_util.dart';
import 'package:ots_pocket/widget_util/name_text_form_field.dart';
import 'package:ots_pocket/widget_util/password_text_form_field.dart';
import 'package:ots_pocket/widget_util/phone_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_branch_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_designation_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_designationc_cat_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';
import 'package:ots_pocket/widget_util/ssnNew_text_form_firld.dart';
import 'package:ots_pocket/widget_util/ssnNew_text_form_firld_confirm.dart';
import 'package:ots_pocket/widget_util/ssn_text_form_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController selectBranchController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController ssnController1 = TextEditingController();
  final TextEditingController ssnController_1 = TextEditingController();
  final TextEditingController designation = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dCatagoryController =
      TextEditingController(text: "Others");
  final TextEditingController confirmPasswordController =
      TextEditingController();

  GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  //for enable and disable the registration button based on contains in test from fields
  bool isSelectBranchTextFormFieldNotEmpty = false;
  bool isNameTextFormFieldNotEmpty = false;
  bool isPhoneNumberTextFormFieldNotEmpty = false;
  bool isEmailTextFormFieldNotEmpty = false;
  bool isSSNTextFormFieldNotEmpty1 = false;
  bool isSSNTextFormFieldNotEmpty_1 = false;
  bool isPasswordTextFormFieldNotEmpty = false;
  bool isConfirmPasswordTextFormFieldNotEmpty = false;
  bool isDesignation = false;
  bool isdCatagoryController = false;

  @override
  void initState() {
    selectBranchController.addListener(() {
      setState(() {
        isSelectBranchTextFormFieldNotEmpty =
            selectBranchController.text.isNotEmpty;
      });
    });
    nameController.addListener(() {
      setState(() {
        isNameTextFormFieldNotEmpty = nameController.text.isNotEmpty;
      });
    });
    dCatagoryController.addListener(() {
      setState(() {
        isdCatagoryController = dCatagoryController.text.isNotEmpty;
      });
    });
    phoneNumberController.addListener(() {
      setState(() {
        isPhoneNumberTextFormFieldNotEmpty =
            phoneNumberController.text.isNotEmpty;
      });
    });
    designation.addListener(() {
      setState(() {
        isDesignation = designation.text.isNotEmpty;
      });
    });
    ssnController1.addListener(() {
      setState(() {
        isSSNTextFormFieldNotEmpty1 = ssnController1.text.isNotEmpty;
      });
    });
    ssnController_1.addListener(() {
      setState(() {
        isSSNTextFormFieldNotEmpty_1 = ssnController_1.text.isNotEmpty;
      });
    });
    emailController.addListener(() {
      setState(() {
        isEmailTextFormFieldNotEmpty = emailController.text.isNotEmpty;
      });
    });
    passwordController.addListener(() {
      setState(() {
        isPasswordTextFormFieldNotEmpty = passwordController.text.isNotEmpty;
      });
    });
    confirmPasswordController.addListener(() {
      setState(() {
        isConfirmPasswordTextFormFieldNotEmpty =
            confirmPasswordController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    selectBranchController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    ssnController1.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    designation.dispose();
    dCatagoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserRegistrationBloc, UserRegistrationState>(
      listener: (context, state) {
        if (state is UserRegistrationLoadingState) {
          return AppIndicator.onLoading(context);
        } else if (state is UserRegistrationSuccessState) {
          log("UserRegistrationSuccessState");
          AppIndicator.popDialogContext();
          ShowToast.message(toastMsg: "User Registration Successfully");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else if (state is UserRegistrationFailedState) {
          log("UserRegistrationFailedState");
          AppIndicator.popDialogContext();
          showAlertPopUpForErrorMsg(
            context: context,
            title: "Registration Failed",
            errorMsg: "${state.errorMsg}",
            onClickOk: () {
              Navigator.pop(context);
            },
          );
        } else {}
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            centerTitle: true,
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.95), BlendMode.hardLight),
                image: AssetImage("asset/images/background_image.jpeg"),
                fit: BoxFit.fill),
          ),
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
                    top: 0.0, bottom: 32.0, left: 32.0, right: 32.0),
                child: Form(
                  key: registrationFormKey,
                  child: Column(
                    children: [
                      const Center(
                          child: ImageUtil(
                        width: 200.0,
                        height: 120.0,
                        path: "asset/images/clientlogo.png",
                      )),
                      const SizedBox(
                        height: 00.0,
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 26.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w700),
                      ),
                      // const SizedBox(
                      //   height: 8.0,
                      // ),
                      // const Text(
                      //   "to OTS-Pocket",
                      //   style: TextStyle(
                      //       fontSize: 13.0,
                      //       color: Color(0xFF717171),
                      //       fontWeight: FontWeight.w400),
                      // ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      SelectBranchTextFormField(
                        selectBranchController: selectBranchController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SelectDesignationCatTextFormField(
                        selectDesignationController: dCatagoryController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      dCatagoryController.text == "Others"
                          ? DesignationTextFormField(
                              designationController: designation,
                            )
                          : SelectDesignationTextFormField(
                              catagory: dCatagoryController.text,
                              selectBranchController: designation),
                      const SizedBox(
                        height: 16.0,
                      ),

                      NameTextFormField(
                        nameController: nameController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      EmailTextFromField(
                        emailController: emailController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      PhoneTextFormField(
                        phoneNumberController: phoneNumberController,
                      ),

                      const SizedBox(
                        height: 16.0,
                      ),
                      SsnTextFormField(ssnController: ssnController1),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SsnNewConfirmTextFormField(
                        ssnController1: ssnController_1,
                        ssnController_1: ssnController1,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      PasswordTextFormField(
                        passwordController: passwordController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ConfirmPasswordTextFormField(
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
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
                        onPressed: registrationButtonActive()
                            ? () {
                                validate();
                              }
                            : null,
                        child: const Text(
                          "Register",
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                              text: "Login",
                              style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xFF157B4F),
                                  fontWeight: FontWeight.w400),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                    (route) => false,
                                  );
                                },
                            ),
                          ],
                        ),
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
    if (registrationFormKey.currentState!.validate()) {
      log("selectBranchController ${selectBranchController.text}");
      log("selectBranchController ${nameController.text}");
      log("selectBranchController ${phoneNumberController.text}");
      log("selectBranchController ${emailController.text}");
      log("selectBranchController ${ssnController1.text}");
      log("selectBranchController ${passwordController.text}");
      log("selectBranchController ${confirmPasswordController.text}");

      UserRegistration userDetails = UserRegistration(
        empBranch: selectBranchController.text.trim(),
        fullname: nameController.text.trim(),
        mobile: phoneNumberController.text.trim(),
        email: emailController.text.trim(),
        ssn: ssnController_1.text.trim(),
        password: passwordController.text.trim(),
        desig: designation.text.trim(),
        projid: "",
        desigcatagory: dCatagoryController.text.trim(),
      );

      BlocProvider.of<UserRegistrationBloc>(context)
          .add(UserRegistrationEvent(userDetails: userDetails));
    }
  }

  bool registrationButtonActive() {
    if (isSelectBranchTextFormFieldNotEmpty &&
        isNameTextFormFieldNotEmpty &&
        isPhoneNumberTextFormFieldNotEmpty &&
        isEmailTextFormFieldNotEmpty &&
        isSSNTextFormFieldNotEmpty_1 &&
        isDesignation &&
        isSSNTextFormFieldNotEmpty1 &&
        isPasswordTextFormFieldNotEmpty &&
        isConfirmPasswordTextFormFieldNotEmpty) {
      return true;
    }
    return false;
  }
}
