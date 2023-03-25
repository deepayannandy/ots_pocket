import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../app_constants.dart';
import '../../report_widget_util.dart';

class SignatureWidget {
  pw.Column signatureWidget(String ManagerName) {
    return pw.Column(
      children: [
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          children: [
            pw.TableRow(
              children: [
                ReportWidgetUtil().getText(
                    data: AppConstants.customerName,
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: "",
                    isLable: false,
                    flexValue: 6,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                ReportWidgetUtil().getText(
                    data: AppConstants.customerSignature,
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: "",
                    isLable: false,
                    flexValue: 6,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                ReportWidgetUtil().getText(
                    data: AppConstants.dateService,
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: "",
                    isLable: false,
                    flexValue: 6,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
              ],
            ),
          ],
        ),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black),
          children: [
            pw.TableRow(
              children: [
                ReportWidgetUtil().getText(
                    data: AppConstants.t1IManagerName,
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: ManagerName,
                    isLable: false,
                    flexValue: 6,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                ReportWidgetUtil().getText(
                    data: AppConstants.t1IManagerSignature,
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: "",
                    isLable: false,
                    flexValue: 6,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
                ReportWidgetUtil().getText(
                    data: AppConstants.dateOfApproval,
                    isLable: true,
                    flexValue: 4,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.grey300),
                ReportWidgetUtil().getText(
                    data: "",
                    isLable: false,
                    flexValue: 6,
                    isTextAlignLeft: true,
                    bgColor: PdfColors.white),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
