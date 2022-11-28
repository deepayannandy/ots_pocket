import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/branch/branch_bloc.dart';
import 'package:ots_pocket/bloc/branch/branch_event.dart';
import 'package:ots_pocket/bloc/branch/branch_state.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/empty_text_widget.dart';
import 'package:ots_pocket/widget_util/error_text_widget.dart';

class BranchBottomSheet {
  late BranchBloc branchBloc;

  void branchBottomSheetDialog(
      {BuildContext? context, ValueChanged<String>? onSelectBranchValue}) {
    branchBloc = BlocProvider.of<BranchBloc>(context!);
    branchBloc.add(GetBranchEvent());

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
                          "Select Cost Centre",
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
                  BlocBuilder<BranchBloc, BranchState>(
                    builder: (context, state) {
                      if (state is BranchLoadingState) {
                        return AppIndicator.circularProgressIndicator;
                      } else if (state is BranchEmptyState) {
                        return EmptyTextWidget(
                          emptyMsg:
                              "Sorry! currently branches are not available",
                        );
                      } else if (state is BranchLoadedState) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.branchList?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      onSelectBranchValue!.call(
                                          "${state.branchList?[index].branchname}");
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 16.0),
                                      child: Text(
                                        "${state.branchList?[index].branchname}",
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
                      } else if (state is BranchErrorState) {
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
