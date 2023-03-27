import 'package:flutter/material.dart';
import 'package:ots_pocket/widget_util/designation_catagory_bootom_sheet.dart';
import 'package:ots_pocket/widget_util/work_shift_bootom_sheet.dart';

class SelectWorkShiftTextFormField extends StatelessWidget {
  final TextEditingController? selectDesignationController;

  const SelectWorkShiftTextFormField(
      {@required this.selectDesignationController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        WorkShiftBottomSheet().branchBottomSheetDialog(
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
        hintText: "Select Shift",
        labelText: "Select Shift",
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Color(0xFF000000),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Shift  is required";
        }
        return null;
      },
    );
  }
}
