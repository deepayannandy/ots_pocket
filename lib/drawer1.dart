import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/user/delete_User/user_delete_bloc.dart';
import 'package:ots_pocket/bloc/user/delete_User/user_delete_state.dart';
import 'package:ots_pocket/bloc/user/get_loggedin_user_details/get_loggedin_user_details_bloc.dart';
import 'package:ots_pocket/bloc/user/get_loggedin_user_details/get_loggedin_user_details_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/contactus.dart';
import 'package:ots_pocket/userProfile.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';

import 'login_screen.dart';
import 'main.dart';

class MyDrower1 extends StatefulWidget {
  @override
  _MyDrower1 createState() => _MyDrower1();
}

class _MyDrower1 extends State<MyDrower1> {
  late GetLoggedinUserDetailsBloc getLoggedinUserDetailsBloc;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetLoggedinUserDetailsBloc>(context)
        .add(GetLoggedinUserDetailsEvent());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLoggedinUserDetailsBloc, GetLoggedinUserDetailsState>(
        builder: (context, state) {
      if (state is GetLoggedinUserDetailsLoadingState) {
        return AppIndicator.circularProgressIndicator;
      } else if (state is GetLoggedinUserDetailsLoadedState) {
        return SafeArea(
          child: Drawer(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListView(
                children: [
                  Stack(alignment: Alignment.center, children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [],
                            ),
                          ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  "asset/images/clientlogo.png",
                                ),
                                fit: BoxFit.fitWidth,
                                opacity: 1,
                              ),
                              shape: BoxShape.rectangle,
                              //color: Color(0xFF157B4F),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.transparent,
                                  offset: const Offset(
                                    -1,
                                    1.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                ),
                              ] //BoxS]
                              ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [],
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: Text(""),
                    ),
                  ]),
                  SizedBox(
                    height: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.profile_circled,
                            color: Colors.black54,
                            size: 20,
                          ),
                          title: Text(
                            "Profile",
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.black54),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserProfile(
                                          loggedinuser: state.userDetails,
                                        )));
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            CupertinoIcons.phone_circle,
                            color: Colors.black54,
                            size: 20,
                          ),
                          title: Text(
                            "Contact Us",
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.black54),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContactUs()));
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.logout_outlined,
                            color: Colors.black54,
                            size: 20,
                          ),
                          title: Text(
                            "Log Out",
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.black54),
                          ),
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                title: const Text('Logout'),
                                content: const Text(
                                    'Are you sure you want to Logout!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      logout(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                  title: Text(
                                "",
                                textScaleFactor: 1,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ))),
                ],
              ),
            ),
          ),
        );
      } else if (state is GetLoggedinUserDetailsErrorState) {
        return Container(
          child: Text("Uder dose not exist!"),
        );
      } else {
        return Container();
      }
    });
  }

  logout(BuildContext context) {
    Navigator.pop(context);
    appStorage?.deleteEncryptedData('token');
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(pageBuilder: (BuildContext context,
            Animation animation, Animation secondaryAnimation) {
          return LoginScreen();
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
                    begin: const Offset(1.0, 0.0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        }),
        (route) => false);
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("This is an alert message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
