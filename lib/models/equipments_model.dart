import 'dart:ffi';

class equipmentsDetails {
  String? eId;
  String? name;
  int? availableQnt;
  int? dispatchQnt;
  String? branchID;

  equipmentsDetails({
    this.name,
    this.eId,
    this.availableQnt,
    this.dispatchQnt,
    this.branchID,
  });

  equipmentsDetails.fromJson(Map<String, dynamic> json) {
    eId = json['_id'];
    name = json['name'];
    availableQnt = json['availableQnt'];
    dispatchQnt = json['dispatchQnt'];
    branchID = json['branchID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.eId;
    data['name'] = this.name;
    data['availableQnt'] = this.availableQnt;
    data['dispatchQnt'] = this.dispatchQnt;
    data['branchID'] = this.branchID;
    return data;
  }
}
