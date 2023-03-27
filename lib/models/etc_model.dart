class ETCModel {
  String? empname;
  String? start;
  String? end;
  List? cards;
  String? billable;
  String? nonbillable;
  String? hh;

  ETCModel(
      {this.empname,
      this.end,
      this.start,
      this.cards,
      this.billable,
      this.nonbillable,
      this.hh});

  ETCModel.fromJson(Map<String, dynamic> json) {
    empname = json['empname'];
    end = json['end'];
    start = json['start'];
    cards = json['cards'];
    billable = json['billable'];
    nonbillable = json['nonbillable'];
    hh = json['hh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['empname'] = this.empname;
    data['end'] = this.end;
    data['start'] = this.start;
    data['cards'] = this.cards;
    data['billable'] = this.billable;
    data['nonbillable'] = this.nonbillable;
    data['hh'] = this.hh;
    return data;
  }
}
