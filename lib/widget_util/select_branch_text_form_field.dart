import 'package:flutter/material.dart';
import 'package:ots_pocket/widget_util/branch_bootom_sheet.dart';

class SelectBranchTextFormField extends StatelessWidget {
  final TextEditingController? selectBranchController;

  const SelectBranchTextFormField(
      {@required this.selectBranchController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        BranchBottomSheet().branchBottomSheetDialog(
          context: context,
          onSelectBranchValue: (value) {
            selectBranchController?.text = value;
          },
        );
      },
      controller: selectBranchController,
      readOnly: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
        hintText: "TX",
        labelText: "Select Cost Centre",
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Color(0xFF000000),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Cost Centre is required";
        }
        return null;
      },
    );
  }
}
