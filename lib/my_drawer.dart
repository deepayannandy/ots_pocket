import 'package:flutter/material.dart';
import 'package:ots_pocket/login_screen.dart';
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_confirmation.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.redAccent.withOpacity(0.7),
            Colors.yellow,
            Colors.blue,
            Colors.purple
          ],
          stops: [0.1, 0.5, 0.8, 0.9],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        )),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Mohammad Sonu",
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "msonu1@gmail.com",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color(0xFF157B4F),
                child: Text(
                  "MS",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
              title: Text(
                "QR Code",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.black),
              title: Text(
                "Customer Support",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text(
                "Logout",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                showAlertPopUpForConfirmation(
                    context: context,
                    title: "",
                    confirmationMsg: "Are you sure you want to logout?",
                    buttonTextForOk: "LOGOUT",
                    buttonOkTextColor: Color(0xFF157B4F),
                    buttonOkTextSize: 14.0,
                    buttonTextForCancel: "Cancel",
                    buttonCancelTextColor: Color(0xFF717171),
                    buttonCancelTextSize: 14.0,
                    onClickOk: () {
                      Navigator.pop(context);
                      appStorage?.deleteEncryptedData('token');
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(pageBuilder: (BuildContext context,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return LoginScreen();
                          }, transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return new SlideTransition(
                              position: new Tween<Offset>(
                                      begin: const Offset(1.0, 0.0),
                                      end: Offset.zero)
                                  .animate(animation),
                              child: child,
                            );
                          }),
                          (route) => false);
                    },
                    onClickCancel: () {
                      Navigator.pop(context);
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
