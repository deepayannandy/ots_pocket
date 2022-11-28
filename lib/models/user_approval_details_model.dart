class UserApprovalDetails {
  String? sId;
  dynamic payrateST;
  dynamic salary;
  String? desig;
  bool? active;
  String? projid;

  UserApprovalDetails({
    this.sId,
    this.payrateST,
    this.salary,
    this.desig,
    this.projid,
    this.active,
  });

  UserApprovalDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    payrateST = json['payrate_ST'];
    salary = json['salary'];
    active = json['active'];
    projid = json['projid'];
    desig = json['desig'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['payrate_ST'] = this.payrateST;
    data['salary'] = this.salary;
    data['projid'] = this.projid;
    data['active'] = this.active;
    data['desig'] = this.desig;
    return data;
  }
}
