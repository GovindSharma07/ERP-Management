class DriverModel {
  late String uid;
  late String email;
  late String fName;
  late String lName;
  late String busNumber;
  late String contactNumber;
  late String address;

  DriverModel(
      {required this.uid,
      required this.fName,
      required this.lName,
      required this.busNumber,
      required this.contactNumber,
      required this.address,
      required this.email});

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "fName": fName,
      "lName": lName,
      "busNumber": busNumber,
      "contactNumber": contactNumber,
      "address": address
    };
  }
}
