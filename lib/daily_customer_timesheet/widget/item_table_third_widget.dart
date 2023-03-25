import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../app_constants.dart';
import 'dct_report_widget.dart';

class ItemTableThird {
  pw.Widget getItem() {
    return pw.Column(
      children: [
        DailyCustomerTimesheetWidget().getTableTitle(
            title: AppConstants.itemCategory_3, bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableHeader(
            columnName1: AppConstants.itemDescription,
            columnName2: AppConstants.quantity),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_41,
            quantity: "-",
            bgColor: PdfColors.yellow100),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_42,
            quantity: "-",
            bgColor: PdfColors.yellow100),
        DailyCustomerTimesheetWidget()
            .getTableContentWithQuantityInTwoPartition(
                itemDescription: AppConstants.item_43,
                quantity: "-",
                bgColor: PdfColors.yellow100),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_44,
            quantity: "-",
            bgColor: PdfColors.yellow100),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_45,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_46,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_47,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget()
            .getTableContentWithQuantityInTwoPartition(
                itemDescription: AppConstants.item_48,
                quantity: "-",
                bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget()
            .getTableBlankRow(title: "blank row", bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_49,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_50,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_51,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_52,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_53,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableTitle(
            title: "Client Time Summary", bgColor: PdfColors.grey300),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_54,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_55,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_56,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_57,
            quantity: "-",
            bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableContent(
            itemDescription: AppConstants.item_58,
            quantity: "-",
            bgColor: PdfColors.white),
      ],
    );
  }
}
