import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/add_customer.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/customer_model.dart';

import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomersScreen extends StatefulWidget {
  final String? costcenter;
  const CustomersScreen({required this.costcenter, Key? key, String? username})
      : super(key: key);

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  bool isLoaded = false;
  List<CustomerDetails>? customers;
  Map userdata = new Map();
  @override
  void initState() {
    super.initState();
    getCustomers();
  }

  Future refresh() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.3,
          title: Text(
            "Clients",
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
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Color(0xFF157B4F),
              ),
              tooltip: 'Add new Client',
              onPressed: () {
                if (widget.costcenter!.length > 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCustomer(
                                branchid: widget.costcenter,
                              )));
                }
              },
            ),
          ]),
      body: isLoaded
          ? AppIndicator.circularProgressIndicator
          : RefreshIndicator(
              onRefresh: () async {
                getCustomers();
              },
              child: ListView.builder(
                  itemCount: customers!.length,
                  itemBuilder: (context, int index) {
                    return ctile(customers![index], index);
                  }),
            ),
      drawer: MyDrower1(),
    );
  }

  Widget ctile(CustomerDetails client, int index) {
    String avatar = client.Customer!.substring(0, 2);
    Color bgcolor = Colors.white;
    index % 2 == 0 ? bgcolor = Colors.grey.shade300 : bgcolor = Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Stack(
        children: [
          Container(
            child: ListTile(
              // isThreeLine: true,
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
                client.Customer.toString(),
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              // subtitle: Text(
              //   "WO: " +
              //       tc.wo.toString() +
              //       "\nST: " +
              //       tc.st.toString() +
              //       "\tOT: " +
              //       tc.ot.toString() +
              //       "\tTT: " +
              //       tc.tt.toString(),
              //   style: TextStyle(color: Colors.black87, fontSize: 14),
              // ),
              trailing: IconButton(
                  onPressed: () async {
                    try {
                      Fluttertoast.showToast(msg: client.Customer.toString());
                      if (!await launch(Uri.parse(
                              "https://tier1integrity.pocsofclients.com/CustomerProfile?id=" +
                                  client.Customer.toString())
                          .toString())) {
                        print("Could not launch");
                      }
                    } catch (e) {
                      Fluttertoast.showToast(msg: "Something Went Wrong");
                      print(e);
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
        ],
      ),
    );
  }

  Future<void> getCustomers() async {
    // Fluttertoast.showToast(msg: "Fetching user data");
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    // Fluttertoast.showToast(msg: widget.username.toString());
    var url = Uri.http('54.160.215.70:6622', '/api/customer/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        customers = json
            .decode(response.body)
            .map<CustomerDetails>((json) => CustomerDetails.fromJson(json))
            .toList();
        // Fluttertoast.showToast(msg: _timecard!.length.toString());
        // Fluttertoast.showToast(msg: "get" + _allpo.toString());
        // Fluttertoast.showToast(msg: userdata.length.toString());
        isLoaded = false;
      });
    } else {
      Fluttertoast.showToast(msg: response.body);
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
}
