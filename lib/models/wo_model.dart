import 'dart:ffi';

class WODetails {
  String? poID;
  String? woID;
  String? poName;
  String? JT;
  String? woNumber;
  String? startDate;
  String? endDate;
  List? workers;
  List? timecards;
  List? consumeables;
  List? equipements;
  List? rentedEquipements;
  String? branchID;
  String? managerid;
  String? csrid;

  WODetails(
      {this.poID,
      this.woID,
      this.poName,
      this.woNumber,
      this.JT,
      this.startDate,
      this.endDate,
      this.workers,
      this.timecards,
      this.consumeables,
      this.equipements,
      this.branchID,
      this.rentedEquipements,
      this.managerid,
      this.csrid});

  WODetails.fromJson(Map<String, dynamic> json) {
    poID = json['poID'];
    woID = json['_id'];
    poName = json['poName'];
    woNumber = json['woNumber'];
    JT = json['JT'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    workers = json['workers'];
    timecards = json['timecards'];
    consumeables = json['consumeables'];
    equipements = json['equipements'];
    branchID = json['branchID'];
    rentedEquipements = json['rentedEquipements'];
    managerid = json['managerId'];
    csrid = json['csrid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['poID'] = this.poID;
    data['_id'] = this.woID;
    data['poName'] = this.poName;
    data['woNumber'] = this.woNumber;
    data['JT'] = this.JT;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['workers'] = this.workers;
    data['timecards'] = this.timecards;
    data['consumeables'] = this.consumeables;
    data['equipements'] = this.equipements;
    data['branchID'] = this.branchID;
    data['rentedEquipements'] = this.rentedEquipements;
    data['managerId'] = this.managerid;
    data['csrid'] = this.csrid;
    return data;
  }
}
