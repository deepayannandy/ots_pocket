import 'dart:ffi';

class equipmentsDetails {
  String? eId;
  String? name;
  int? availableQnt;
  int? dispatchQnt;
  String? branchID;
  dynamic UR;
  dynamic PR;

  equipmentsDetails(
      {this.name,
      this.eId,
      this.availableQnt,
      this.dispatchQnt,
      this.branchID,
      this.PR,
      this.UR});

  equipmentsDetails.fromJson(Map<String, dynamic> json) {
    eId = json['_id'];
    name = json['name'];
    availableQnt = json['availableQnt'];
    dispatchQnt = json['dispatchQnt'];
    branchID = json['branchID'];
    PR = json['PR'];
    UR = json['UR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.eId;
    data['name'] = this.name;
    data['availableQnt'] = this.availableQnt;
    data['dispatchQnt'] = this.dispatchQnt;
    data['branchID'] = this.branchID;
    data['PR'] = this.PR;
    data['UR'] = this.UR;
    return data;
  }
}
