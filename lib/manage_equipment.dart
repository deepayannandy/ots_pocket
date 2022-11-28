import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/equipment/patch_equipments_details/equipments_patch_bloc.dart';
import 'package:ots_pocket/bloc/equipment/patch_equipments_details/equipments_patch_state.dart';
import 'package:ots_pocket/models/equipments_model.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/quantity_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';
import 'bloc/equipment/equpments_event.dart';

class ManageEquipment extends StatefulWidget {
  final equipmentsDetails? selectedEquipment;
  const ManageEquipment({@required this.selectedEquipment, Key? key})
      : super(key: key);

  @override
  State<ManageEquipment> createState() => _ManageEquipmentState();
}

class _ManageEquipmentState extends State<ManageEquipment> {
  final TextEditingController quantityController = TextEditingController();

  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;

  @override
  void initState() {
    quantityController.addListener(() {
      setState(() {
        isQuantityTextFormFieldNotEmpty = quantityController.text.isNotEmpty;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String avatar = "";
    List<String> namepart = widget.selectedEquipment!.name!.split(" ");
    namepart.length < 2
        ? avatar = namepart[0].substring(0, 1)
        : avatar = namepart[0].substring(0, 1) + namepart[1].substring(0, 1);
    return BlocListener<EquipmentPatchBloc, EquipmentsPatchState>(
      listener: (context, state) {
        if (state is EquipmentsPatchLoadingState) {
          return AppIndicator.onLoading(context);
        } else if (state is EquipmentsPatchSuccessState) {
          log("Manage");
          AppIndicator.popDialogContext();
          ShowToast.message(toastMsg: "Updated!");
          Navigator.pop(context);
        } else if (state is EquipmentsPatchFailedState) {
          log("EquipmentsChangesFailedState");
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
            "Update Form",
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: Text(avatar),
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 20,
                                child: VerticalDivider(color: Colors.black),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Equipment Name:",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.selectedEquipment!.name!,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Instock: " +
                                        widget.selectedEquipment!.availableQnt!
                                            .toString(),
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                          "Update",
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
      equipmentsDetails updatedEquipment = equipmentsDetails(
          eId: widget.selectedEquipment!.eId,
          availableQnt: int.parse(quantityController.text.trim()));

      BlocProvider.of<EquipmentPatchBloc>(context)
          .add(EquipmentPatchEvent(updateDetails: updatedEquipment));
    }
  }

  bool patchButtonActive() {
    if (isQuantityTextFormFieldNotEmpty) {
      return true;
    }
    return false;
  }
}
