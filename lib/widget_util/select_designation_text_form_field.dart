import 'package:flutter/material.dart';
import 'package:ots_pocket/widget_util/branch_bootom_sheet.dart';

import 'designation_bootom_sheet.dart';

class SelectDesignationTextFormField extends StatelessWidget {
  final TextEditingController? selectBranchController;
  final String catagory;

  const SelectDesignationTextFormField(
      {@required this.selectBranchController, Key? key, required this.catagory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        designationBottomSheet().branchBottomSheetDialog(
          context: context,
          catagory: catagory,
          onSelectBranchValue: (value) {
            selectBranchController?.text = value;
          },
        );
      },
      controller: selectBranchController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        hintText: "Manager",
        labelText: "Select Designation",
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Color(0xFF000000),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Designation is required";
        }
        return null;
      },
    );
  }
}
