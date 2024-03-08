class TeacherModel {
  String uid;
  String email;
  String fName;
  String lName;
  String contact;
  String busAllocated;
  String address;
  String department;

  TeacherModel(
      {required this.uid,
      required this.email,
      required this.address,
      required this.lName,
      required this.fName,
      required this.contact,
      required this.department,
      required this.busAllocated});

  Map<String,String> toJson(){
    return  {
      "uid": uid,
      "email" : email,
      "fName": fName,
      "lName": lName,
      "department" : department,
      "busAllocated": busAllocated,
      "contact": contact,
      "address": address,
    };
  }
}
