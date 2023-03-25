import 'package:pdf/widgets.dart' as pw;

class SpecialProvisionWidget {
  pw.Column getSpecialProvision() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
            " 1. No mark-up added to entertainment, travel, or miscellaneous expenses."),
        pw.Text(
            " 2. No mark-up added to any pass-through cost which may include, but not be limited to, per diem costs, air/hotel/car rental/travel costs, taxes, utilities, courier fees, shipping, freight, or delivery."),
        pw.Text(
            " 3. Third party charges shall clearly state mark-up and the mark-up shall not exceed 10%."),
        pw.Text(" 4. No fuel surcharges."),
        pw.Text(" 5. Mileage will be billed @.85/mile."),
        pw.Text(
            " 6. Mileage and travel apply only when mileage exceeds 30 miles roundtrip or more from local Contractor’s office, warehouse, or maintenance yard."),
        pw.Text(
            ' 7. Per Diem,if necessary, will be determined based on “current GSA rate”.'),
        pw.Text(
            " 8. Overtime billed over 8 hours for daily call-outs. All weekday hours before 6:00 a.m. and after 5:00 p.m. will be considered after hours work for callout services and shall be billed as overtime.Weekends will be billed @ overtime rates. Holidays will be billed @ double time."),
      ],
    );
  }
}
