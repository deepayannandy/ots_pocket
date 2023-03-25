class CSRItemModel {
  String? Id;
  String? ItemType;
  String? ServiceType;
  String? ItemName;
  int? Unitprice;
  int? ST;
  int? OT;
  String? Unit;

  CSRItemModel(
      {this.Id,
      this.ItemName,
      this.ItemType,
      this.ServiceType,
      this.ST,
      this.OT,
      this.Unit,
      this.Unitprice});

  CSRItemModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    ItemName = json['ItemName'];
    ItemType = json['ItemType'];
    ServiceType = json['ServiceType'];
    ST = json['ST'];
    OT = json['OT'];
    Unit = json['Unit'];
    ServiceType = json['ServiceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.Id;
    data['ItemName'] = this.ItemName;
    data['ItemType'] = this.ItemType;
    data['ServiceType'] = this.ServiceType;
    data['ST'] = this.ST;
    data['OT'] = this.OT;
    data['Unit'] = this.Unit;
    data['Unitprice'] = this.Unitprice;
    return data;
  }
}
