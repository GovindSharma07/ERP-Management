class TeacherModel {
  String uid;
  String email;
  String fName;
  String lName;
  String contact;
  String busAllocated;
  String address;
  String department;

  TeacherModel({required this.uid,
    required this.email,
    required this.address,
    required this.lName,
    required this.fName,
    required this.contact,
    required this.department,
    required this.busAllocated});

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "fName": fName,
      "lName": lName,
      "department": department,
      "busAllocated": busAllocated,
      "contact": contact,
      "address": address,
    };
  }

  factory TeacherModel.fromJson(Map<String, dynamic> json){
    return TeacherModel(uid: json["uid"],
        email: json["email"],
        address: json["address"],
        lName: json["lName"],
        fName: json["fName"],
        contact: json["contact"],
        department: json["department"],
        busAllocated: json["busAllocated"]);
  }
}
