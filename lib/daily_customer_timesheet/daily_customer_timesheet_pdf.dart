import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/company_and_project_info_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/dct_report_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/employee_info_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/footer_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/item_table_first_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/item_table_second_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/item_table_third_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/remarks_widget.dart';
import 'package:ots_pocket/daily_customer_timesheet/widget/signature_widget.dart';
import 'package:ots_pocket/models/daily_Customer_sheet.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../app_constants.dart';
import '../pdf_methods.dart';

class DailyCustomerTimesheetPdf {
  static Future<File> generate(DailyCustomerSheet sheet, String remarks) async {
    final pdf = pw.Document();

    final headerImage = (await rootBundle.load('asset/images/clientImage.jpeg'))
        .buffer
        .asUint8List();

    int totalEmployee = sheet.workers!.length;

    int createPdfCount = (totalEmployee / 6).ceil();
    log("createPdfCount: $createPdfCount");

    List<int>? maxSixEmployee = count(totalEmployee);
    log("maxSixEmployee: $maxSixEmployee");
    for (int i = 0; i < createPdfCount; i++) {
      pdf.addPage(
        pw.MultiPage(
          margin:
              const pw.EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
          pageFormat: PdfPageFormat.a3,
          orientation: pw.PageOrientation.portrait,
          build: (context) => [
            pw.Column(
              children: [
                DailyCustomerTimesheetWidget()
                    .getHeader(imagePath: headerImage),
                pw.Divider(thickness: 1.0, color: PdfColors.black),
                pw.SizedBox(height: 4.0),
                DailyCustomerTimesheetWidget()
                    .getTitle(sheet.woname.toString()),
                pw.SizedBox(height: 8.0),
                CompanyAndProjectInfoWidget().getWidget(
                    sheet.clientname.toString(),
                    sheet.address.toString(),
                    sheet.jt.toString(),
                    sheet.ContactPerson.toString(),
                    sheet.date.toString().split("T")[0],
                    sheet.poname.toString()),
                EmployeeInfoWidget().getWidget(
                    employeeCount: maxSixEmployee![i], workers: sheet.workers!),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(
                      children: [
                        ItemTableFirst().getItem(sheet.consumables!, i),
                        ItemTableSecond().getItem(sheet.equipments!, i),
                        ItemTableThird().getItem(),
                      ],
                    ),
                  ],
                ),
                RemarksWidget().getRemarksWidget(
                    remarksHeader: AppConstants.remarks + AppConstants.colon,
                    remarksText: remarks),
                SignatureWidget().signatureWidget(sheet.Manager!),
                pw.SizedBox(height: 24.0),
                pw.Divider(thickness: 1.0, color: PdfColors.black),
                FooterWidget().getFooter(sheet.date.toString().split("T")[0]),
              ],
            ),
          ],
        ),
      );
    }
    return PdfMethods.saveDocument(
        name: AppConstants.customerTimesheetTitle, pdf: pdf);
  }

  static List<int>? count(int employeeCount) {
    List<int> maxSixEmployee = [];

    for (int i = 0; i < (employeeCount / 6).floor(); i++) {
      maxSixEmployee.add(6);
    }
    maxSixEmployee.add((employeeCount % 6));
    log("maxSixEmployee $maxSixEmployee");

    return maxSixEmployee;
  }
}
