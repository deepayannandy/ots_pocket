import 'package:ots_pocket/time_card/widget/time_card_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../app_constants.dart';


class TimeCardDetailsWidget {
  pw.Column getWidget() {
    return pw.Column(
      children: [
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          children: [
            pw.TableRow(
              children: [
                TimeCardWidgetUtil().getText(
                    data: "Date",
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "OPN Work",
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "Company",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: AppConstants.stHours,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "No Bill",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "PO",
                    isLable: true,
                    flexValue: 2,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "Pocedure",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "Job Status",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
              ],
            ),
            for (var i = 0; i < 14; i++) ...[
              getEmployeeDetailsWidget(),
            ],
            pw.TableRow(
              children: [
                TimeCardWidgetUtil().getText(
                    data: "",
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "",
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "Total",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "123.00",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "0.00",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "",
                    isLable: true,
                    flexValue: 2,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: "",
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

pw.TableRow getEmployeeDetailsWidget() {
  return pw.TableRow(
    children: [
      TimeCardWidgetUtil().getText(
          data: "04/12/2022",
          isLable: false,
          flexValue: 4,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: "T1I22-PLV-0088-00",
          isLable: false,
          flexValue: 4,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: "Formosa",
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: "12:00",
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: "",
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: "OL2",
          isLable: false,
          flexValue: 2,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: "",
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: "Complete",
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
    ],
  );
}
