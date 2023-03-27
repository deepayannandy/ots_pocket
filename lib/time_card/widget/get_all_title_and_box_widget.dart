import 'package:flutter/material.dart';
import 'package:ots_pocket/time_card/widget/time_card_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../app_constants.dart';

class GetAllTitleAndBoxWidget {
  pw.Column getGetAllTitleAndBoxWidget(
      {required String billhr,
      required String holihr,
      required String nonbillhr,
      required String overtime,
      required String date}) {
    return pw.Column(children: [
      pw.Row(
        children: [
          getTitleAndBoxWidget(
              title: AppConstants.totalStraightHours,
              isFondBold: true,
              innertext: "0"),
          pw.SizedBox(width: 24.0, height: 50),
          getTitleAndBoxWidget(
              title: AppConstants.totalBillableHours,
              isFondBold: true,
              innertext: billhr),
          pw.SizedBox(width: 24.0),
          getTitleAndBoxWidget(
              title: AppConstants.holidayVacationHours,
              isFondBold: true,
              innertext: holihr),
        ],
      ),
      pw.SizedBox(height: 24.0),
      pw.Row(
        children: [
          getTitleAndBoxWidget(
              title: AppConstants.totalOvertimeHours,
              isFondBold: true,
              innertext: overtime),
          pw.SizedBox(width: 24.0),
          getTitleAndBoxWidget(
              title: AppConstants.totalNonBillableHours,
              isFondBold: true,
              innertext: nonbillhr),
        ],
      ),
      pw.SizedBox(height: 24.0),
      pw.Row(
        children: [
          getTitleAndBoxWidget(
              title: AppConstants.managerSignature,
              isFondBold: true,
              innertext: ""),
          pw.SizedBox(width: 24.0),
          getTitleAndBoxWidget(
              title: AppConstants.date, isFondBold: true, innertext: date),
        ],
      ),
    ]);
  }

  pw.Expanded getTitleAndBoxWidget(
      {required String title, required String innertext, required isFondBold}) {
    return pw.Expanded(
      flex: 1,
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.max,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          TimeCardWidgetUtil()
              .getTitleWithFont16(text: title, isFondBold: isFondBold),
          pw.SizedBox(height: 8.0),
          TimeCardWidgetUtil().getBox(innertext),
        ],
      ),
    );
  }
}
