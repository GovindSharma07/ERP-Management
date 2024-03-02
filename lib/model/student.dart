class StudentModel {
  String uid;
  String email;
  String fName;
  String lName;
  String rollNo;
  String dateOfBirth;
  String gender;
  String annualFees;
  String busAllocated;
  String studentContact;
  String parentContact;
  String address;
  String course;
  String section;

  StudentModel({
    required this.uid,
    required this.email,
    required this.fName,
    required this.lName,
    required this.rollNo,
    required this.dateOfBirth,
    required this.gender,
    required this.annualFees,
    required this.busAllocated,
    required this.studentContact,
    required this.parentContact,
    required this.address,
    required this.course,
    required this.section,
  });

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "fName": fName,
      "lName": lName,
      "rollNo": rollNo,
      "dob": dateOfBirth,
      "gender": gender,
      "annualFees" : annualFees,
      "busAllocated": busAllocated,
      "studentContact": studentContact,
      "parentContact": parentContact,
      "address": address,
      "course": course,
      "section": section
    };
  }
}
