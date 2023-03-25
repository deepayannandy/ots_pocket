import 'dart:ffi';

class PODetails {
  String? poID;
  String? CustomerID;
  String? JD;
  String? JT;
  String? contact;
  String? address;
  String? contactperson;
  String? poNumber;
  String? timestamp;
  List? wos;
  String? branchID;
  String? email;
  String? typeofpo;
  List? deos;
  String? managerid;

  PODetails(
      {this.poID,
      this.CustomerID,
      this.JD,
      this.JT,
      this.contact,
      this.address,
      this.contactperson,
      this.poNumber,
      this.timestamp,
      this.wos,
      this.branchID,
      this.typeofpo,
      this.deos,
      this.email,
      this.managerid});

  PODetails.fromJson(Map<String, dynamic> json) {
    poID = json['_id'];
    CustomerID = json['CustomerID'];
    JD = json['JD'];
    JT = json['JT'];
    contact = json['contact'];
    address = json['address'];
    contactperson = json['contactperson'];
    poNumber = json['poNumber'];
    timestamp = json['timestamp'];
    wos = json['wos'];
    branchID = json['branchID'];
    typeofpo = json['typeofpo'];
    deos = json['deos'];
    email = json['email'];
    managerid = json['managerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.poID;
    data['CustomerID'] = this.CustomerID;
    data['JD'] = this.JD;
    data['JT'] = this.JT;
    data['contact'] = this.contact;
    data['address'] = this.address;
    data['contactperson'] = this.contactperson;
    data['poNumber'] = this.poNumber;
    data['timestamp'] = this.timestamp;
    data['wos'] = this.wos;
    data['branchID'] = this.branchID;
    data['typeofpo'] = this.typeofpo;
    data['deos'] = this.deos;
    data['email'] = this.email;
    data['managerId'] = this.managerid;
    return data;
  }
}
