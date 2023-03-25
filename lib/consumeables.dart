import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ots_pocket/add_con.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/get_consumeable_deyails/get_consumeable_details_state.dart';
import 'package:ots_pocket/drawer1.dart';
import 'package:ots_pocket/manage_consumeable.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ConsumeableScreen extends StatefulWidget {
  const ConsumeableScreen({Key? key}) : super(key: key);

  @override
  State<ConsumeableScreen> createState() => _ConsumeableScreenState();
}

class _ConsumeableScreenState extends State<ConsumeableScreen> {
  late GetConsumableBloc getConsumeablesBloc;

  int? totalConsumeables;
  String? branchid;
  List<ConsumeablesDetails>? allconsumable;
  List<ConsumeablesDetails>? _allconsumable;
  List<ConsumeablesDetails>? filteredconsumable;
  ConsumeablesDetails? Consumable;
  final TextEditingController searchController = TextEditingController();
  bool searchstate = false;

  @override
  void initState() {
    BlocProvider.of<GetConsumableBloc>(context)
        .add(GetConsumeablesDetailsEvent());
    super.initState();
  }

  Future refresh() async {
    BlocProvider.of<GetConsumableBloc>(context)
        .add(GetConsumeablesDetailsEvent());
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
          "Consumables",
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
              if (branchid!.length > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCon(
                              pagename: "Consumable",
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
      body: BlocBuilder<GetConsumableBloc, GetConsumeableDetailsState>(
        builder: (context, state) {
          if (state is GetConsumeableDetailsLoadingState) {
            return AppIndicator.circularProgressIndicator;
          } else if (state is GetConsumeablesDetailsLoadedState) {
            branchid = state.ConsumeableDetailsList![0].branchID.toString();
            _allconsumable = state.ConsumeableDetailsList;
            allconsumable = _allconsumable;
            totalConsumeables = allconsumable?.length;
            if (searchstate == true && filteredconsumable != null) {
              allconsumable = filteredconsumable;
              totalConsumeables = filteredconsumable?.length;
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
                          itemCount: totalConsumeables! + 1,
                          itemBuilder: (context, int index) {
                            if (index == 0) {
                              return getAddressCard(state
                                      .ConsumeableDetailsList?[index]
                                      .branchID ??
                                  "");
                            }
                            final attd = allconsumable![index - 1];
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
                                                      ManageConsumeable(
                                                        selectedConsumeables:
                                                            attd,
                                                      )));
                                        }),
                                    SlidableAction(
                                        icon: Icons.qr_code,
                                        backgroundColor: Color(0xFF8857c4),
                                        label: "Show QR",
                                        onPressed: (context) async {
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
                                                                "https://tier1integrity.pocsofclients.com/ConsProfile?id=" +
                                                                    attd.cId
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
                                                            data: "https://tier1integrity.pocsofclients.com/ConsProfile?id=" +
                                                                attd.cId
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
                                                          //   data: "https://tier1integrity.pocsofclients.com/ConsProfile?id=" +
                                                          //       attd.cId
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

  Widget attendence(ConsumeablesDetails consumeable, int index) {
    String avatar = "";
    Color bgcolor = Colors.white;
    List<String> namepart = consumeable.name!.split(" ");
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
                    Text(consumeable.name ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.black,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("In Stock ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        Text(consumeable.stockQnt.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: consumeable.stockQnt! < 15
                                  ? Colors.red
                                  : Colors.green,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text("MSR ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        Text(
                            "\$" +
                                (consumeable.UR == null
                                    ? "0"
                                    : consumeable.UR.toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.green,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text("PR ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.black54,
                            )),
                        Text(
                            "\$" +
                                (consumeable.UR == null
                                    ? "0"
                                    : consumeable.PR.toString()),
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

  Future filterList(String key) async {
    setState(() {
      filteredconsumable = _allconsumable
          ?.where((Consumable) => Consumable.name
              .toString()
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
      print(searchController.text);
    });
  }
}
