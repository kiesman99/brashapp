import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/TrashEntryModel.dart';

class TrashEntriesModel extends ApiResponse{
  String currentStreet;
  String abholtag;
  int nextDateIndex;
  List<TrashEntryModel> allTrashEntries;
  List<TrashEntryModel> relevantTrashEntries;

  TrashEntriesModel({this.currentStreet, this.abholtag, this.allTrashEntries, this.nextDateIndex, this.relevantTrashEntries});

  factory TrashEntriesModel.fromJson(Map<String, dynamic> json){
    List<TrashEntryModel> entries = List();
    json["data"]["data"].forEach((el) => entries.add(TrashEntryModel.fromJson(el)));

    return TrashEntriesModel(
      currentStreet: json["currentStreet"] ?? "",
      abholtag: json["data"]["abholtag"] ?? "",
      allTrashEntries: entries,
      relevantTrashEntries: entries.where((el) => DateTime.now().compareTo(DateTime.parse(el.date)) < 0).toList(),
      nextDateIndex: getNextDateIndex(entries)
    );
  }

  static int getNextDateIndex(List<TrashEntryModel> entries){
    //return 2;
    DateTime now = DateTime.now();
    int index = -1;
    
    for(int i = 0; i < entries.length; i++){
      DateTime d = DateTime.parse(entries.elementAt(i).date);
      if(now.compareTo(d) > 0)
        index = i;
    }

    return now.compareTo(DateTime.parse(entries.elementAt(index).date)) == 0 ? index : ++index;
  }

}