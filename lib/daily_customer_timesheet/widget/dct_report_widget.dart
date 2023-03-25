import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../app_constants.dart';
import '../../report_widget_util.dart';

class DailyCustomerTimesheetWidget {
  pw.Row getHeader({required var imagePath}) {
    return pw.Row(
      children: [
        ReportWidgetUtil()
            .getJpegImage(imagePath: imagePath, height: 80.0, width: 160.0),
        pw.Spacer(),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "312 Richey St. Pasadena, TX 77506",
              style: pw.TextStyle(
                color: PdfColors.grey500,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              "${AppConstants.letterP}${AppConstants.colon} "
              " ${AppConstants.officeContactNumber} "
              " ${AppConstants.fullStop} "
              " ${AppConstants.letterF}${AppConstants.colon} "
              " ${AppConstants.officeFaxNumber} "
              " ${AppConstants.fullStop} "
              " ${AppConstants.officeEmailNumber}",
              style: pw.TextStyle(
                color: PdfColors.grey500,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }

  pw.Row getTitle(String Po) {
    return pw.Row(
      children: [
        pw.Spacer(),
        pw.Text(
          AppConstants.customerTimesheetTitle.replaceFirst(".pdf", ""),
          textAlign: pw.TextAlign.left,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 22.0),
        ),
        pw.Spacer(),
        pw.Table(border: pw.TableBorder.all(color: PdfColors.black), children: [
          pw.TableRow(children: [
            pw.Container(
              color: PdfColors.grey300,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: pw.Text(
                Po,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            )
          ])
        ]),
      ],
    );
  }

  pw.Table getCompanyAndProjectInfo(
      {required String lable1,
      required String content1,
      required String lable2,
      required String content2}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: lable1,
                isLable: true,
                flexValue: 2,
                isTextAlignLeft: true,
                bgColor: PdfColors.grey300),
            ReportWidgetUtil().getText(
                data: content1,
                isLable: false,
                flexValue: 4,
                isTextAlignLeft: true,
                bgColor: PdfColors.white),
            ReportWidgetUtil().getText(
                data: lable2,
                isLable: true,
                flexValue: 2,
                isTextAlignLeft: true,
                bgColor: PdfColors.grey300),
            ReportWidgetUtil().getText(
                data: content2,
                isLable: false,
                flexValue: 4,
                isTextAlignLeft: true,
                bgColor: PdfColors.white),
          ],
        ),
      ],
    );
  }

  pw.Widget getTableTitle({required String title, required PdfColor bgColor}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: title,
                isLable: true,
                flexValue: 1,
                isTextAlignLeft: false,
                bgColor: bgColor),
          ],
        ),
      ],
    );
  }

  pw.Widget getTableHeader(
      {required String columnName1, required String columnName2}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: columnName1,
                isLable: true,
                flexValue: 15,
                isTextAlignLeft: false,
                bgColor: PdfColors.white),
            ReportWidgetUtil().getText(
                data: columnName2,
                isLable: true,
                flexValue: 6,
                isTextAlignLeft: false,
                bgColor: PdfColors.white),
          ],
        ),
      ],
    );
  }

  pw.Widget getTableContent(
      {required String itemDescription,
      required String quantity,
      required PdfColor bgColor}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: itemDescription,
                isLable: false,
                flexValue: 15,
                isTextAlignLeft: true,
                bgColor: bgColor),
            ReportWidgetUtil().getText(
                data: quantity,
                isLable: false,
                flexValue: 6,
                isTextAlignLeft: false,
                bgColor: bgColor),
          ],
        ),
      ],
    );
  }

  pw.Widget getTableContentWithQuantityInTwoPartition(
      {required String itemDescription,
      required String quantity,
      required PdfColor bgColor}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: itemDescription,
                isLable: false,
                flexValue: 12,
                isTextAlignLeft: true,
                bgColor: bgColor),
            ReportWidgetUtil().getText(
                data: quantity,
                isLable: false,
                flexValue: 2,
                isTextAlignLeft: false,
                bgColor: bgColor),
            ReportWidgetUtil().getText(
                data: quantity,
                isLable: false,
                flexValue: 2,
                isTextAlignLeft: false,
                bgColor: bgColor),
          ],
        ),
      ],
    );
  }

  pw.Widget getTableBlankRow(
      {required String title, required PdfColor bgColor}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil()
                .createBlankRow(data: title, flexValue: 1, bgColor: bgColor),
          ],
        ),
      ],
    );
  }
}
