import 'package:flutter/material.dart';
import 'package:ots_pocket/pdf_methods.dart';
import 'package:ots_pocket/time_card/time_card_pdf.dart';


import 'daily_customer_timesheet/daily_customer_timesheet_pdf.dart';
import 'invoice/invoice_pdf.dart';
import 'pricing_form/pricing_form_pdf.dart';

class DailyCustomerTimesheet extends StatelessWidget {
  const DailyCustomerTimesheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Daily Customer Timesheet"),
              onPressed: () async {
                // final pdfFile = await DailyCustomerTimesheetPdf.generate();

                // PdfMethods.openFile(pdfFile);
              },
            ),
            const SizedBox(height: 48.0,),
            ElevatedButton(
              child: const Text("Time Card"),
              onPressed: () async {
                final pdfFile = await TimeCardPdf.generate();

                PdfMethods.openFile(pdfFile);
              },
            ),
            const SizedBox(height: 48.0,),
            ElevatedButton(
              child: const Text("Pricing Form"),
              onPressed: () async {
                final pdfFile = await PricingFormPdf.generate();

                PdfMethods.openFile(pdfFile);
              },
            ),
            const SizedBox(height: 48.0,),
            ElevatedButton(
              child: const Text("Invoice Form"),
              onPressed: () async {
                final pdfFile = await InvoicePdf.generate();

                PdfMethods.openFile(pdfFile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
