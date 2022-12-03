import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ots_pocket/home_screen.dart';
import 'package:ots_pocket/login_screen.dart';
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/widget_util/image_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? isOnBoardingScreenLaunch;
  String? token;

  @override
  void initState() {
    _navigationToLoginScreen();
    super.initState();
  }

  _navigationToLoginScreen() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    // isOnBoardingScreenLaunch =
    //     await appStorage?.retrieveEncryptedData('isOnBoardingScreenLaunch');
    token = await appStorage?.retrieveEncryptedData('token');
    print(token.toString());
    (token != null)
        ? Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()))
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print("h" + height.toString() + "w" + width.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: ((height / 2) - (height / 3)),
              child: Image.asset(
                "asset/images/flag.png",
                fit: BoxFit.contain,
                width: 360,
              )),
          Positioned(
            top: ((height / 2) - 100),
            //left: width / 16,
            child: ImageUtil(
              width: 350.0,
              height: 250.0,
              path: "asset/images/splash.gif",
            ),
          )
        ],
      ),
    );
  }
}
