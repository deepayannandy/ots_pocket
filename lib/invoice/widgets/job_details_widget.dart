import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../report_widget_util.dart';

class JobDetailsWidget {
  pw.Column getJobDetailsWidget() {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            pw.Column(
              children: [
                getRow(
                  data: "P.O. NO",
                  isTextAlignLeft: false,
                  isLabel: true,
                ),
                getRow(
                  data: "1234567890",
                  isTextAlignLeft: false,
                  isLabel: true,
                ),
              ],
            ),
            pw.Spacer(),
            pw.Column(
              children: [
                getRow(
                  data: "Job NO",
                  isTextAlignLeft: false,
                  isLabel: true,
                ),
                getRow(
                  data: "SCC-107",
                  isTextAlignLeft: false,
                  isLabel: true,
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}

pw.Container getRow({
  required String data,
  required bool isLabel,
  required bool isTextAlignLeft,
}) {
  return pw.Container(
    width: 200.0,
    child: pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
                data: data,
                isLable: isLabel,
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
