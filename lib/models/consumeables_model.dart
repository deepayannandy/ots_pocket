import 'dart:ffi';

class ConsumeablesDetails {
  String? cId;
  String? name;
  int? stockQnt;
  int? dispatchQnt;
  String? branchID;

  ConsumeablesDetails({
    this.cId,
    this.name,
    this.stockQnt,
    this.dispatchQnt,
    this.branchID,
  });

  ConsumeablesDetails.fromJson(Map<String, dynamic> json) {
    cId = json['_id'];
    name = json['name'];
    stockQnt = json['stockQnt'];
    dispatchQnt = json['dispatchQnt'];
    branchID = json['branchID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.cId;
    data['name'] = this.name;
    data['stockQnt'] = this.stockQnt;
    data['dispatchQnt'] = this.dispatchQnt;
    data['branchID'] = this.branchID;
    return data;
  }
}
