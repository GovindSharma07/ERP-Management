import 'package:intl/intl.dart';

class FeesModel{

  final String uid;
  final int amount;
  final String slipNumber;
  final DateTime date;

  FeesModel(this.uid, this.amount, this.slipNumber, this.date);

  Map<String,dynamic> toJson(){
    return {
      "uid" : uid,
      "amount" : amount,
      "slipNumber" : slipNumber,
      "date" : DateFormat("dd-MM-yyyy").format(date)};
  }
}