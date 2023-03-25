import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../report_widget_util.dart';

class InvoiceDetailsWidget {
  pw.Column getInvoiceDetailsWidget() {
    return pw.Column(
      children: [
        getRow(
            col1Data: "Date",
            col2Data: "Invoice#",
            isTextAlignLeft: false,
            isLabelCol1: false,
            isLabelCol2: false),
        getRow(
            col1Data: "10/25/2002",
            col2Data: "18427",
            isTextAlignLeft: false,
            isLabelCol1: false,
            isLabelCol2: true),
        getRow(
            col1Data: "Due Date",
            col2Data: "Terms",
            isTextAlignLeft: false,
            isLabelCol1: false,
            isLabelCol2: false),
        getRow(
            col1Data: "11/24/2022",
            col2Data: "Net 30",
            isTextAlignLeft: false,
            isLabelCol1: false,
            isLabelCol2: false),
      ],
    );
  }
}

pw.Container getRow(
    {required String col1Data,
    required String col2Data,
    required bool isLabelCol1,
    required bool isLabelCol2,
    required bool isTextAlignLeft}) {
  return pw.Container(
    width: 200.0,
    child: pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: col1Data,
                isLable: isLabelCol1,
                flexValue: 3,
                isTextAlignLeft: isTextAlignLeft,
                bgColor: PdfColors.white,
                horizontalPadding: 4.0,
                verticalPadding: 8.0),
            ReportWidgetUtil().getText(
                data: col2Data,
                isLable: isLabelCol2,
                flexValue: 3,
                isTextAlignLeft: isTextAlignLeft,
                bgColor: PdfColors.white,
                horizontalPadding: 4.0,
                verticalPadding: 8.0),
          ],
        ),
      ],
    ),
  );
}
