import 'package:flutter/material.dart';
import 'package:ots_pocket/widget_util/designation_catagory_bootom_sheet.dart';

class SelectDesignationCatTextFormField extends StatelessWidget {
  final TextEditingController? selectDesignationController;

  const SelectDesignationCatTextFormField(
      {@required this.selectDesignationController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        DesignationCatagoryBottomSheet().branchBottomSheetDialog(
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
        hintText: "Category",
        labelText: "Select services",
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
