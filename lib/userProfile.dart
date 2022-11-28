import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:ots_pocket/login_screen.dart';
import 'package:ots_pocket/main.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_confirmation.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserProfile extends StatefulWidget {
  final UserDetails? loggedinuser;

  const UserProfile({@required this.loggedinuser, Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.grey[900],
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(35),
            child: Container(
              child: Stack(alignment: Alignment.center, children: [
                Positioned(
                  top: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 60,
                    height: 10,
                  ),
                ),
                Positioned(
                    top: -10,
                    right: -20,
                    child: Image.asset(
                      "asset/images/stripe.png",
                      height: 100,
                    )),
                Positioned(
                    top: -20,
                    right: -30,
                    child: Image.asset(
                      "asset/images/stripe.png",
                      height: 100,
                    )),
                Positioned(
                    top: 40,
                    child: Image.asset(
                      "asset/images/clientlogo.png",
                      height: 50,
                    )),
                Positioned(
                  top: 120,
                  child: QrImage(
                    data: widget.loggedinuser!.sId!,
                    size: 180,
                    embeddedImage: AssetImage(
                      "assets/images/userlogo.png",
                    ),
                  ),
                ),
                Positioned(
                    bottom: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: 250,
                      height: 100,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          DefaultTextStyle(
                              child: Text(
                                  "Name : " + widget.loggedinuser!.fullname!),
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 6,
                          ),
                          DefaultTextStyle(
                              child: Text("Designation : " +
                                  widget.loggedinuser!.desig!),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 5,
                          ),
                          DefaultTextStyle(
                              child: Text("Cost Centre : " +
                                  widget.loggedinuser!.empBranch!),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            height: 5,
                          ),
                          DefaultTextStyle(
                              child: Text(
                                  "Contact: " + widget.loggedinuser!.mobile!),
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w700))
                        ],
                      ),
                    ))
              ]),
              height: 450,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      offset: Offset(0, 25),
                      blurRadius: 9,
                      spreadRadius: -10)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold),
                  minimumSize: const Size.fromHeight(48.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  )),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Back",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
