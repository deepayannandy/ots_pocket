import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class RemarksWidget{
  pw.Widget getRemarksWidget(
      {required String remarksHeader, required String remarksText}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
              const pw.EdgeInsets.symmetric(horizontal: 2.0,),
              child: pw.RichText(
                text: pw.TextSpan(
                  children: [
                    pw.TextSpan(
                      text: remarksHeader,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.TextSpan(
                      text: remarksText,
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}