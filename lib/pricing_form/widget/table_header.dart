import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../../report_widget_util.dart';

class TableHeaderWidget {
  pw.Table getTableHeaderWidget({
    required String column1Data,
    required String column2Data,
    required String column3Data,
    required String column4Data,
    required String column5Data,
    required String column6Data,
    required String column7Data,
    required bool isLable,
  }) {
    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.black),
      children: [
        pw.TableRow(
          children: [
            ReportWidgetUtil().getText(
              data: column1Data,
              isLable: isLable,
              flexValue: 2,
              isTextAlignLeft: false,
              bgColor: PdfColors.white,
              verticalPadding: 8.0,
              horizontalPadding: 4.0,
            ),
            ReportWidgetUtil().getText(
              data: column2Data,
              isLable: isLable,
              flexValue: 14,
              isTextAlignLeft: false,
              bgColor: PdfColors.white,
              verticalPadding: 8.0,
              horizontalPadding: 4.0,
            ),
            ReportWidgetUtil().getText(
              data: column3Data,
              isLable: isLable,
              flexValue: 2,
              isTextAlignLeft: false,
              bgColor: PdfColors.white,
              verticalPadding: 8.0,
              horizontalPadding: 4.0,
            ),
            ReportWidgetUtil().getText(
              data: column4Data,
              isLable: isLable,
              flexValue: 2,
              isTextAlignLeft: false,
              bgColor: PdfColors.white,
              verticalPadding: 8.0,
              horizontalPadding: 4.0,
            ),
            ReportWidgetUtil().getText(
              data: column5Data,
              isLable: isLable,
              flexValue: 4,
              isTextAlignLeft: false,
              bgColor: PdfColors.white,
              verticalPadding: 8.0,
              horizontalPadding: 4.0,
            ),
            ReportWidgetUtil().getText(
              data: column6Data,
              isLable: isLable,
              flexValue: 4,
              isTextAlignLeft: false,
              bgColor: PdfColors.white,
              verticalPadding: 8.0,
              horizontalPadding: 4.0,
            ),
            ReportWidgetUtil().getText(
              data: column7Data,
              isLable: isLable,
              flexValue: 3,
              isTextAlignLeft: false,
              bgColor: PdfColors.white,
              verticalPadding: 8.0,
              horizontalPadding: 4.0,
            ),
          ],
        ),
      ],
    );
  }
}
