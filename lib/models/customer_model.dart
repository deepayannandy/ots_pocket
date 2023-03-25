import 'dart:ffi';

class CustomerDetails {
  String? cId;
  String? Customer;
  String? address;
  String? contactperson;
  String? email;
  String? contact;
  String? fax;
  String? mobile;
  String? branchID;

  CustomerDetails(
      {this.cId,
      this.Customer,
      this.address,
      this.contactperson,
      this.branchID,
      this.email,
      this.contact,
      this.fax,
      this.mobile});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    cId = json['_id'];
    Customer = json['Customer'];
    address = json['address'];
    contactperson = json['contactperson'];
    branchID = json['branchID'];
    email = json['email'];
    contact = json['contact'];
    fax = json['fax'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.cId;
    data['Customer'] = this.Customer;
    data['address'] = this.address;
    data['contactperson'] = this.contactperson;
    data['branchID'] = this.branchID;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['fax'] = this.fax;
    data['mobile'] = this.mobile;
    return data;
  }
}
