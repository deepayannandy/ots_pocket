class UserDetails {
  String? sId;
  String? fullname;
  String? mobile;
  String? email;
  String? ssn;
  String? desig;
  String? projid;
  dynamic payrateST;
  dynamic salary;
  String? empBranch;
  bool? active;
  String? password;
  int? iV;
  String? Status;

  UserDetails(
      {this.sId,
      this.fullname,
      this.mobile,
      this.email,
      this.ssn,
      this.desig,
      this.projid,
      this.payrateST,
      this.salary,
      this.empBranch,
      this.active,
      this.password,
      this.iV,
      this.Status,
      required UserDetails userDetails});

  UserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullname = json['fullname'];
    mobile = json['mobile'];
    email = json['email'];
    ssn = json['ssn'];
    desig = json['desig'];
    projid = json['projid'];
    payrateST = json['payrate_ST'];
    salary = json['salary'];
    empBranch = json['empBranch'];
    active = json['active'];
    password = json['password'];
    iV = json['__v'];
    Status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullname'] = this.fullname;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['ssn'] = this.ssn;
    data['desig'] = this.desig;
    data['projid'] = this.projid;
    data['payrate_ST'] = this.payrateST;
    data['salary'] = this.salary;
    data['empBranch'] = this.empBranch;
    data['active'] = this.active;
    data['password'] = this.password;
    data['__v'] = this.iV;
    data['Status'] = this.Status;
    return data;
  }
}
