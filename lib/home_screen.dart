import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/user/get_loggedin_user_details/get_loggedin_user_details_state.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_bloc.dart';
import 'package:ots_pocket/bloc/user/get_user_details/get_user_details_state.dart';
import 'package:ots_pocket/bloc/user/user_event.dart';
import 'package:ots_pocket/consumeables.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/equipments.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/userManagementSceen.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';

import 'bloc/user/get_loggedin_user_details/get_loggedin_user_details_bloc.dart';
import 'login_screen.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetUserDetailsUserBloc getUserDetailsUserBloc;
  late GetLoggedinUserDetailsBloc getLoggedinUserDetailsBloc;

  int? totalUser;
  int? nonActiveUser;
  bool? isnotification = false;

  @override
  void initState() {
    BlocProvider.of<GetUserDetailsUserBloc>(context).add(GetUserDetailsEvent());
    BlocProvider.of<GetLoggedinUserDetailsBloc>(context)
        .add(GetLoggedinUserDetailsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Image.asset(
          "asset/images/clientlogo.png",
          height: 40,
        ),
        actions: [
          IconButton(
            onPressed: () {
              isnotification == true
                  ? Fluttertoast.showToast(msg: "You have some Notifications!")
                  : Fluttertoast.showToast(msg: "There is no Notifications!");
            },
            icon: Icon(
              isnotification == false
                  ? Icons.notifications_outlined
                  : Icons.notifications,
              color: isnotification == false ? Colors.grey : Colors.red,
            ),
          ),
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xff487f4e),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
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

            return BlocBuilder<GetLoggedinUserDetailsBloc,
                GetLoggedinUserDetailsState>(builder: (context, state1) {
              if (false) {
                return AppIndicator.circularProgressIndicator;
              } else if (state1 is GetLoggedinUserDetailsLoadedState) {
                if (state1.userDetails!.desig == "Manager") {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "My Shortcuts",
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFFf26a6e),
                                        title: "User",
                                        iconName: Icons.person),
                                  ),
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFFf58ed5),
                                        title: "Time Card",
                                        iconName: Icons.app_registration),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFF9c8e8b),
                                        title: "Expenses",
                                        iconName: Icons.currency_exchange),
                                  ),
                                  Expanded(
                                    child: getCard(
                                      cardBgColor: Color(0xFF43c85d),
                                      title: "Daily Reports",
                                      iconName: Icons.pages_outlined,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Project Management",
                                  style: TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFF03DAC5),
                                        title: "PO",
                                        iconName: Icons.task),
                                  ),
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFF6200EE),
                                        title: "WO",
                                        iconName: Icons.task_rounded),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFF442c2e),
                                        title: "Customers",
                                        iconName: Icons.person_outline),
                                  ),
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFF5D1049),
                                        title: "DailyTimeSheet",
                                        iconName: Icons.pages_rounded),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.folder_copy_outlined),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      "Inventory Management",
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(
                                      Icons.add,
                                      color: Color(0xFF157B4F),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFF8857c4),
                                        title: "Equipments",
                                        iconName: Icons.handyman),
                                  ),
                                  Expanded(
                                    child: getCard(
                                        cardBgColor: Color(0xFF5270ca),
                                        title: "Consumables",
                                        iconName: Icons.settings),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "My Shortcuts",
                                style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: getCard(
                                      cardBgColor: Color(0xFFf26a6e),
                                      title: "Daily expenses",
                                      iconName:
                                          CupertinoIcons.money_dollar_circle),
                                ),
                                Expanded(
                                  child: getCard(
                                      cardBgColor: Color(0xFFf58ed5),
                                      title: "Time Card",
                                      iconName: CupertinoIcons.time),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: getCard(
                                      cardBgColor: Color(0xFF9c8e8b),
                                      title: "My Tasks",
                                      iconName: CupertinoIcons.tag_circle),
                                ),
                                Expanded(
                                  child: getCard(
                                    cardBgColor: Color(0xFF43c85d),
                                    title: "Reports",
                                    iconName: CupertinoIcons.doc,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
              } else if (state1 is GetLoggedinUserDetailsErrorState) {
                return Container(
                  child: Text("User dose not exist!"),
                );
              } else {
                return Container(
                  child: Text(""),
                );
              }
            });
          } else if (state is GetUserDetailsErrorState) {
            logout(context);
            return Container(
              child: Text("User dose not exist!"),
            );
          } else {
            return Container();
          }
        },
      ),
      drawer: MyDrower1(),
    );
  }

  getuserscount() {}

  Widget getCard(
      {required Color cardBgColor,
      required String title,
      required IconData iconName}) {
    return GestureDetector(
      onTap: () {
        if (title == "User") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => UserManagementScreen()));
        } else if (title == "Consumables") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ConsumeableScreen()));
        } else if (title == "Equipments") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EquimentScreen()));
        } else {
          final snackBar = SnackBar(
            content: const Text(
              'This feature is not yet enabled!',
              style: TextStyle(color: Colors.black54),
            ),
            backgroundColor: (Colors.white),
            action: SnackBarAction(
              label: 'Dismiss',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: cardBgColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            children: [
              getCardData1(title: title, iconName: iconName),
              SizedBox(
                height: 32.0,
              ),
              title == "User"
                  ? getCardData2()
                  : SizedBox(
                      height: 24,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCardData1({required String title, required IconData iconName}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
          ),
        ),
        Spacer(),
        Icon(
          iconName,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget getCardData2() {
    return Row(
      children: [
        Text(
          "Total User: ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        Text(
          "${totalUser}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        Spacer(),
      ],
    );
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
}
