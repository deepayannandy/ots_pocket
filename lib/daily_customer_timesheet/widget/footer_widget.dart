import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class FooterWidget {
  pw.Row getFooter(String date) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("T1I-Daily Customer Timesheet "),
        pw.SizedBox(width: 16.0),
        pw.Expanded(
          child: pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black),
            children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 4.0),
                    child: pw.Text(
                        "By Signing the above customer timesheet, the client representative is agreeing to the terms and conditions of T1I sales of services. Also by signing, the client representative is agreeing to the above said time, consumables, and travel for the services provided. Invoicing will be rendered as per above time and billed in accordance with current T1I rate sheet unless prior agreement has been made."),
                  ),
                ],
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 32.0),
        pw.Text(date),
      ],
    );
  }
}
