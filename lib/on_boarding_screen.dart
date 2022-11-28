import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ots_pocket/login_screen.dart';
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/widget_util/image_util.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    appStorage?.saveEncryptedData('isOnBoardingScreenLaunch', 'YES');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          child: IntroductionScreen(
            globalBackgroundColor: Colors.white,
            pages: [
              getPageViewModel(
                  title: "One app for all your business needs",
                  body:
                      "Mange and track your employee data and tasks from one app.",
                  image: "asset/images/on_boarding_image_1.png"),
              getPageViewModel(
                  title: "Manage TimeSheets",
                  body:
                      "Manage users timesheets and get real time update from the employees using this application.",
                  image: "asset/images/on_boarding_image_2.png"),
              getPageViewModel(
                  title: "Make accounting simple",
                  body:
                      "Manage all the HR related tasks from one app without westing time on huge excel files.",
                  image: "asset/images/on_boarding_image_3.png"),
              getPageViewModel(
                  title: "Save time",
                  body:
                      "Using our OTS Pocket software make all the boring paperworks from one click in your cell phone.",
                  image: "asset/images/on_boarding_image_4.png"),
            ],
            done: getTextButton(buttonText: "Login"),
            next: const Icon(Icons.arrow_forward_ios, color: Color(0xFF157B4F)),
            skip: getTextButton(buttonText: "Skip"),
            onDone: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
            showNextButton: true,
            showSkipButton: true,
            dotsDecorator: getDotsDecorator(),
          ),
        ),
      ),
    );
  }

  PageDecoration getPageDecoration() => const PageDecoration(
        bodyTextStyle: TextStyle(fontSize: 16, color: Color(0xFF717171)),
        titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff13a693)),
      );

  DotsDecorator getDotsDecorator() => DotsDecorator(
        activeColor: const Color(0xFF157B4F),
        size: const Size(5, 5),
        activeSize: const Size(22, 10),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      );

  PageViewModel getPageViewModel(
      {required String title, required String image, required String body}) {
    return PageViewModel(
      title: title,
      image: ImageUtil(
        width: 300.0,
        height: 300.0,
        path: image,
      ),
      body: body,
      decoration: getPageDecoration(),
    );
  }

  Text getTextButton({required String buttonText}) {
    return Text(
      buttonText,
      style: const TextStyle(
          fontSize: 18.0,
          color: Color(0xFF157B4F),
          fontWeight: FontWeight.bold),
    );
  }
}
