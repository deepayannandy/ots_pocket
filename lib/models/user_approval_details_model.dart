class UserApprovalDetails {
  String? sId;
  dynamic payrateST;
  dynamic salary;
  String? desig;
  bool? active;
  String? projid;
  String? Status;
  String? StatusBg;

  UserApprovalDetails({
    this.sId,
    this.payrateST,
    this.salary,
    this.desig,
    this.projid,
    this.active,
    this.Status,
    this.StatusBg,
  });

  UserApprovalDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    payrateST = json['payrate_ST'];
    salary = json['salary'];
    active = json['active'];
    projid = json['projid'];
    desig = json['desig'];
    Status = json["Status"];
    StatusBg = json["StatusBg"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['payrate_ST'] = this.payrateST;
    data['salary'] = this.salary;
    data['projid'] = this.projid;
    data['active'] = this.active;
    data['desig'] = this.desig;
    data['Status'] = this.Status;
    data['StatusBg'] = this.StatusBg;
    return data;
  }
}
