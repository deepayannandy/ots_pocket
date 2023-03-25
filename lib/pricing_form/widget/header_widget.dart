import 'package:ots_pocket/pricing_form/widget/pricing_form_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';


class HeaderWidget {
  pw.Row getHeaderWidget() {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            mainAxisSize: pw.MainAxisSize.max,
            children: [
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  pw.TableRow(
                    children: [
                      PricingFormWidget().getTableHeaderText(
                          text: "CLIENT NAME:",
                          flexValue: 1,
                          isTitle: true),
                      PricingFormWidget().getTableHeaderText(
                          text: "Call-Out Rates",
                          flexValue: 1,
                          isTitle: false),
                    ],
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  pw.TableRow(
                    children: [
                      PricingFormWidget().getTableHeaderText(
                          text: "SCOPE OF WORK:",
                          flexValue: 1,
                          isTitle: true),
                      PricingFormWidget().getTableHeaderText(
                          text: "NDT/ (AIS)Inspection",
                          flexValue: 1,
                          isTitle: false),
                    ],
                  ),
                ],
              ),
              pw.Table(
                border: pw.TableBorder.all(color: PdfColors.black),
                children: [
                  pw.TableRow(
                    children: [
                      PricingFormWidget().getTableHeaderText(
                          text: "PROJECT LOCATION:",
                          flexValue: 1,
                          isTitle: true),
                      PricingFormWidget().getTableHeaderText(
                          text: "Texas",
                          flexValue: 1,
                          isTitle: false),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.Table(
            border: pw.TableBorder.all(color: PdfColors.black),
            children: [
              pw.TableRow(
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 4.0),
                    color: PdfColors.yellow100,
                    child: pw.Column(
                      mainAxisSize: pw.MainAxisSize.max,
                      children: [
                        pw.Text(
                          "Dustin K Young \n President \n dyoung@t1integrity.com \n 281-532-5750",
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 8.0),
                        pw.Text("312 Richey St Pasadena, Texas 77506",
                            textAlign: pw.TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}