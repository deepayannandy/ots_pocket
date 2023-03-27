import 'package:fluttertoast/fluttertoast.dart';
import 'package:ots_pocket/models/etc_model.dart';
import 'package:ots_pocket/time_card/time_card_details.dart';
import 'package:ots_pocket/time_card/widget/get_all_title_and_box_widget.dart';
import 'package:ots_pocket/time_card/widget/time_card_widget_util.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'dart:io';

import '../app_constants.dart';
import '../pdf_methods.dart';

class TimeCardPdf {
  static Future<File> generate(ETCModel tcdata) async {
    double totaltime =
        (double.parse(tcdata.billable!) + double.parse(tcdata.nonbillable!));
    // Fluttertoast.showToast(msg: totaltime.toString());
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
        pageFormat: PdfPageFormat.a3,
        orientation: pw.PageOrientation.portrait,
        build: (context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              TimeCardWidgetUtil().getTitleWithFont22(
                  text: tcdata.empname.toString(), isFondBold: true),
              pw.SizedBox(height: 24.0),
              TimeCardWidgetUtil().getDateLable(
                  text: "Start Date for Time Card",
                  date: tcdata.start.toString()),
              pw.SizedBox(height: 16.0),
              TimeCardWidgetUtil().getDateLable(
                  text: "End Date for Time Card", date: tcdata.end.toString()),
              pw.SizedBox(height: 24.0),
              TimeCardWidgetUtil()
                  .getTitleWithFont22(text: "Time Card", isFondBold: false),
              pw.SizedBox(height: 8.0),
              TimeCardDetailsWidget().getWidget(
                carddata: tcdata.cards!.toList(),
                totalpo: tcdata.billable.toString(),
                totalnopo: tcdata.nonbillable.toString(),
              ),
              pw.SizedBox(height: 32.0),
              GetAllTitleAndBoxWidget().getGetAllTitleAndBoxWidget(
                  billhr: tcdata.billable.toString(),
                  date: DateTime.now().toString().split(" ")[0],
                  nonbillhr: tcdata.nonbillable.toString(),
                  holihr: tcdata.hh.toString(),
                  overtime:
                      totaltime > 120 ? (totaltime - 120).toString() : "0"),
            ],
          ),
        ],
      ),
    );
    return PdfMethods.saveDocument(name: "timecard.pdf", pdf: pdf);
  }
}
