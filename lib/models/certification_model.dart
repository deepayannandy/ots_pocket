class CertificationModel {
  String? cid;
  String? startdate;
  String? enddate;
  String? employeeid;
  String? employeename;
  String? CertificateName;
  String? Certificateid;
  String? Office;
  String? Department;
  String? Supervisor;

  CertificationModel(
      {this.cid,
      this.startdate,
      this.employeeid,
      this.employeename,
      this.enddate,
      this.CertificateName,
      this.Certificateid,
      this.Office,
      this.Department,
      this.Supervisor});

  CertificationModel.fromJson(Map<String, dynamic> json) {
    cid = json['_id'];
    startdate = json['startdate'];
    employeeid = json['employeeid'];
    employeename = json['employeename'];
    enddate = json['enddate'];
    CertificateName = json['CertificateName'];
    Certificateid = json['Certificateid'];
    Office = json['Office'];
    Department = json['Department'];
    Supervisor = json['Supervisor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.cid;
    data['startdate'] = this.startdate;
    data['employeeid'] = this.employeeid;
    data['employeename'] = this.employeename;
    data['enddate'] = this.enddate;
    data['CertificateName'] = this.CertificateName;
    data['Certificateid'] = this.Certificateid;
    data['Office'] = this.Office;
    data['Department'] = this.Department;
    data['Supervisor'] = this.Supervisor;
    return data;
  }
}
