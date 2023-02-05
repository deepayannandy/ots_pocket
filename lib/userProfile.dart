import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/user/patch_User_details/user_patch_bloc.dart';
import 'login_screen.dart';
import 'models/user_approval_details_model.dart';

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
      child: SingleChildScrollView(
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
                    child: GestureDetector(
                      onTap: () async {
                        if (!await launch(
                            "https://tier1integrity.pocsofclients.com/UserProfile?id=" +
                                widget.loggedinuser!.sId!.toString())) {
                          print("Could not launch");
                        }
                      },
                      child: QrImage(
                        data:
                            "https://tier1integrity.pocsofclients.com/UserProfile?id=" +
                                widget.loggedinuser!.sId!,
                        size: 180,
                        embeddedImage: AssetImage(
                          "assets/images/userlogo.png",
                        ),
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
                        width: 280,
                        height: 120,
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
                                child: Text("" + widget.loggedinuser!.desig!),
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w700)),
                            SizedBox(
                              height: 5,
                            ),
                            DefaultTextStyle(
                                child: Text("Cost Center : " +
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
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text(
                "Request for profile removal",
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none),
              ),
              onTap: () {
                showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          title: Text('Request for profile removal'),
                          content:
                              const Text('Are you sure you want to remove!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                UserApprovalDetails userdetails =
                                    UserApprovalDetails(
                                        sId: widget.loggedinuser!.sId,
                                        Status: "Requested for Deletion",
                                        StatusBg: "#FF0000",
                                        active: false);
                                BlocProvider.of<UserPatchBloc>(context).add(
                                    UserPatchEvent(
                                        approvalDetails: userdetails));
                                Navigator.pop(context);
                              },
                              child: const Text('No-longer employed'),
                            ),
                          ],
                        ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
