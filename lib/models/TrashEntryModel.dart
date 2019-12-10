import 'package:hive/hive.dart';

@HiveType()
class TrashEntry {
  
  TrashEntry({this.message, this.date});

  factory TrashEntry.fromJson(Map<String, dynamic> json){
    return TrashEntry(
      message: json['msg'],
      date: json['date']
    );
  }
  
  @HiveField(0)
  String message;

  @HiveField(1)
  String date;

}