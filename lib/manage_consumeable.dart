import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/consumeable/consumeables_event.dart';
import 'package:ots_pocket/bloc/consumeable/patch_consumable_details/consumable_patch_state.dart';
import 'package:ots_pocket/bloc/user/patch_User_details/user_patch_bloc.dart';
import 'package:ots_pocket/bloc/user/patch_User_details/user_patch_state.dart';
import 'package:ots_pocket/models/consumeables_model.dart';
import 'package:ots_pocket/widget_util/alert_pop_up_for_error_msg.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/purchaseRate_text_form_field.dart';
import 'package:ots_pocket/widget_util/quantity_text_form_field.dart';
import 'package:ots_pocket/widget_util/show_toast.dart';
import 'package:ots_pocket/widget_util/unitRate_text_form_field.dart';

import 'bloc/consumeable/patch_consumable_details/consumable_patch_bloc.dart';

class ManageConsumeable extends StatefulWidget {
  final ConsumeablesDetails? selectedConsumeables;
  const ManageConsumeable({@required this.selectedConsumeables, Key? key})
      : super(key: key);

  @override
  State<ManageConsumeable> createState() => _ManageConsumeableState();
}

class _ManageConsumeableState extends State<ManageConsumeable> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController URController = TextEditingController();
  final TextEditingController PRController = TextEditingController();

  GlobalKey<FormState> patchFormKey = GlobalKey<FormState>();

  Color registrationButtonDefaultColor = Color(0xFFD4D4D8);
  Color registrationButtonDisableColor = Color(0xFFD4D4D8);
  Color registrationButtonEnableColor = Color(0xFF157B4F);

  //for enable and disable the registration button based on contains in test from fields
  bool isQuantityTextFormFieldNotEmpty = false;

  @override
  void initState() {
    quantityController.text = widget.selectedConsumeables!.stockQnt.toString();
    URController.text = widget.selectedConsumeables!.UR.toString();
    PRController.text = widget.selectedConsumeables!.PR.toString();
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
    List<String> namepart = widget.selectedConsumeables!.name!.split(" ");
    namepart.length < 2
        ? avatar = namepart[0].substring(0, 1)
        : avatar = namepart[0].substring(0, 1) + namepart[1].substring(0, 1);
    return BlocListener<ConsumablePatchBloc, ConsumablePatchState>(
      listener: (context, state) {
        if (state is ConsumablePatchLoadingState) {
          return AppIndicator.onLoading(context);
        } else if (state is ConsumablePatchSuccessState) {
          log("Manage");
          AppIndicator.popDialogContext();
          ShowToast.message(toastMsg: "Updated!");
          Navigator.pop(context);
        } else if (state is ConsumablePatchFailedState) {
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
                        height: 90,
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
                                      child: Text(
                                        avatar,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Color(0xFF157B4F),
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
                                    "Consumable Name:",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    widget.selectedConsumeables!.name!,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Instock: " +
                                        widget.selectedConsumeables!.stockQnt!
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
                        height: 16.0,
                      ),
                      UnitRateTextFormField(
                          UnitRateNumberController: URController),
                      const SizedBox(
                        height: 16.0,
                      ),
                      PurchaseRateTextFormField(
                          UnitRateNumberController: PRController),
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
      ConsumeablesDetails updatedConsumable = ConsumeablesDetails(
          cId: widget.selectedConsumeables!.cId,
          UR: double.parse(URController.text.toString()),
          PR: double.parse(PRController.text.trim()),
          stockQnt: int.parse(quantityController.text.trim()));

      BlocProvider.of<ConsumablePatchBloc>(context)
          .add(ConsumeablePatchEvent(updateDetails: updatedConsumable));
    }
  }

  bool patchButtonActive() {
    if (isQuantityTextFormFieldNotEmpty) {
      return true;
    }
    return false;
  }
}
