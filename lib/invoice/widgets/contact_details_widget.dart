import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../report_widget_util.dart';

class ContactDetailsWidget {
  pw.Column getContactDetailsWidget() {
    return pw.Column(
      children: [
        getRow(
            col1Data: "Phone #",
            col2Data: "E-mail",
            isTextAlignLeftCol1: false,
            isTextAlignLeftCol2: false,
            isLabelCol1: true,
            isLabelCol2: true),
        getRow(
            col1Data: "(281) 532-5750",
            col2Data: "test@gmail.com",
            isTextAlignLeftCol1: false,
            isTextAlignLeftCol2: false,
            isLabelCol1: false,
            isLabelCol2: false),
      ],
    );
  }
}

pw.Container getRow({
  required String col1Data,
  required String col2Data,
  required bool isLabelCol1,
  required bool isLabelCol2,
  required bool isTextAlignLeftCol1,
  required bool isTextAlignLeftCol2,
}) {
  return pw.Container(
    width: 400.0,
    child: pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: col1Data,
                isLable: isLabelCol1,
                flexValue: 3,
                isTextAlignLeft: isTextAlignLeftCol1,
                bgColor: PdfColors.white,
                horizontalPadding: 4.0,
                verticalPadding: 8.0),
            ReportWidgetUtil().getText(
                data: col2Data,
                isLable: isLabelCol2,
                flexValue: 3,
                isTextAlignLeft: isTextAlignLeftCol2,
                bgColor: PdfColors.white,
                horizontalPadding: 4.0,
                verticalPadding: 8.0),
          ],
        ),
      ],
    ),
  );
}
