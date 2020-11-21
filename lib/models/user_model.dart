class User {
  String name;
  String designation;
  User({this.name, this.designation});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['designation'] = this.designation;
    return data;
  }
}
