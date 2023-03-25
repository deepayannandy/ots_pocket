import 'package:ots_pocket/pricing_form/widget/pricing_form_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class CertificationWidget {
  pw.Table getCertificationWidget() {
    return pw.Table(
      children: [
        pw.TableRow(
          children: [
            PricingFormWidget().getInputBox(
                flexValue: 1,
                inputBoxHeight: 48.0,
                borderColor: PdfColors.black),
            pw.SizedBox(width: 16.0),
            PricingFormWidget().getLable(
                flexValue: 2,
                text:
                    "CERTIFICATION. I certify that I have read, understand and agree with the conditions within the RFP. (Add Signature Below)"),
          ],
        )
      ],
    );
  }
}
