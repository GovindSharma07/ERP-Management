class DriverModel {
  String uid;
  String email;
  String fName;
  String lName;
  String busNumber;
  String contact;
  String address;

  DriverModel(
      {required this.uid,
      required this.fName,
      required this.lName,
      required this.busNumber,
      required this.contact,
      required this.address,
      required this.email});

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email" : email,
      "fName": fName,
      "lName": lName,
      "busNumber": busNumber,
      "contact": contact,
      "address": address
    };
  }
}
