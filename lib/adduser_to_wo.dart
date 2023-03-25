import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/addcons_to_wo.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/csr_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/models/wo_model.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/select_designation_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_designationc_cat_text_form_field.dart';

class AddEmpWO extends StatefulWidget {
  final CSRDetails? csr;
  final WODetails? newWo;
  const AddEmpWO({Key? key, required this.csr, required this.newWo})
      : super(key: key);

  @override
  State<AddEmpWO> createState() => _AddEmpWOState();
}

class _AddEmpWOState extends State<AddEmpWO> {
  late GetConsumableBloc getConsumeablesBloc;
  final TextEditingController subcatagory = TextEditingController();
  final TextEditingController role = TextEditingController();
  bool isLoaded = true;
  List<UserDetails>? allusers;
  List<String> selecteduser = [];
  List<String> desigs = [];
  var selectedemployeedata = new Map();
  bool israteavailable = false;
  int userindex = 0;

  @override
  void initState() {
    getusers();
    super.initState();
    print(widget.csr);
    if (widget.csr != null) {
      israteavailable = true;
      // Fluttertoast.showToast(msg: "Hi");
      generatedesiglist();
    }
  }

  Future refresh() async {
    getusers();
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
          "Add Employee",
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        actions: <Widget>[],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Color(0xFF157B4F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isLoaded
          ? AppIndicator.circularProgressIndicator
          : Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: RefreshIndicator(
                onRefresh: refresh,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: allusers!.length,
                            itemBuilder: ((context, index) {
                              String username =
                                  allusers![index].fullname.toString();
                              return GestureDetector(
                                onTap: () {
                                  if (!selecteduser.contains(username)) {
                                    userindex = index;
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        title: const Text('Choose Services'),
                                        content: Container(
                                          height: 100,
                                          child: Column(
                                            children: [
                                              SelectDesignationCatTextFormField(
                                                selectDesignationController:
                                                    subcatagory,
                                              ),
                                              const SizedBox(
                                                height: 16.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              israteavailable
                                                  ? showModalBottomSheet<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Select Employee Role",
                                                              style: TextStyle(
                                                                  fontSize: 20),
                                                            ),
                                                            Divider(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                            Expanded(
                                                              child: ListView
                                                                  .builder(
                                                                itemCount:
                                                                    desigs
                                                                        .length,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          role.text =
                                                                              desigs[index];
                                                                          setState(
                                                                              () {
                                                                            saveuserdata(allusers![userindex]);
                                                                            userindex =
                                                                                0;
                                                                          });

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 8.0,
                                                                              horizontal: 16.0),
                                                                          child:
                                                                              Text(
                                                                            desigs[index],
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 16.0,
                                                                              color: Color(0xFF000000),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        color: Color(
                                                                            0xFFD4D4D8),
                                                                        thickness:
                                                                            1.0,
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  : showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        backgroundColor: Theme
                                                                .of(context)
                                                            .scaffoldBackgroundColor,
                                                        title: const Text(
                                                            'Choose Employee Role'),
                                                        content: Container(
                                                          height: 100,
                                                          child: Column(
                                                            children: [
                                                              SelectDesignationTextFormField(
                                                                  catagory:
                                                                      subcatagory
                                                                          .text,
                                                                  selectBranchController:
                                                                      role),
                                                              const SizedBox(
                                                                height: 16.0,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context,
                                                                    'Cancel'),
                                                            child: const Text(
                                                                'Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                saveuserdata(
                                                                    allusers![
                                                                        index]);
                                                              });
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                'Add'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                            },
                                            child: const Text('Next'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      selecteduser.remove(username);
                                    });
                                  }
                                },
                                child: ListTile(
                                  leading: selecteduser.contains(username)
                                      ? CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          child: Text(
                                            username[0],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                  title: Text(username,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18)),
                                  subtitle: selecteduser.contains(username)
                                      ? Text(
                                          selectedemployeedata[username][3] +
                                              "\n(" +
                                              selectedemployeedata[username]
                                                  [2] +
                                              ")",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14))
                                      : Text("Employee Role",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 14)),
                                ),
                              );
                            }))),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold),
                        minimumSize: const Size.fromHeight(48.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        surfaceTintColor: Color(0xFF157B4F),
                      ),
                      onPressed: () {
                        widget.newWo!.workers =
                            selectedemployeedata.values.toList();
                        print("AB" + widget.newWo!.workers.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddConWO(
                                      newWo: widget.newWo,
                                      csr: widget.csr == null
                                          ? null
                                          : widget.csr,
                                    )));
                      },
                      child: const Text(
                        "Add Consumable",
                      ),
                    ),
                    const SizedBox(
                      height: 26.0,
                    ),
                  ],
                ),
              ),
            ),
      drawer: MyDrower1(),
    );
  }

  Future<void> getusers() async {
    // Fluttertoast.showToast(msg: "servercall");
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/user/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        allusers = json
            .decode(response.body)
            .map<UserDetails>((json) => UserDetails.fromJson(json))
            .toList();
        isLoaded = false;
      });
    } else {
      print(response.body);
    }
  }

  Future<Map<String, String>> _getHeaderConfig() async {
    String? token = await appStorage?.retrieveEncryptedData('token');
    Map<String, String> headers = {};
    headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (token != null) {
      headers.putIfAbsent("auth-token", () => '$token');
    }
    return headers;
  }

  void generatedesiglist() {
    var details = new Map();
    widget.csr!.data!.forEach(
      (element) => {
        details = element,
        if (details["Category"] == "Labor")
          {
            desigs.add(
              details["Item_Description"],
            ),
          }
      },
    );
    // List<String> strs;
    // widget.csr!.data!.forEach(
    //   (element) => {
    //     strs = element.values.toString().split(", "),
    //     if (strs[0].replaceAll("(", "") == "LABOR") {desigs.add(strs[2])}
    //   },
    // );
    // print(desigs.toString());
  }

  void saveuserdata(UserDetails userdetails) {
    selecteduser.add(userdetails.fullname.toString());
    selectedemployeedata[userdetails.fullname.toString()] = [
      userdetails.sId.toString(),
      userdetails.fullname.toString(),
      subcatagory.text.trim(),
      role.text.trim()
    ];
    subcatagory.text = "";
    role.text = "";
  }
}
