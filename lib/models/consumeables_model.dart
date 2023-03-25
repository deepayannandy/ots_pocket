import 'dart:ffi';

class ConsumeablesDetails {
  String? cId;
  String? name;
  int? stockQnt;
  int? dispatchQnt;
  String? branchID;
  dynamic UR;
  dynamic PR;

  ConsumeablesDetails({
    this.cId,
    this.name,
    this.stockQnt,
    this.dispatchQnt,
    this.branchID,
    this.UR,
    this.PR,
  });

  ConsumeablesDetails.fromJson(Map<String, dynamic> json) {
    cId = json['_id'];
    name = json['name'];
    stockQnt = json['stockQnt'];
    dispatchQnt = json['dispatchQnt'];
    branchID = json['branchID'];
    UR = json['UR'];
    PR = json['PR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.cId;
    data['name'] = this.name;
    data['stockQnt'] = this.stockQnt;
    data['dispatchQnt'] = this.dispatchQnt;
    data['branchID'] = this.branchID;
    data['UR'] = this.UR;
    data['PR'] = this.PR;
    return data;
  }
}
