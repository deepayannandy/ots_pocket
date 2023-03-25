import 'package:ots_pocket/time_card/widget/time_card_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;


import '../../app_constants.dart';

class GetAllTitleAndBoxWidget {
  pw.Column getGetAllTitleAndBoxWidget() {
    return pw.Column(children: [
      pw.Row(
        children: [
          getTitleAndBoxWidget(
              title: AppConstants.totalStraightHours, isFondBold: true),
          pw.SizedBox(width: 24.0),
          getTitleAndBoxWidget(
              title: AppConstants.totalBillableHours, isFondBold: true),
          pw.SizedBox(width: 24.0),
          getTitleAndBoxWidget(
              title: AppConstants.holidayVacationHours, isFondBold: true),
        ],
      ),
      pw.SizedBox(height: 24.0),
      pw.Row(
        children: [
          getTitleAndBoxWidget(
              title: AppConstants.totalOvertimeHours, isFondBold: true),
          pw.SizedBox(width: 24.0),
          getTitleAndBoxWidget(
              title: AppConstants.totalNonBillableHours, isFondBold: true),
        ],
      ),
      pw.SizedBox(height: 24.0),
      pw.Row(
        children: [
          getTitleAndBoxWidget(
              title: AppConstants.managerSignature, isFondBold: true),
          pw.SizedBox(width: 24.0),
          getTitleAndBoxWidget(title: AppConstants.date, isFondBold: true),
        ],
      ),
    ]);
  }

  pw.Expanded getTitleAndBoxWidget(
      {required String title, required isFondBold}) {
    return pw.Expanded(
      flex: 1,
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.max,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          TimeCardWidgetUtil()
              .getTitleWithFont16(text: title, isFondBold: isFondBold),
          pw.SizedBox(height: 8.0),
          TimeCardWidgetUtil().getBox(),
        ],
      ),
    );
  }
}
