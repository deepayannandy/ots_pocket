import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/approve_User.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_bloc.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/my_drawer.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({Key? key}) : super(key: key);

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  late GetUserDetailsUserBloc getUserDetailsUserBloc;

  int? totalUser;
  int? nonActiveUser;
  bool? isnotification = false;

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
          "Registered Users",
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
                                  onPressed: (context) {}),
                              SlidableAction(
                                  icon: Icons.qr_code,
                                  backgroundColor: Color(0xFF8857c4),
                                  label: "Show QR",
                                  onPressed: (context) {})
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
        "Cost Centre: " + Branch,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(user.fullname ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 24,
                        color: Colors.black,
                      )),
                  Spacer(),
                  Text("User Status",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black54,
                      )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(user.desig ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xff13a693),
                        )),
                    Spacer(),
                    Text(user.active == true ? "Active" : "Pending",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: user.active == true
                              ? Color(0xff13a693)
                              : Colors.red,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email: " + user.email!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black54,
                        )),
                    Spacer(),
                    Text("Contact No." + user.mobile!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black54,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              user.active! == false
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserApproval(
                                          selectedUserData: user,
                                        )));
                          },
                          child: const Text('Approve',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.green,
                              )),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: null,
                          child: const Text('Reject',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.red,
                              )),
                        ),
                        Spacer(),
                      ],
                    )
                  : Container(
                      child: SizedBox(),
                    )
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
