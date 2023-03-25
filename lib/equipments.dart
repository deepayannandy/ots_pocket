import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ots_pocket/add_equip.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_state.dart';
import 'package:ots_pocket/bloc/equipment/equpments_event.dart';
import 'package:ots_pocket/bloc/equipment/get_equipments_deyails/get_equipments_details_bloc.dart';
import 'package:ots_pocket/bloc/equipment/get_equipments_deyails/get_equipments_details_state.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/manage_equipment.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class EquimentScreen extends StatefulWidget {
  const EquimentScreen({Key? key}) : super(key: key);

  @override
  State<EquimentScreen> createState() => _EquimentScreenState();
}

class _EquimentScreenState extends State<EquimentScreen> {
  late GetEqupmentsBloc getEquipmentsBloc;

  String? branchid;
  int? totalEquipments;
  List<equipmentsDetails>? allequipments;
  List<equipmentsDetails>? _allequipments;
  List<equipmentsDetails>? filteredequipments;
  equipmentsDetails? equipment;
  final TextEditingController searchController = TextEditingController();
  bool searchstate = false;

  @override
  void initState() {
    BlocProvider.of<GetEqupmentsBloc>(context).add(GetEqupmentsDetailsEvent());
    super.initState();
  }

  Future refresh() async {
    BlocProvider.of<GetEqupmentsBloc>(context).add(GetEqupmentsDetailsEvent());
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
          "Equipments",
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
            tooltip: 'Add new Equipments',
            onPressed: () {
              if (branchid!.length > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEquip(
                              pagename: "Equipment",
                              branchid: branchid,
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
      body: BlocBuilder<GetEqupmentsBloc, GetEquipmentsDetailsState>(
        builder: (context, state) {
          if (state is GetEquipmentsDetailsLoadingState) {
            return AppIndicator.circularProgressIndicator;
          } else if (state is GetEquipmentsDetailsLoadedState) {
            branchid = state.EquipementDetailsList![0].branchID.toString();
            _allequipments = state.EquipementDetailsList;
            allequipments = _allequipments;
            totalEquipments = allequipments?.length;
            if (searchstate == true && filteredequipments != null) {
              allequipments = filteredequipments;
              totalEquipments = filteredequipments?.length;
            }

            return Padding(
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
                                    borderRadius: BorderRadius.circular(12.0),
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
                          itemCount: totalEquipments! + 1,
                          itemBuilder: (context, int index) {
                            if (index == 0) {
                              return getAddressCard(state
                                      .EquipementDetailsList?[index].branchID ??
                                  "");
                            }
                            final attd = allequipments![index - 1];
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
                                                  builder: (context) =>
                                                      ManageEquipment(
                                                        selectedEquipment: attd,
                                                      )));
                                        }),
                                    SlidableAction(
                                        icon: Icons.qr_code,
                                        backgroundColor: Color(0xFF8857c4),
                                        label: "Show QR",
                                        onPressed: (context) {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible:
                                                false, // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: const Text(
                                                      'Hide',
                                                      textScaleFactor: 1,
                                                    ),
                                                  ),
                                                ],
                                                insetPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          attd.name.toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                      SizedBox(height: 15.0),
                                                      Container(
                                                        width: 200.0,
                                                        height: 200.0,
                                                        child: GestureDetector(
                                                          onTap: () async {
                                                            if (!await launch(
                                                                "https://tier1integrity.pocsofclients.com/EquipProfile?id=" +
                                                                    attd.eId
                                                                        .toString())) {
                                                              print(
                                                                  "Could not launch");
                                                            }
                                                          },
                                                          child: BarcodeWidget(
                                                            barcode:
                                                                Barcode.qrCode(
                                                              errorCorrectLevel:
                                                                  BarcodeQRCorrectionLevel
                                                                      .high,
                                                            ),
                                                            data: "https://tier1integrity.pocsofclients.com/EquipProfile?id=" +
                                                                attd.eId
                                                                    .toString(),
                                                            width: 200,
                                                            height: 200,
                                                          ),
                                                          // QrImage(
                                                          //   errorStateBuilder:
                                                          //       (context,
                                                          //               error) =>
                                                          //           Text(error
                                                          //               .toString()),
                                                          //   data: "https://tier1integrity.pocsofclients.com/EquipProfile?id=" +
                                                          //       attd.eId
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
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is GetConsumeableDetailsErrorState) {
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

  Widget attendence(equipmentsDetails equipments, int index) {
    String avatar = "";
    Color bgcolor = Colors.white;
    List<String> namepart = equipments.name!.split(" ");
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
              CircleAvatar(
                radius: 20,
                child: Text(
                  avatar,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Color(0xFF157B4F),
                foregroundColor: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(equipments.name ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Colors.black,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("In Stock ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black54,
                              )),
                          Text(equipments.availableQnt.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: equipments.availableQnt! < 1
                                    ? Colors.red
                                    : Colors.green,
                              )),
                          const VerticalDivider(
                            width: 20,
                            thickness: 1,
                            indent: 20,
                            endIndent: 0,
                            color: Colors.grey,
                          ),
                          Text("Dispatched ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black54,
                              )),
                          Text(equipments.dispatchQnt.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black54,
                              )),
                        ],
                      ),
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

  Future filterList(String key) async {
    setState(() {
      filteredequipments = _allequipments
          ?.where((equipment) => equipment.name
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      print(searchController.text);
    });
  }
}
