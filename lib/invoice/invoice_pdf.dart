import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ots_pocket/invoice/widgets/bill_to_widget.dart';
import 'package:ots_pocket/invoice/widgets/contact_details_widget.dart';
import 'package:ots_pocket/invoice/widgets/invoice_details_widget.dart';
import 'package:ots_pocket/invoice/widgets/invoice_table_header.dart';
import 'package:ots_pocket/invoice/widgets/invoice_widget_util.dart';
import 'package:ots_pocket/invoice/widgets/job_details_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../pdf_methods.dart';

class InvoicePdf {
  static Future<File> generate() async {
    final pdf = pw.Document();

    final headerImage = (await rootBundle.load('asset/image/clientImage.jpeg'))
        .buffer
        .asUint8List();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
        pageFormat: PdfPageFormat.a3,
        orientation: pw.PageOrientation.portrait,
        build: (context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              InvoiceWidgetUtil().getHeader(imagePath: headerImage),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: InvoiceDetailsWidget().getInvoiceDetailsWidget(),
              ),
              BillToWidget().getBillToWidget(),
              pw.SizedBox(height: 48.0),
              JobDetailsWidget().getJobDetailsWidget(),
              InvoiceTableHeaderWidget().getInvoiceTableHeaderWidget(
                column1Data: "Serviced",
                column2Data: "Item",
                column3Data: "Description",
                column4Data: "Quantity",
                column5Data: "Rate",
                column6Data: "Amount",
                isLable: true,
                bgColor: PdfColors.grey300,
              ),
              for (var j = 0; j < 15; j++) ...[
                InvoiceTableHeaderWidget().getInvoiceTableHeaderWidget(
                  column1Data: (j + 1).toString(),
                  column2Data: "Mileage",
                  column3Data: "Mileage",
                  column4Data: "40",
                  column5Data: "56.00",
                  column6Data: "22400.00",
                  isLable: false,
                  bgColor: j % 2 == 0 ? PdfColors.white : PdfColors.grey300,
                ),
              ],
              InvoiceTableHeaderWidget().getInvoiceTableHeaderWidget(
                  column1Data: "",
                  column2Data: "",
                  column3Data: "",
                  column4Data: "",
                  column5Data: "Total",
                  column6Data: "\$2222222",
                  isLable: true,
                  bgColor: PdfColors.white,
                  verticalPadding: 16.0),
              ContactDetailsWidget().getContactDetailsWidget(),
            ],
          ),
        ],
      ),
    );
    return PdfMethods.saveDocument(name: "Invoice", pdf: pdf);
  }
}
