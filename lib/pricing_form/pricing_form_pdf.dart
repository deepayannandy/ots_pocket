import 'dart:io';
import 'package:flutter/services.dart';
import 'package:ots_pocket/pricing_form/widget/certification_widget.dart';
import 'package:ots_pocket/pricing_form/widget/footer_details_widget.dart';
import 'package:ots_pocket/pricing_form/widget/header_widget.dart';
import 'package:ots_pocket/pricing_form/widget/pricing_form_widget_util.dart';
import 'package:ots_pocket/pricing_form/widget/special_provision_widget.dart';
import 'package:ots_pocket/pricing_form/widget/table_header.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';


import '../app_constants.dart';
import '../pdf_methods.dart';

class PricingFormPdf {
  static Future<File> generate() async {
    final pdf = pw.Document();

    final headerImage = (await rootBundle.load('asset/image/clientImage.jpeg'))
        .buffer
        .asUint8List();

    int totalSection = 5;
    List<String> totalSectionHeaders = [
      'Sec.1: LABOR RT SERVICES',
      'Sec.2: EQUIPMENT RT SERVICES',
      'Sec.3: FILM/IMAGES RT SERVICES',
      'Sec. 4: LABOR NDT SERVICES',
      'Sec. 5: EQUIPMENT NDT SERVICES',
    ];

    int totalItemInSection = 7;
    List<String> NDTServiceName = [
      'Traditional RT Crew (Two-Man)',
      'Advanced RT Crew (CRT) (DRT) (XRAY TUBE) (Co60)- Two Man',
      'Advanced RT Level II Technician',
      'Traditional Film RT II Technician',
      'Advanced RT Level I Assistant',
      'Traditional Film RT Level I Assistant',
      'ASNT Level III',
    ];

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.symmetric(vertical: 48.0, horizontal: 32.0),
        pageFormat: PdfPageFormat.a3,
        orientation: pw.PageOrientation.portrait,
        build: (context) => [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              PricingFormWidget().getHeader(imagePath: headerImage),
              HeaderWidget().getHeaderWidget(),
              PricingFormWidget().getSectionLabelWidget(
                  text: "Effective dates: Jan 1,2022 through July 31, 2022",
                  bgColor: PdfColors.white,
                  isTextAlignLeft: true,
                  horizontalPadding: 4.0,
                  verticalPadding: 4.0,
                  borderColor: PdfColors.black,
                  flex: 1),
              TableHeaderWidget().getTableHeaderWidget(
                column1Data: "ITEM",
                column2Data: "NDT Service",
                column3Data: "QTY",
                column4Data: "UOM",
                column5Data: "UNIT RATE (ST)",
                column6Data: "UNIT RATE (OT)",
                column7Data: "UNIT RATE",
                isLable: true,
              ),
              for (var i = 0; i < totalSection; i++) ...[
                PricingFormWidget().getSectionLabelWidget(
                    text: totalSectionHeaders[i],
                    bgColor: PdfColors.grey300,
                    isTextAlignLeft: false,
                    horizontalPadding: 4.0,
                    verticalPadding: 8.0,
                    borderColor: PdfColors.black,
                    flex: 1),
                for (var j = 0; j < totalItemInSection; j++) ...[
                  TableHeaderWidget().getTableHeaderWidget(
                    column1Data: (j + 1).toString(),
                    column2Data: NDTServiceName[j],
                    column3Data: "1",
                    column4Data: "Hr.",
                    column5Data: "\$88.00",
                    column6Data: "\$88.00",
                    column7Data: "",
                    isLable: false,
                  ),
                ],
              ],
              pw.SizedBox(height: 24.0),
              PricingFormWidget().getSectionLabelWidget(
                  text: "SPECIAL PROVISIONS",
                  bgColor: PdfColors.grey300,
                  isTextAlignLeft: true,
                  horizontalPadding: 4.0,
                  verticalPadding: 8.0,
                  borderColor: PdfColors.white,
                  flex: 1),
              SpecialProvisionWidget().getSpecialProvision(),
              pw.SizedBox(height: 16.0),
              pw.Divider(color: PdfColors.black, height: 0.0),
              pw.SizedBox(height: 8.0),
              pw.Divider(color: PdfColors.black, height: 0.0),
              pw.SizedBox(height: 24.0),
              CertificationWidget().getCertificationWidget(),
              pw.SizedBox(height: 16.0),
              FooterDetailsWidget().getFooterDetails(),
            ],
          ),
        ],
      ),
    );

    return PdfMethods.saveDocument(name: AppConstants.pricingForm, pdf: pdf);
  }
}
