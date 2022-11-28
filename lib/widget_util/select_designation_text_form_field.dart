import 'package:flutter/material.dart';
import 'package:ots_pocket/widget_util/designation_bootom_sheet.dart';

class SelectDesignationTextFormField extends StatelessWidget {
  final TextEditingController? selectDesignationController;

  const SelectDesignationTextFormField(
      {@required this.selectDesignationController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        DesignationBottomSheet().branchBottomSheetDialog(
          context: context,
          onSelectBranchValue: (value) {
            selectDesignationController?.text = value;
          },
        );
      },
      controller: selectDesignationController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        hintText: "Employee",
        labelText: "Select employee designation",
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
