import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';


import '../../report_widget_util.dart';

class PricingFormWidget {
  pw.Table getHeader({required var imagePath}) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            pw.Padding(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  ReportWidgetUtil().getJpegImage(
                      imagePath: imagePath, height: 80.0, width: 160.0),
                  pw.Text(
                    "PRICING FORM",
                    style: pw.TextStyle(
                      fontSize: 24.0,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Expanded getTableHeaderText(
      {required int flexValue, required String text, required bool isTitle}) {
    return pw.Expanded(
      flex: flexValue,
      child: pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
        child: pw.Text(text),
      ),
    );
  }

  pw.Expanded getLable({required int flexValue, required String text}) {
    return pw.Expanded(
      flex: flexValue,
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontSize: 16.0,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Expanded getInputBox(
      {required int flexValue,
      required double inputBoxHeight,
      required PdfColor borderColor}) {
    return pw.Expanded(
      flex: flexValue,
      child: pw.Container(
        height: inputBoxHeight,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: borderColor),
          color: PdfColors.yellow100,
        ),
      ),
    );
  }

  pw.Table getSectionLabelWidget({
    required String text,
    required double horizontalPadding,
    required double verticalPadding,
    required PdfColor bgColor,
    required bool isTextAlignLeft,
    required PdfColor borderColor,
    required int flex,
  }) {
    return pw.Table(
      border: pw.TableBorder.all(color: borderColor),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
              data: text,
              isLable: false,
              flexValue: flex,
              isTextAlignLeft: isTextAlignLeft,
              bgColor: bgColor,
              verticalPadding: horizontalPadding,
              horizontalPadding: verticalPadding,
            ),
          ],
        ),
      ],
    );
  }
}
