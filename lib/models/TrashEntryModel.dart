import 'package:intl/intl.dart';

class TrashEntryModel {
  String message;
  String date;

  TrashEntryModel({this.message, this.date});

  factory TrashEntryModel.fromJson(Map<String, dynamic> json){
    return TrashEntryModel(
      message: json["msg"],
      date: json["date"]
    );
  }
}