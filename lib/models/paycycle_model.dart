class PayCycle {
  String? id;
  String? startdate;
  String? enddate;
  bool? status;
  int? weekno;

  PayCycle({this.id, this.startdate, this.enddate, this.status, this.weekno});

  PayCycle.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    status = json['status'];
    weekno = json['weekno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['status'] = this.status;
    data['weekno'] = this.weekno;
    return data;
  }
}
