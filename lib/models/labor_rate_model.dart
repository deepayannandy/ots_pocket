class LaborRate {
  String? Id;
  String? designation;
  String? catagory;

  LaborRate({this.Id, this.designation, this.catagory});

  LaborRate.fromJson(Map<String, dynamic> json) {
    Id = json['_id'];
    designation = json['designation'];
    catagory = json['catagory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.Id;
    data['designation'] = this.designation;
    data['catagory'] = this.catagory;
    return data;
  }
}
