class TimecardData {
  String? Id;
  String? submitdate;
  String? empid;
  String? empname;
  String? shift;
  String? starttime;
  String? endtime;
  String? status;
  String? po;
  String? wo;
  dynamic st;
  dynamic ot;
  dynamic tt;
  dynamic hh;
  String? ap_date;
  String? costcenter;

  TimecardData(
      {this.Id,
      this.ap_date,
      this.empid,
      this.empname,
      this.endtime,
      this.ot,
      this.po,
      this.shift,
      this.hh,
      this.st,
      this.starttime,
      this.status,
      this.submitdate,
      this.tt,
      this.costcenter,
      this.wo});

  TimecardData.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    submitdate = json['submitdate'];
    empid = json['empid'];
    empname = json['empname'];
    shift = json['shift'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    status = json['status'];
    po = json['po'];
    wo = json['wo'];
    st = json['st'];
    ot = json['ot'];
    tt = json['tt'];
    hh = json['hh'];
    costcenter = json['costcenter'];
    ap_date = json['ap_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.Id;
    data['submitdate'] = this.submitdate;
    data['empid'] = this.empid;
    data['empname'] = this.empname;
    data['shift'] = this.shift;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['status'] = this.status;
    data['po'] = this.po;
    data['wo'] = this.wo;
    data['st'] = this.st;
    data['ot'] = this.ot;
    data['tt'] = this.tt;
    data['hh'] = this.hh;
    data['costcenter'] = this.costcenter;
    data['ap_date'] = this.ap_date;

    return data;
  }
}
