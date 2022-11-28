class Branch {
  String? sId;
  String? address;
  String? branchname;
  String? contact;

  Branch({this.sId, this.address, this.branchname, this.contact});

  Branch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address = json['address'];
    branchname = json['branchname'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['address'] = this.address;
    data['branchname'] = this.branchname;
    data['contact'] = this.contact;
    return data;
  }
}