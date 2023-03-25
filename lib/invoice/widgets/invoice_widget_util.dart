import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../report_widget_util.dart';

class InvoiceWidgetUtil {
  pw.Row getHeader({required var imagePath}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.start,
      children: [
        ReportWidgetUtil()
            .getJpegImage(imagePath: imagePath, height: 80.0, width: 160.0),
        pw.SizedBox(width: 8.0),
        pw.Text(
          "Dustin K Young\nPresident\ndyoung@t1integrity.com\n281-532-5750\n312 Richey St Pasadena, Texas 77506",
        ),
        pw.Spacer(),
        pw.Text(
          "Invoice",
          style: pw.TextStyle(
            fontSize: 28.0,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }

  pw.Container getText(
      {required String data,
      required bool isLabel,
      required bool isTextAlignLeft}) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      color: PdfColors.white,
      child: pw.Text(
        data,
        textAlign: isTextAlignLeft ? pw.TextAlign.left : pw.TextAlign.center,
        style: pw.TextStyle(
          fontWeight: isLabel ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}
