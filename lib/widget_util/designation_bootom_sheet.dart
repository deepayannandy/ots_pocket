import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/laborRate/getLaborRate/get_labor_rate_state.dart';
import 'package:ots_pocket/bloc/laborRate/labourRate_event.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/empty_text_widget.dart';
import 'package:ots_pocket/widget_util/error_text_widget.dart';

import '../bloc/laborRate/getLaborRate/get_labor_rate_bloc.dart';

class designationBottomSheet {
  late GetLaborRateBloc desigBloc;

  void branchBottomSheetDialog(
      {BuildContext? context,
      ValueChanged<String>? onSelectBranchValue,
      String? catagory,}) {
    desigBloc = BlocProvider.of<GetLaborRateBloc>(context!);
    desigBloc.add(GetLaborRateEvent(catagory: catagory!));

    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (builder) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Select your designation",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Color(0xFF000000),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFFD4D4D8),
                    thickness: 1.0,
                  ),
                  BlocBuilder<GetLaborRateBloc, GetLaborRateState>(
                    builder: (context, state) {
                      if (state is GetLaborRateLoadingState) {
                        return AppIndicator.circularProgressIndicator;
                      } else if (state is GetLaborRateEmptyState) {
                        return EmptyTextWidget(
                          emptyMsg:
                              "Sorry! currently designations are not available",
                        );
                      } else if (state is GetLaborRateLoadedState) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.LaborRateList?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      onSelectBranchValue!.call(
                                          "${state.LaborRateList?[index].designation}");
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      child: Text(
                                        "${state.LaborRateList?[index].designation}",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xFF000000),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xFFD4D4D8),
                                    thickness: 1.0,
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      } else if (state is GetLaborRateErrorState) {
                        return ErrorTextWidget(
                          errorMsg: "Something went wrong, Try again",
                        );
                      } else {
                        log("else");
                        return Container();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
