import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:ots_pocket/add_wo.dart';
import 'package:ots_pocket/approval_Wo.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/butons.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/wo_model.dart';
import 'package:ots_pocket/pdf_methods.dart';
import 'package:ots_pocket/upload_Wo.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/select_branch_text_form_field.dart';

import 'package:url_launcher/url_launcher.dart';

import 'daily_customer_timesheet/daily_customer_timesheet_pdf.dart';

class WOScreen extends StatefulWidget {
  final String? userid;
  final String? branchid;
  const WOScreen({required this.branchid, this.userid, Key? key})
      : super(key: key);

  @override
  State<WOScreen> createState() => _WOScreenState();
}

class _WOScreenState extends State<WOScreen> {
  late GetConsumableBloc getConsumeablesBloc;

  DateTime selectedDate = DateTime.now();

  int? totalConsumeables;
  String? branchid;
  bool isLoaded = true;
  List<WODetails>? allpo;
  List<WODetails>? _allpo;
  List<WODetails>? filteredPO;
  List<String> reporttype = [
    "Daily Customer Timesheet",
    "Time Card",
    "Invoice"
  ];
  final TextEditingController searchController = TextEditingController();
  final TextEditingController costcenterController =
      TextEditingController(text: "All");
  bool searchstate = false;
  Map<String, Color> colorbycc = {
    "Pasadena, TX 77506": Color.fromARGB(225, 225, 145, 77),
    "Port Lavaca, TX 77979": Color.fromARGB(225, 151, 42, 40),
  };
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2099, 8));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    getPO();
    costcenterController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Future refresh() async {
    getPO();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoaded && _allpo!.length > 0) {
      branchid = _allpo![0].branchID.toString();
      allpo = _allpo;
      totalConsumeables = allpo?.length;
      if (searchstate == true && filteredPO != null) {
        allpo = filteredPO;
        totalConsumeables = filteredPO?.length;
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text(
          "WO#",
          style: TextStyle(
            color: Color(0xFF000000),
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Color(0xFF157B4F),
            ),
            tooltip: '',
            onPressed: () {
              if (widget.branchid!.length > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddWo(
                              username: widget.userid.toString(),
                            )));
              }
            },
          ),
          IconButton(
            icon: Icon(
              searchstate == false ? Icons.search : Icons.close,
              color: Color(0xFF157B4F),
            ),
            tooltip: 'Search consumable',
            onPressed: () {
              setState(() {
                if (searchstate) {
                  costcenterController.text = "All";
                }
                searchstate = !searchstate;
              });
            },
          )
        ],
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Color(0xFF157B4F)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: isLoaded
          ? AppIndicator.circularProgressIndicator
          : _allpo!.length > 0
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: Column(
                      children: [
                        searchstate == true
                            ? Column(
                                children: [
                                  Container(
                                    child: TextFormField(
                                      onChanged: filterList,
                                      controller: searchController,
                                      keyboardType: TextInputType.text,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      maxLength: 50,
                                      maxLines: null,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Color(0xFF000000),
                                      ),
                                      decoration: InputDecoration(
                                          counterText: '',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          hintText: "Search..",
                                          hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xFF919191),
                                          ),
                                          labelText: "Search.."),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  SelectBranchTextFormField(
                                    selectBranchController:
                                        costcenterController,
                                  ),
                                ],
                              )
                            : Container(),

                        Expanded(
                            child: GroupedListView<dynamic, String>(
                          elements: allpo!,
                          groupBy: (element) => element.poName,
                          groupSeparatorBuilder: (groppenvalue) => Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                new Divider(
                                  color: Colors.black87,
                                ),
                                Text(
                                  "PO# " + groppenvalue,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                new Divider(
                                  color: Colors.black87,
                                ),
                              ],
                            ),
                          ),
                          itemBuilder: (context, item) {
                            if (costcenterController.text == "All") {
                              return attendence(item, 1);
                            } else {
                              if (item.branchID != costcenterController.text) {
                                return Container();
                              } else {
                                return attendence(item, 1);
                              }
                            }
                          },
                        )),
                        // Expanded(
                        //   child: ListView.builder(
                        //       itemCount: totalConsumeables,
                        //       itemBuilder: (context, int index) {

                        //         return Column(
                        //           children: [
                        //             Container(
                        //               child: Text(key),
                        //             ),
                        //           ],
                        //         );
                        // Slidable(
                        //     endActionPane: ActionPane(
                        //       motion: const BehindMotion(),
                        //       children: [
                        //         SlidableAction(
                        //             icon: Icons.edit_note_rounded,
                        //             backgroundColor: Color(0xff13a693),
                        //             label: "Manage",
                        //             onPressed: (context) {
                        //               Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (context) => AddPo(
                        //                             username: widget.userid
                        //                                 .toString(),
                        //                           )));
                        //             }),
                        //         SlidableAction(
                        //             icon: Icons.qr_code,
                        //             backgroundColor: Color(0xFF8857c4),
                        //             label: "Show QR",
                        //             onPressed: (context) async {
                        //               showDialog<void>(
                        //                 context: context,
                        //                 barrierDismissible:
                        //                     false, // user must tap button!
                        //                 builder: (BuildContext context) {
                        //                   return AlertDialog(
                        //                     actions: <Widget>[
                        //                       TextButton(
                        //                         onPressed: () =>
                        //                             Navigator.pop(
                        //                                 context, 'Cancel'),
                        //                         child: const Text(
                        //                           'Hide',
                        //                           textScaleFactor: 1,
                        //                         ),
                        //                       ),
                        //                     ],
                        //                     insetPadding:
                        //                         EdgeInsets.symmetric(
                        //                             horizontal: 20),
                        //                     content: SingleChildScrollView(
                        //                       child: Column(
                        //                         mainAxisAlignment:
                        //                             MainAxisAlignment
                        //                                 .center,
                        //                         children: <Widget>[
                        //                           Container(
                        //                             child: Text(
                        //                               attd.woNumber
                        //                                   .toString(),
                        //                               style: TextStyle(
                        //                                   fontWeight:
                        //                                       FontWeight
                        //                                           .bold,
                        //                                   fontSize: 20),
                        //                             ),
                        //                           ),
                        //                           SizedBox(height: 15.0),
                        //                           Container(
                        //                             width: 200.0,
                        //                             height: 200.0,
                        //                             child: GestureDetector(
                        //                               onTap: () async {
                        //                                 if (!await launch(
                        //                                     "https://tier1integrity.pocsofclients.com/WOProfile?id=" +
                        //                                         attd.woNumber
                        //                                             .toString())) {
                        //                                   print(
                        //                                       "Could not launch");
                        //                                 }
                        //                               },
                        //                               child: QrImage(
                        //                                 errorStateBuilder:
                        //                                     (context,
                        //                                             error) =>
                        //                                         Text(error
                        //                                             .toString()),
                        //                                 data: "https://tier1integrity.pocsofclients.com/WOProfile?id=" +
                        //                                     attd.woNumber
                        //                                         .toString(),
                        //                               ),
                        //                             ),
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   );
                        //                 },
                        //               );
                        //             })
                        //       ],
                        //     ),
                        //     child: attendence(attd, index));
                        //           }),
                        //     ),
                      ],
                    ),
                  ),
                )
              : Container(
                  alignment: Alignment.center,
                  child: Text(
                    "No Data Found!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
      drawer: MyDrower1(),
    );
  }

  Widget getWOlist(WODetails wo) {
    return Container(
      child: Text(wo.woNumber.toString()),
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

  Widget attendence(WODetails po, int index) {
    String avatar = po.woNumber!.substring(10, 13).toUpperCase();
    Color bgcolor = Colors.white;
    index % 2 == 0 ? bgcolor = Colors.grey.shade300 : bgcolor = Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        child: GestureDetector(
          onTap: () async => {
            if (!await launch(
                "https://tier1integrity.pocsofclients.com/WOProfile?id=" +
                    po.woNumber.toString()))
              {
                print("Could not launch"),
              }
          },
          child: ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              radius: 20,
              child: Text(
                avatar,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: colorbycc[po.branchID],
              foregroundColor: Colors.black,
            ),
            title: Text(
              po.woNumber.toString(),
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "PO# " +
                  po.poName.toString() +
                  "\nJT: " +
                  po.JT.toString() +
                  "\nStartDate: " +
                  po.startDate.toString().split(" ")[0] +
                  "\nEndDate: " +
                  po.endDate.toString().split(" ")[0],
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
            trailing: IconButton(
                onPressed: () async {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Select",
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(
                              color: Colors.black45,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: reporttype.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          // Fluttertoast.showToast(
                                          //     msg: reporttype[index]);
                                          if (reporttype[index] ==
                                              "Daily Customer Timesheet") {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ApproveWo(
                                                          newWo: po,
                                                        )));
                                            // final pdfFile =
                                            //     await DailyCustomerTimesheetPdf
                                            //         .generate();

                                            // PdfMethods.openFile(pdfFile);
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 16.0),
                                          child: Text(
                                            reporttype[index],
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xFF000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: Color(0xFFD4D4D8),
                                        thickness: 1.0,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.print,
                  color: Colors.green,
                )),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Color(0xff13a693), //                   <--- border color
            width: 2.0,
          ),
          color: bgcolor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 1.0,
            ),
          ],
        ),
      ),
    );
  }

  Future filterList(String key) async {
    setState(() {
      filteredPO = _allpo
          ?.where((Consumable) => Consumable.woNumber
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      print(searchController.text);
    });
  }

  Future<void> getPO() async {
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/wo/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _allpo = json
            .decode(response.body)
            .map<WODetails>((json) => WODetails.fromJson(json))
            .toList();

        _allpo = _allpo!.reversed.toList();

        isLoaded = false;
      });
    } else {}
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
}
