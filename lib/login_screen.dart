import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/login/login_bloc.dart';
import 'package:ots_pocket/bloc/login/login_event.dart';
import 'package:ots_pocket/bloc/login/login_state.dart';
import 'package:ots_pocket/home_screen.dart';
import 'package:ots_pocket/models/login_model.dart';
import 'package:ots_pocket/registration_screen.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/email_text_from_field.dart';
import 'package:ots_pocket/widget_util/image_util.dart';
import 'package:ots_pocket/widget_util/password_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  //for enable and disable the login button based on contains in test from fields
  bool isEmailTextFormFieldNotEmpty = false;
  bool isPasswordTextFormFieldNotEmpty = false;

  @override
  void initState() {
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
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          return AppIndicator.onLoading(context);
        } else if (state is LoginSuccessState) {
          AppIndicator.popDialogContext();
          log("LoginSuccessState");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (state is LoginFailedState) {
          AppIndicator.popDialogContext();
          log("LoginFailedState");
          showAlertPopUpForErrorMsg(
            context: context,
            title: "Login Failed",
            errorMsg: "${state.errorMsg}",
            onClickOk: () {
              Navigator.pop(context);
            },
          );
        } else {}
      },
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.95), BlendMode.hardLight),
              image: const AssetImage("asset/images/background_image.jpeg"),
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 90.0, bottom: 32.0, left: 32.0, right: 32.0),
                  child: Form(
                    key: loginFormKey,
                    child: Column(
                      children: [
                        const Center(
                            child: ImageUtil(
                          width: 200.0,
                          height: 120.0,
                          path: "asset/images/clientlogo.png",
                        )),
                        const SizedBox(
                          height: 0.0,
                        ),
                        const Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w700),
                        ),
                        // const SizedBox(
                        //   height: 8.0,
                        // ),
                        // const Text(
                        //   "Users Login Page",
                        //   style: TextStyle(
                        //       fontSize: 13.0,
                        //       color: Color(0xFF717171),
                        //       fontWeight: FontWeight.w400),
                        // ),
                        const SizedBox(
                          height: 28.0,
                        ),
                        EmailTextFromField(emailController: emailController),
                        const SizedBox(
                          height: 32.0,
                        ),
                        PasswordTextFormField(
                          passwordController: passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forget Password?",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color(0xFF157B4F),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 18.0,
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold),
                            minimumSize: const Size.fromHeight(48.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0)),
                            shadowColor: Color(0xFF157B4F),
                          ),
                          onPressed: (isEmailTextFormFieldNotEmpty &&
                                  isPasswordTextFormFieldNotEmpty)
                              ? () {
                                  validate();
                                }
                              : null,
                          child: const Text(
                            "Login",
                          ),
                        ),
                        const SizedBox(
                          height: 48.0,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 32.0, right: 32.0),
                          child: Row(children: const [
                            Expanded(
                              flex: 5,
                              child: Divider(
                                  color: Color(0xFFD4D4D8), thickness: 1.0),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Text(
                                "OR",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF717171),
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              flex: 5,
                              child: Divider(
                                  color: Color(0xFFD4D4D8), thickness: 1.0),
                            )
                          ]),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        RichText(
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: "Don't have an account yet? ",
                              style: TextStyle(
                                  fontSize: 13.0,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w400),
                            ),
                            TextSpan(
                                text: "Register Now",
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF157B4F),
                                    fontWeight: FontWeight.w400),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegistrationScreen()),
                                      (route) => false,
                                    );
                                  }),
                          ]),
                        ),
                      ],
                    ),
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
    if (loginFormKey.currentState!.validate()) {
      log("selectBranchController ${emailController.text}");
      log("selectBranchController ${passwordController.text}");

      Login loginDetails = Login(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      BlocProvider.of<LoginBloc>(context)
          .add(LoadingLoginEvent(loginDetails: loginDetails));
    }
  }
}
