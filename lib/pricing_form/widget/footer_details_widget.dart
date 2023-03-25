import 'package:ots_pocket/pricing_form/widget/pricing_form_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class FooterDetailsWidget {
  pw.Column getFooterDetails() {
    return pw.Column(
      children: [
        pw.Row(
          children: [
            getTitleAndBoxWidget(
                title: "COMPANY NAME:", labelFlexValue: 1, boxFlexValue: 4),
          ],
        ),
        pw.SizedBox(height: 4.0),
        pw.Row(
          children: [
            getTitleAndBoxWidget(
                title: "ADDRESS:", labelFlexValue: 2, boxFlexValue: 3),
            pw.SizedBox(width: 64.0),
            getTitleAndBoxWidget(
                title: "DATE SIGNED:", labelFlexValue: 2, boxFlexValue: 3),
          ],
        ),
        pw.SizedBox(height: 4.0),
        pw.Row(
          children: [
            getTitleAndBoxWidget(
                title: "SIGNATURE:", labelFlexValue: 2, boxFlexValue: 3),
            pw.SizedBox(width: 64.0),
            getTitleAndBoxWidget(
                title: "TITLE:", labelFlexValue: 2, boxFlexValue: 3),
          ],
        ),
        pw.SizedBox(height: 4.0),
        pw.Row(
          children: [
            getTitleAndBoxWidget(
                title: "PRINT NAME:", labelFlexValue: 2, boxFlexValue: 3),
            pw.SizedBox(width: 64.0),
            getTitleAndBoxWidget(
                title: "PHONE NUMBER:", labelFlexValue: 2, boxFlexValue: 3),
          ],
        ),
      ],
    );
  }

  pw.Expanded getTitleAndBoxWidget(
      {required String title,
      required int labelFlexValue,
      required int boxFlexValue}) {
    return pw.Expanded(
      flex: 1,
      child: pw.Row(
        children: [
          PricingFormWidget().getLable(flexValue: labelFlexValue, text: title),
          pw.SizedBox(width: 8.0),
          PricingFormWidget().getInputBox(
              flexValue: boxFlexValue,
              inputBoxHeight: 32.0,
              borderColor: PdfColors.white),
        ],
      ),
    );
  }
}
