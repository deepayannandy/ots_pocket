import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../app_constants.dart';
import '../../report_widget_util.dart';

class EmployeeInfoWidget {
  pw.Column getWidget({required int employeeCount, required List workers}) {
    return pw.Column(
      children: [
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          children: [
            pw.TableRow(
              children: [
                ReportWidgetUtil().getText(
                    data: AppConstants.employeeName + AppConstants.colon,
                    isLable: true,
                    flexValue: 7,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.method,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.startTime,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.endTime,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.stHours,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.otHours,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.travel,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.nonBill,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: AppConstants.notesAndComments,
                    isLable: true,
                    flexValue: 14,
                    isTextAlignLeft: false,
                    bgColor: PdfColors.grey300),
              ],
            ),
            for (var i = 0; i < employeeCount; i++) ...[
              getEmployeeDetailsWidget(workers[i]),
            ],
          ],
        ),
      ],
    );
  }

  pw.TableRow getEmployeeDetailsWidget(List worker) {
    return pw.TableRow(
      children: [
        ReportWidgetUtil().getText(
            data: worker[1],
            isLable: false,
            flexValue: 9,
            isTextAlignLeft: true,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 3,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 3,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 3,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 3,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 3,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 3,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 3,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
        ReportWidgetUtil().getText(
            data: "-",
            isLable: false,
            flexValue: 14,
            isTextAlignLeft: false,
            bgColor: PdfColors.white),
      ],
    );
  }
}
