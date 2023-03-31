import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ots_pocket/approve_User.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_bloc.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/user/delete_User/user_delete_bloc.dart';

class UserUtilizationScreen extends StatefulWidget {
  const UserUtilizationScreen({Key? key}) : super(key: key);

  @override
  State<UserUtilizationScreen> createState() => _UserUtilizationScreenState();
}

class _UserUtilizationScreenState extends State<UserUtilizationScreen> {
  late GetUserDetailsUserBloc getUserDetailsUserBloc;

  int? totalUser;
  int? nonActiveUser;
  bool? isnotification = false;
  double maxhrs = 0;
  @override
  void initState() {
    BlocProvider.of<GetUserDetailsUserBloc>(context).add(GetUserDetailsEvent());
    super.initState();
  }

  Future refresh() async {
    BlocProvider.of<GetUserDetailsUserBloc>(context).add(GetUserDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text(
          "Utilization Tracker",
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Color(0xFF157B4F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<GetUserDetailsUserBloc, GetUserDetailsState>(
        builder: (context, state) {
          if (state is GetUserDetailsLoadingState) {
            return AppIndicator.circularProgressIndicator;
          } else if (state is GetUserDetailsLoadedState) {
            totalUser = state.userDetailsList?.length;
            List<UserDetails> getNonActiveUser = state.userDetailsList
                    ?.where((UserDetails element) => element.active ?? false)
                    .toList() ??
                [];
            nonActiveUser = getNonActiveUser.length;
            nonActiveUser == 0 ? isnotification = false : isnotification = true;
            state.userDetailsList!.forEach((element) => {
                  if (element.hrs != null)
                    {
                      if (maxhrs < element.hrs)
                        {maxhrs = element.hrs.toDouble()}
                    }
                });

            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: RefreshIndicator(
                onRefresh: refresh,
                child: ListView.builder(
                    itemCount: totalUser! + 1,
                    itemBuilder: (context, int index) {
                      if (index == 0) {
                        return getAddressCard(
                            state.userDetailsList?[index].empBranch ?? "");
                      }
                      final attd = state.userDetailsList![index - 1];
                      return Slidable(
                          endActionPane: ActionPane(
                            motion: const BehindMotion(),
                            children: [
                              SlidableAction(
                                  icon: Icons.edit_note_rounded,
                                  backgroundColor: Color(0xff13a693),
                                  label: "Manage",
                                  onPressed: (context) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UserApproval(
                                                  selectedUserData: attd,
                                                  pagename: "Manage User",
                                                )));
                                  }),
                              SlidableAction(
                                  icon: Icons.qr_code,
                                  backgroundColor: Color(0xFF8857c4),
                                  label: "Show QR",
                                  onPressed: (context) {
                                    showDialog<String>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  context, 'Cancel'),
                                              child: const Text(
                                                'Hide',
                                                textScaleFactor: 1,
                                              ),
                                            ),
                                          ],
                                          insetPadding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    attd.fullname.toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                SizedBox(height: 15.0),
                                                Container(
                                                  width: 200.0,
                                                  height: 200.0,
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      if (!await launch(
                                                          "https://tier1integrity.pocsofclients.com/UserProfile?id=" +
                                                              attd.sId
                                                                  .toString())) {
                                                        print(
                                                            "Could not launch");
                                                      }
                                                    },
                                                    child: BarcodeWidget(
                                                      barcode: Barcode.qrCode(
                                                        errorCorrectLevel:
                                                            BarcodeQRCorrectionLevel
                                                                .high,
                                                      ),
                                                      data:
                                                          "https://tier1integrity.pocsofclients.com/UserProfile?id=" +
                                                              attd.sId
                                                                  .toString(),
                                                      width: 200,
                                                      height: 200,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  })
                            ],
                          ),
                          child: attendence(attd, index));
                    }),
              ),
            );
          } else if (state is GetUserDetailsErrorState) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
      drawer: MyDrower1(),
    );
  }

  Widget getAddressCard(String Branch) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Cost Center: " + Branch,
        style: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget attendence(UserDetails user, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        child: ListTile(
          leading: Container(
            alignment: Alignment.center,
            width: 60,
            height: 60,
            child: Text(user.fullname.toString().substring(0, 2)),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFFe0f2f1)),
          ),
          title: Text(
            user.fullname.toString(),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          subtitle: Row(
            children: [
              Text(
                user.hrs != null ? user.hrs.toString() + " Hr" : "0" + " Hr",
                style: TextStyle(color: Colors.black87),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: new LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 200,
                  animation: true,
                  lineHeight: 20.0,
                  center: Text(
                      (user.hrs != null
                              ? ((user.hrs / maxhrs) * 100)
                                  .toStringAsFixed(2)
                                  .toString()
                              : "0") +
                          " %",
                      style: TextStyle(color: Colors.grey.shade900)),
                  animationDuration: 2500,
                  percent: user.hrs != null ? (user.hrs / maxhrs) : 0,
                  alignment: MainAxisAlignment.start,
                  progressColor: Colors.green,
                  barRadius: const Radius.circular(16),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Color(0xff13a693), //                   <--- border color
            width: 2.0,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
      ),
    );
  }
}
