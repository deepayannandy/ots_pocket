import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class ReportWidgetUtil {
  pw.Image getJpegImage(
      {required var imagePath, required double height, required double width}) {
    return pw.Image(pw.MemoryImage(imagePath), height: height, width: width);
  }

  pw.Expanded getText({
    required String data,
    required bool isLable,
    required int flexValue,
    required bool isTextAlignLeft,
    required PdfColor bgColor,
    double? horizontalPadding,
    double? verticalPadding,
  }) {
    return pw.Expanded(
      flex: flexValue,
      child: pw.Container(
        padding: pw.EdgeInsets.symmetric(
            horizontal: horizontalPadding ?? 2.0,
            vertical: verticalPadding ?? 0.0),
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

  pw.Expanded createBlankRow(
      {required String data,
      required int flexValue,
      required PdfColor bgColor}) {
    return pw.Expanded(
      flex: flexValue,
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 2.0),
        color: bgColor,
        child: pw.Text(
          data,
          style: const pw.TextStyle(
            color: PdfColors.white,
          ),
        ),
      ),
    );
  }
}
