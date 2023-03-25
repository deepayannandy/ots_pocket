class DailyCustomerSheet {
  String? woname;
  String? poname;
  List? equipments;
  List? consumables;
  List? workers;
  String? ContactPerson;
  String? clientname;
  String? address;
  String? jt;
  String? Manager;
  String? date;
  String? remarks;

  DailyCustomerSheet(
      {this.woname,
      this.address,
      this.poname,
      this.equipments,
      this.ContactPerson,
      this.Manager,
      this.clientname,
      this.consumables,
      this.date,
      this.jt,
      this.remarks,
      this.workers});

  DailyCustomerSheet.fromJson(Map<String, dynamic> json) {
    woname = json['woname'];
    poname = json['poname'];
    equipments = json['equipments'];
    consumables = json['consumables'];
    workers = json['workers'];
    ContactPerson = json['ContactPerson'];
    clientname = json['clientname'];
    address = json['address'];
    jt = json['jt'];
    Manager = json['Manager'];
    date = json['date'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['woname'] = this.woname;
    data['poname'] = this.poname;
    data['equipments'] = this.equipments;
    data['consumables'] = this.consumables;
    data['workers'] = this.workers;
    data['ContactPerson'] = this.ContactPerson;
    data['clientname'] = this.clientname;
    data['address'] = this.address;
    data['jt'] = this.jt;
    data['Manager'] = this.Manager;
    data['date'] = this.date;
    data['remarks'] = this.remarks;

    return data;
  }
}
