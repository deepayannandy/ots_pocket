import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class TimeCardWidgetUtil {
  pw.Text getTitleWithFont22({required String text, required isFondBold}) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 22.0,
        fontWeight: isFondBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }

  pw.Text getTitleWithFont16({required String text, required isFondBold}) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 16.0,
        fontWeight: isFondBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    );
  }

  pw.Text getDateLable({required String text, required String date}) {
    return pw.Text(
      "$text $date",
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.normal,
      ),
    );
  }

  pw.Expanded getText(
      {required String data,
      required bool isLable,
      required int flexValue,
      required bool isTextAlignLeft,
      required PdfColor bgColor}) {
    return pw.Expanded(
      flex: flexValue,
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
        color: bgColor,
        child: pw.Text(
          data,
          textAlign: isTextAlignLeft ? pw.TextAlign.left : pw.TextAlign.center,
          style: pw.TextStyle(
            fontWeight: isLable ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  pw.Container getBox(
    text,
  ) {
    return pw.Container(
      height: 32.0,
      width: 400,
      child: pw.Text(
        "  " + text,
        style: pw.TextStyle(
          fontSize: 20.0,
        ),
      ),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.0, color: PdfColors.black),
      ),
    );
  }
}
