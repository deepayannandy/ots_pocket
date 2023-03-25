import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/main.dart';
import 'package:http/http.dart' as http;
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/models/user_details_model.dart';
import 'package:ots_pocket/upload_Wo.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/dispatch_quantity_text_form_field.dart';
import 'package:ots_pocket/widget_util/purchaseRate_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_designation_text_form_field.dart';
import 'package:ots_pocket/widget_util/select_designationc_cat_text_form_field.dart';
import 'package:ots_pocket/widget_util/unitRate_text_form_field.dart';

import 'models/csr_model.dart';
import 'models/wo_model.dart';

class AddEqupWO extends StatefulWidget {
  final CSRDetails? csr;
  final WODetails? newWo;
  const AddEqupWO({Key? key, required this.csr, required this.newWo})
      : super(key: key);

  @override
  State<AddEqupWO> createState() => _AddEqupWOState();
}

class _AddEqupWOState extends State<AddEqupWO> {
  late GetConsumableBloc getConsumeablesBloc;
  final TextEditingController URController = TextEditingController();
  final TextEditingController PRController = TextEditingController();
  final TextEditingController qntController = TextEditingController();
  bool isLoaded = true;
  List csrEquips = [];
  List<equipmentsDetails>? allequip;
  List<String> selectedequip = [];
  var selectedequipsdata = new Map();
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
          "Add Equipment",
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
                                itemCount: csrEquips.length,
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
                                                    savecondata(
                                                        csrEquips[index]);
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
                                          leading: selectedequip
                                                  .contains(csrEquips[index][2])
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
                                                    csrEquips[index][2][0],
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                          title: Text(csrEquips[index][2],
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18)),
                                          subtitle: selectedequip
                                                  .contains(csrEquips[index][2])
                                              ? Text(
                                                  "CSR: " +
                                                      csrEquips[index][3]
                                                          .toString() +
                                                      "\$\n" +
                                                      "Quantity:" +
                                                      selectedequipsdata[csrEquips[index][2]]
                                                          [1],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14))
                                              : Text("CSR: " + csrEquips[index][3].toString() + "\$",
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 14))));
                                })))
                        : Expanded(
                            child: ListView.builder(
                                itemCount: allequip!.length,
                                itemBuilder: ((context, index) {
                                  String conname =
                                      allequip![index].name.toString();
                                  return GestureDetector(
                                    onTap: () {
                                      if (!selectedequip.contains(conname)) {
                                        URController.text =
                                            allequip![index].UR == null
                                                ? "0"
                                                : allequip![index]
                                                    .UR
                                                    .toString();
                                        PRController.text =
                                            allequip![index].PR == null
                                                ? "0"
                                                : allequip![index]
                                                    .PR
                                                    .toString();
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
                                                          qntController),
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
                                                        allequip![index]);
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
                                          selectedequip.remove(conname);
                                        });
                                      }
                                    },
                                    child: ListTile(
                                      leading: selectedequip.contains(conname)
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
                                      subtitle: selectedequip.contains(conname)
                                          ? Text(
                                              "PR: " +
                                                  selectedequipsdata[conname]
                                                      [4] +
                                                  "\$ \tMSR:" +
                                                  selectedequipsdata[conname]
                                                      [3] +
                                                  "\$\t Quantity:" +
                                                  selectedequipsdata[conname]
                                                      [1],
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 14))
                                          : Text("",
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
                        widget.newWo!.equipements =
                            selectedequipsdata.values.toList();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => createWo(
                                      newWo: widget.newWo,
                                      csr: widget.csr,
                                    )));
                      },
                      child: const Text(
                        "Review And Create",
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
        allequip = json
            .decode(response.body)
            .map<equipmentsDetails>((json) => equipmentsDetails.fromJson(json))
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

  void saveuserdata(equipmentsDetails consDetails) {
    selectedequip.add(consDetails.name.toString());
    selectedequipsdata[consDetails.name.toString()] = [
      consDetails.eId.toString(),
      qntController.text,
      consDetails.name.toString(),
      URController.text,
      PRController.text
    ];
    URController.text = "";
    PRController.text = "";
    qntController.text = "";
  }

  void generatedesiglist() {
    var details = new Map();
    widget.csr!.data!.forEach(
      (element) => {
        print(element.runtimeType),
        details = element,
        print(details["QR_CODE"]),
        if (details["Category"] == "Equipment")
          {
            csrEquips.add([
              details["QR_CODE"],
              0,
              details["Item_Description"],
              details["Unit_Price"].toDouble()
            ]),
          }
      },
    );
    print(csrEquips.toString());
    // Fluttertoast.showToast(msg: csrEquips.length.toString());
  }

  void savecondata(List consDetails) {
    selectedequip.add(consDetails[2].toString());
    selectedequipsdata[consDetails[2].toString()] = [
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
