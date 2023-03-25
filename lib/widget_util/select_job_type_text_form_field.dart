import 'package:flutter/material.dart';
import 'package:ots_pocket/widget_util/designation_catagory_bootom_sheet.dart';

import 'job_type_bootom_sheet copy.dart';

class SelectJobTypeTextFormField extends StatelessWidget {
  final TextEditingController? selectJobTypeController;

  const SelectJobTypeTextFormField(
      {@required this.selectJobTypeController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        JobTypeBottomSheet().branchBottomSheetDialog(
          context: context,
          onSelectBranchValue: (value) {
            selectJobTypeController?.text = value;
          },
        );
      },
      controller: selectJobTypeController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        hintText: "Job Type",
        labelText: "Select Job Type",
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Color(0xFF000000),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Employee designation is required";
        }
        return null;
      },
    );
  }
}
