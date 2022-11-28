class UserRegistration {
  String? fullname;
  String? mobile;
  String? email;
  String? ssn;
  String? empBranch;
  String? password;
  String? desig;
  String? projid;

  UserRegistration(
      {this.fullname,
        this.mobile,
        this.email,
        this.ssn,
        this.empBranch,
        this.password,
        this.desig,
        this.projid});

  UserRegistration.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    mobile = json['mobile'];
    email = json['email'];
    ssn = json['ssn'];
    empBranch = json['empBranch'];
    password = json['password'];
    desig = json['desig'];
    projid = json['projid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['ssn'] = this.ssn;
    data['empBranch'] = this.empBranch;
    data['password'] = this.password;
    data['desig'] = this.desig;
    data['projid'] = this.projid;
    return data;
  }
}