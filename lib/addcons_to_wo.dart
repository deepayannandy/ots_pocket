import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/csritemModel.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/dispatch_quantity_text_form_field.dart';
import 'package:ots_pocket/widget_util/purchaseRate_text_form_field.dart';
import 'package:ots_pocket/widget_util/quantity_text_form_field.dart';
import 'package:ots_pocket/widget_util/unitRate_text_form_field.dart';

import 'addequip_to_wo.dart';
import 'models/csr_model.dart';
import 'models/wo_model.dart';

class AddConWO extends StatefulWidget {
  final CSRDetails? csr;
  final WODetails? newWo;
  const AddConWO({Key? key, required this.csr, required this.newWo})
      : super(key: key);

  @override
  State<AddConWO> createState() => _AddConWOState();
}

class _AddConWOState extends State<AddConWO> {
  late GetConsumableBloc getConsumeablesBloc;
  final TextEditingController URController = TextEditingController();
  final TextEditingController PRController = TextEditingController();
  final TextEditingController qntController = TextEditingController();
  bool isLoaded = true;
  List<ConsumeablesDetails>? allcons;
  List csrCons = [];
  List<String> selectedcons = [];
  var selectedconsdata = new Map();
  bool iscsr = false;
  @override
  void initState() {
    getusers();
    super.initState();

    if (widget.csr != null) {
      Fluttertoast.showToast(msg: "from Csr");
      iscsr = true;
      generatedesiglist();
    }
    ;
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
          "Add Consumables",
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
                    iscsr
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: csrCons.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            title:
                                                const Text('Choose Quantity'),
                                            content: Container(
                                              height: 200,
                                              child: Column(
                                                children: [
                                                  DispatchQuantityTextFormField(
                                                      quantityNumberController:
                                                          qntController),
                                                  const SizedBox(
                                                    height: 48.0,
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
                                                  setState(() {
                                                    savecondata(csrCons[index]);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      child: ListTile(
                                          leading: selectedcons
                                                  .contains(csrCons[index][2])
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
                                                    csrCons[index][2][0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                          title: Text(csrCons[index][2],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          subtitle: selectedcons
                                                  .contains(csrCons[index][2])
                                              ? Text(
                                                  "CSR: " +
                                                      csrCons[index][3]
                                                          .toString() +
                                                      "\$\n" +
                                                      "Quantity:" +
                                                      selectedconsdata[csrCons[index][2]]
                                                          [1],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14))
                                              : Text("CSR: " + csrCons[index][3].toString() + "\$",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14))));
                                })))
                        : Expanded(
                            child: ListView.builder(
                                itemCount: allcons!.length,
                                itemBuilder: ((context, index) {
                                  String conname =
                                      allcons![index].name.toString();
                                  return GestureDetector(
                                    onTap: () {
                                      if (!selectedcons.contains(conname)) {
                                        URController.text =
                                            allcons![index].UR == null
                                                ? "0"
                                                : allcons![index].UR.toString();
                                        PRController.text =
                                            allcons![index].PR == null
                                                ? "0"
                                                : allcons![index].PR.toString();
                                        showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            title: const Text(
                                                'Choose Consumeable'),
                                            content: Container(
                                              height: 220,
                                              child: Column(
                                                children: [
                                                  UnitRateTextFormField(
                                                      UnitRateNumberController:
                                                          URController),
                                                  const SizedBox(
                                                    height: 16.0,
                                                  ),
                                                  PurchaseRateTextFormField(
                                                      UnitRateNumberController:
                                                          PRController),
                                                  const SizedBox(
                                                    height: 16.0,
                                                  ),
                                                  DispatchQuantityTextFormField(
                                                      quantityNumberController:
                                                          qntController)
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
                                                  setState(() {
                                                    saveuserdata(
                                                        allcons![index]);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Add'),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          selectedcons.remove(conname);
                                        });
                                      }
                                    },
                                    child: ListTile(
                                      leading: selectedcons.contains(conname)
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
                                                conname[0],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                      title: Text(conname,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18)),
                                      subtitle: selectedcons.contains(conname)
                                          ? Text(
                                              "PR: " +
                                                  selectedconsdata[conname][4] +
                                                  "\$ \tMSR:" +
                                                  selectedconsdata[conname][3] +
                                                  "\$\t " +
                                                  "Quantity: " +
                                                  selectedconsdata[conname][1],
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14))
                                          : Text(
                                              "Available: " +
                                                  allcons![index]
                                                      .stockQnt
                                                      .toString(),
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
                        widget.newWo!.consumeables =
                            selectedconsdata.values.toList();
                        print("cd" + widget.newWo!.consumeables.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEqupWO(
                                      newWo: widget.newWo,
                                      csr: widget.csr,
                                    )));
                      },
                      child: const Text(
                        "Add Equipment",
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
    setState(() {
      isLoaded = true;
    });
    var headers = await _getHeaderConfig();
    var url = Uri.http('54.160.215.70:6622', '/api/consumeables/');
    var response = await http.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        allcons = json
            .decode(response.body)
            .map<ConsumeablesDetails>(
                (json) => ConsumeablesDetails.fromJson(json))
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
        print(element.runtimeType),
        details = element,
        print(details["QR_CODE"]),
        if (details["Category"] == "Consumables")
          {
            csrCons.add([
              details["QR_CODE"],
              0,
              details["Item_Description"],
              details["Unit_Price"].toDouble()
            ]),
          }
      },
    );
    print(csrCons.toString());
  }

  void saveuserdata(ConsumeablesDetails consDetails) {
    selectedcons.add(consDetails.name.toString());
    selectedconsdata[consDetails.name.toString()] = [
      consDetails.cId.toString(),
      qntController.text,
      consDetails.name.toString(),
      URController.text,
      PRController.text
    ];
    URController.text = "";
    PRController.text = "";
    qntController.text = "";
  }

  void savecondata(List consDetails) {
    selectedcons.add(consDetails[2].toString());
    selectedconsdata[consDetails[2].toString()] = [
      consDetails[0],
      qntController.text,
      consDetails[2],
      consDetails[3],
    ];
    URController.text = "";
    PRController.text = "";
    qntController.text = "";
  }
}
