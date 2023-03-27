import 'package:ots_pocket/time_card/widget/time_card_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../app_constants.dart';

class TimeCardDetailsWidget {
  pw.Column getWidget({
    required List carddata,
    required String totalpo,
    required String totalnopo,
  }) {
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
            for (var i = 0; i < carddata.length; i++) ...[
              getEmployeeDetailsWidget(carddata[i]),
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
                    data: totalpo,
                    isLable: true,
                    flexValue: 3,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                TimeCardWidgetUtil().getText(
                    data: totalnopo,
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

pw.TableRow getEmployeeDetailsWidget(List data) {
  return pw.TableRow(
    children: [
      TimeCardWidgetUtil().getText(
          data: data[0].toString(),
          isLable: false,
          flexValue: 4,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: data[1].toString(),
          isLable: false,
          flexValue: 4,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: data[2].toString(),
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: data[3].toString(),
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: data[4].toString(),
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: data[5].toString(),
          isLable: false,
          flexValue: 2,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: data[6].toString(),
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
      TimeCardWidgetUtil().getText(
          data: data[7].toString(),
          isLable: false,
          flexValue: 3,
          isTextAlignLeft: true,
          bgColor: PdfColors.white),
    ],
  );
}
