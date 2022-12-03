import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/add_new_consumeable/add_new_consumeable_state.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/bloc/consumeable/patch_consumable_details/consumable_patch_state.dart';
import 'package:ots_pocket/bloc/equipment/add_new_equipment/add_new_equipment_bloc.dart';
import 'package:ots_pocket/bloc/equipment/equpments_event.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/widget_util/add_name_text_form_field.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/quantity_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';

import 'bloc/consumeable/patch_consumable_details/consumable_patch_bloc.dart';

class AddCon extends StatefulWidget {
  final String? pagename;
  final String? branchid;
  const AddCon({@required this.pagename, @required this.branchid, Key? key})
      : super(key: key);

  @override
  State<AddCon> createState() => _AddConState();
}

class _AddConState extends State<AddCon> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;
  bool isnameControllerFormFieldNotEmpty = false;

  @override
  void initState() {
    quantityController.addListener(() {
      setState(() {
        isQuantityTextFormFieldNotEmpty = quantityController.text.isNotEmpty;
      });
    });
    nameController.addListener(() {
      setState(() {
        isnameControllerFormFieldNotEmpty = nameController.text.isNotEmpty;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddNewConsumeableBloc, AddNewConsumeableState>(
      listener: (context, state) {
        if (state is AddNewConsumeableLoadingState) {
          return AppIndicator.onLoading(context);
        } else if (state is AddNewConsumeableSuccessState) {
          log("Manage");
          AppIndicator.popDialogContext();
          ShowToast.message(toastMsg: "Added!");
          Navigator.pop(context);
        } else if (state is AddNewConsumeableFailedState) {
          log("ConsumableChangesFailedState");
          AppIndicator.popDialogContext();
          showAlertPopUpForErrorMsg(
            context: context,
            title: "Update Failed",
            errorMsg: "${state.errorMsg}",
            onClickOk: () {
              Navigator.pop(context);
            },
          );
        } else {}
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          centerTitle: true,
          title: Text(
            "Add New " + widget.pagename.toString(),
            style: TextStyle(fontSize: 25, color: Colors.black87),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(),
          child: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 30.0, bottom: 32.0, left: 32.0, right: 32.0),
                child: Form(
                  key: patchFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Cost Center: " + widget.branchid.toString(),
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      AddNameTextFormField(
                        nameController: nameController,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      QuantityTextFormField(
                        quantityNumberController: quantityController,
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
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
                        onPressed: patchButtonActive()
                            ? () {
                                validate();
                              }
                            : null,
                        child: const Text(
                          "Add",
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  validate() {
    if (patchFormKey.currentState!.validate()) {
      if (widget.pagename == "Consumable") {
        ConsumeablesDetails newdata = ConsumeablesDetails(
            name: nameController.text.trim(),
            dispatchQnt: 0,
            branchID: widget.branchid,
            stockQnt: int.parse(quantityController.text.trim()));

        BlocProvider.of<AddNewConsumeableBloc>(context)
            .add(AddConsumeableEvent(condetails: newdata));
      } else {
        equipmentsDetails newdata = equipmentsDetails(
            name: nameController.text.trim(),
            dispatchQnt: 0,
            branchID: widget.branchid,
            availableQnt: int.parse(quantityController.text.trim()));

        BlocProvider.of<AddNewEquipmentBloc>(context)
            .add(AddEquipmentEvent(equipdata: newdata));
      }
    }
  }

  bool patchButtonActive() {
    if (isQuantityTextFormFieldNotEmpty && isnameControllerFormFieldNotEmpty) {
      return true;
    }
    return false;
  }
}
