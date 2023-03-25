import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/add_con.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/po_model.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_po.dart';

class POScreen extends StatefulWidget {
  final String? userid;
  final String? costcenter;
  const POScreen({required this.userid, required this.costcenter, Key? key})
      : super(key: key);

  @override
  State<POScreen> createState() => _POScreenState();
}

class _POScreenState extends State<POScreen> {
  late GetConsumableBloc getConsumeablesBloc;

  int? totalConsumeables;
  String? branchid;
  bool isLoaded = true;
  List<PODetails>? allpo;
  List<PODetails>? _allpo;
  List<PODetails>? filteredPO;
  ConsumeablesDetails? PO;
  final TextEditingController searchController = TextEditingController();
  bool searchstate = false;

  @override
  void initState() {
    getPO();
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
          "PO#",
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
            tooltip: 'Add new consumable',
            onPressed: () {
              if (widget.costcenter!.length > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddPo(
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
                            ? Container(
                                child: TextFormField(
                                  onChanged: filterList,
                                  controller: searchController,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.none,
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
                              )
                            : Container(),
                        Expanded(
                            child: ListView.builder(
                                itemCount: totalConsumeables! + 1,
                                itemBuilder: (context, int index) {
                                  if (index == 0) {
                                    return getAddressCard(branchid ?? "");
                                  }
                                  final attd = allpo![index - 1];
                                  return Slidable(
                                      endActionPane: ActionPane(
                                        motion: const BehindMotion(),
                                        children: [
                                          SlidableAction(
                                              icon: Icons.edit_note_rounded,
                                              backgroundColor:
                                                  Color(0xff13a693),
                                              label: "Manage",
                                              onPressed: (context) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddPo(
                                                              username: widget
                                                                  .userid
                                                                  .toString(),
                                                            )));
                                              }),
                                          SlidableAction(
                                              icon: Icons.qr_code,
                                              backgroundColor:
                                                  Color(0xFF8857c4),
                                              label: "Show QR",
                                              onPressed: (context) async {
                                                showDialog<void>(
                                                  context: context,
                                                  barrierDismissible:
                                                      false, // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context,
                                                                  'Cancel'),
                                                          child: const Text(
                                                            'Hide',
                                                            textScaleFactor: 1,
                                                          ),
                                                        ),
                                                      ],
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Container(
                                                              child: Text(
                                                                attd.poNumber
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 15.0),
                                                            Container(
                                                              width: 200.0,
                                                              height: 200.0,
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  if (!await launch(
                                                                      "https://tier1integrity.pocsofclients.com/POProfile?id=" +
                                                                          attd.poID
                                                                              .toString())) {
                                                                    print(
                                                                        "Could not launch");
                                                                  }
                                                                },
                                                                child:
                                                                    BarcodeWidget(
                                                                  barcode: Barcode
                                                                      .qrCode(
                                                                    errorCorrectLevel:
                                                                        BarcodeQRCorrectionLevel
                                                                            .high,
                                                                  ),
                                                                  data: "https://tier1integrity.pocsofclients.com/POProfile?id=" +
                                                                      attd.poID
                                                                          .toString(),
                                                                  width: 200,
                                                                  height: 200,
                                                                ),
                                                                // child: QrImage(
                                                                //   errorStateBuilder: (context,
                                                                //           error) =>
                                                                //       Text(error
                                                                //           .toString()),
                                                                //   data: "https://tier1integrity.pocsofclients.com/POProfile?id=" +
                                                                //       attd.poID
                                                                //           .toString(),
                                                                // ),
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
                                })),
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

  Widget attendence(PODetails po, int index) {
    String avatar = po.poNumber!.substring(0, 2);
    Color bgcolor = Colors.white;
    index % 2 == 0 ? bgcolor = Colors.grey.shade300 : bgcolor = Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        child: ListTile(
          isThreeLine: true,
          leading: CircleAvatar(
            radius: 20,
            child: Text(
              avatar,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color(0xFF157B4F),
            foregroundColor: Colors.black,
          ),
          title: Text(
            po.poNumber.toString(),
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Client Name: " +
                po.CustomerID.toString() +
                "\nDate: " +
                po.timestamp.toString().split(" ")[0] +
                "\nTime: " +
                po.timestamp.toString().split(" ")[1].split(".")[0],
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
          trailing: IconButton(
              onPressed: () async {
                if (!await launch(
                    "https://tier1integrity.pocsofclients.com/POProfile?id=" +
                        po.poID.toString())) {
                  print("Could not launch");
                }
              },
              icon: Icon(
                Icons.arrow_circle_right,
                color: Colors.green,
              )),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(
            color: Color(0xff13a693), //                   <--- border color
            width: 1.0,
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
          ?.where((Consumable) => Consumable.poNumber
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
    var url = Uri.http('54.160.215.70:6622', '/api/po/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _allpo = json
            .decode(response.body)
            .map<PODetails>((json) => PODetails.fromJson(json))
            .toList();

        _allpo = _allpo!.reversed.toList();
        // Fluttertoast.showToast(msg: "get" + _allpo.toString());
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
