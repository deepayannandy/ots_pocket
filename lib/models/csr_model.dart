class CSRDetails {
  String? cId;
  String? CustomerID;
  String? CustomerName;
  String? timestamp;
  String? managerId;
  List? data;

  CSRDetails({
    this.cId,
    this.CustomerID,
    this.CustomerName,
    this.timestamp,
    this.managerId,
    this.data,
  });

  CSRDetails.fromJson(Map<String, dynamic> json) {
    cId = json['_id'];
    CustomerID = json['CustomerID'];
    CustomerName = json['CustomerName'];
    timestamp = json['timestamp'];
    managerId = json['managerId'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.cId;
    data['CustomerID'] = this.CustomerID;
    data['CustomerName'] = this.CustomerName;
    data['timestamp'] = this.timestamp;
    data['managerId'] = this.managerId;
    data['data'] = this.data;
    return data;
  }
}
