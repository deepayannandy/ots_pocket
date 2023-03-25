import 'package:ots_pocket/daily_customer_timesheet/widget/dct_report_widget.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../app_constants.dart';

class CompanyAndProjectInfoWidget {
  pw.Column getWidget(String Clientname, String Address, String ProjectInfo,
      String ContactPerson, String Date, String Po) {
    return pw.Column(
      children: [
        DailyCustomerTimesheetWidget().getCompanyAndProjectInfo(
            lable1: AppConstants.companyName + AppConstants.colon,
            content1: Clientname,
            lable2: AppConstants.contactPerson + AppConstants.colon,
            content2: ContactPerson),
        DailyCustomerTimesheetWidget().getCompanyAndProjectInfo(
            lable1: AppConstants.customerAddress + AppConstants.colon,
            content1: Address,
            lable2: AppConstants.dateOfService + AppConstants.colon,
            content2: Date),
        DailyCustomerTimesheetWidget().getCompanyAndProjectInfo(
            lable1: AppConstants.projectInformation + AppConstants.colon,
            content1: ProjectInfo,
            lable2: "${AppConstants.purchaseOrder} "
                " ${AppConstants.hash}${AppConstants.colon}",
            content2: Po),
      ],
    );
  }
}
