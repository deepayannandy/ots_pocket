import 'dart:convert';
import 'dart:isolate';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/add_Certification.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/models/certification_model.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/select_branch_text_form_field.dart';

import 'main.dart';

class TechCertificationScreen extends StatefulWidget {
  final String? branchid;
  const TechCertificationScreen({Key? key, required this.branchid})
      : super(key: key);

  @override
  State<TechCertificationScreen> createState() =>
      _TechCertificationScreenState();
}

class _TechCertificationScreenState extends State<TechCertificationScreen> {
  int? totalConsumeables;
  String? branchid;
  bool isloading = true;
  List<CertificationModel>? allcert;
  List<CertificationModel>? _allcert;
  List<CertificationModel>? filteredcert;
  CertificationModel? Consumable;
  final TextEditingController searchController = TextEditingController();
  bool searchstate = false;

  @override
  void initState() {
    getCert();
    super.initState();
  }

  Future refresh() async {
    BlocProvider.of<GetConsumableBloc>(context)
        .add(GetConsumeablesDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    if (!isloading && _allcert!.length > 0) {
      allcert = _allcert;
      if (searchstate == true && filteredcert != null) {
        allcert = filteredcert;
        totalConsumeables = filteredcert?.length;
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.3,
        title: Text(
          "Certifications",
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
            tooltip: 'Add new Certifications',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCertification(
                            branchid: widget.branchid,
                          )));
            },
          ),
          IconButton(
            icon: Icon(
              searchstate == false ? Icons.search : Icons.close,
              color: Color(0xFF157B4F),
            ),
            tooltip: 'Search Certification',
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
      body: isloading
          ? AppIndicator.circularProgressIndicator
          : _allcert!.length > 0
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
                                ],
                              )
                            : Container(),
                        Expanded(
                            child: GroupedListView<dynamic, String>(
                          elements: allcert!,
                          groupBy: (element) => element.employeename,
                          groupSeparatorBuilder: (groppenvalue) => Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Column(
                              children: [
                                new Divider(
                                  color: Colors.black87,
                                ),
                                Text(
                                  groppenvalue,
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
                            if (searchController.text == "All") {
                              return attendence(item, 1);
                            } else {
                              return attendence(item, 1);
                            }
                          },
                        )),
                      ],
                    ),
                  ),
                )
              : Container(),
      drawer: MyDrower1(),
    );
  }

  Widget attendence(CertificationModel certification, int index) {
    String avatar = "";
    Color bgcolor = Colors.white;
    List<String> namepart = certification.CertificateName!.split(" ");
    namepart.length < 2
        ? avatar = namepart[0].substring(0, 1)
        : avatar = namepart[0].substring(0, 1) + namepart[1].substring(0, 1);
    index % 2 == 0 ? bgcolor = Colors.grey.shade300 : bgcolor = Colors.white;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "asset/images/certificate.png",
                height: 55,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(certification.CertificateName ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text("ID ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        Text(certification.Certificateid.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Text("Supervisor ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        Text(certification.Supervisor.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green,
                            )),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("From ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        Text(
                            (certification.startdate == null
                                ? "NA"
                                : certification.startdate.toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text("To ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        Text(
                            (certification.enddate == null
                                ? "NA"
                                : certification.enddate.toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  Future<void> getCert() async {
    // Fluttertoast.showToast(msg: "servercall");
    setState(() {
      isloading = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622',
        '/api/certification/' + widget.branchid.toString());
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        _allcert = json
            .decode(response.body)
            .map<CertificationModel>(
                (json) => CertificationModel.fromJson(json))
            .toList();

        isloading = false;
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

  Future filterList(String key) async {
    setState(() {
      filteredcert = _allcert
          ?.where((Consumable) => Consumable.employeename
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      print(searchController.text);
    });
  }
}
