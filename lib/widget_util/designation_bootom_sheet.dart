import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ots_pocket/bloc/branch/branch_bloc.dart';
import 'package:ots_pocket/bloc/branch/branch_event.dart';
import 'package:ots_pocket/bloc/branch/branch_state.dart';
import 'package:ots_pocket/widget_util/app_indicator.dart';
import 'package:ots_pocket/widget_util/empty_text_widget.dart';
import 'package:ots_pocket/widget_util/error_text_widget.dart';

class DesignationBottomSheet {
  List<String> designation = ["Manager", "Employee", "HR"];
  void branchBottomSheetDialog(
      {BuildContext? context, ValueChanged<String>? onSelectBranchValue}) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      context: context!,
      isScrollControlled: true,
      enableDrag: true,
      builder: (builder) {
        return FractionallySizedBox(
          heightFactor: 0.3,
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
                          "Select the designation of the employee",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
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
                  Expanded(
                    child: ListView.builder(
                      itemCount: designation.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                onSelectBranchValue!
                                    .call("${designation[index]}");
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Text(
                                  "${designation[index]}",
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
