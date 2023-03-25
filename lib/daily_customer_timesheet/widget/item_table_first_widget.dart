import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import '../../app_constants.dart';
import 'dct_report_widget.dart';

class ItemTableFirst {
  pw.Widget getItem(List items, int index) {
    return pw.Column(
      children: [
        DailyCustomerTimesheetWidget().getTableTitle(
            title: AppConstants.itemCategory_1, bgColor: PdfColors.white),
        DailyCustomerTimesheetWidget().getTableHeader(
            columnName1: AppConstants.itemDescription,
            columnName2: AppConstants.quantity),
        for (var item in items)
          DailyCustomerTimesheetWidget().getTableContent(
              itemDescription: item[0],
              quantity: index == 0 ? item[1] : "-",
              bgColor: PdfColors.white),
      ],
    );
  }
}
