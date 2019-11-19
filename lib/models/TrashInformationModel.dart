import 'package:brashapp/models/TrashEntryModel.dart';

class TrashInformationModel {

  List<TrashEntryModel> entries;
  String streetname;
  String nextTime;

  TrashInformationModel({this.streetname, this.nextTime, this.entries});

  factory TrashInformationModel.fromJson(Map<String, dynamic> json){
    List<TrashEntryModel> tmp = List();

    json["dates"].forEach((el) => tmp.add(TrashEntryModel.fromJson(el)));

    return TrashInformationModel(
      streetname: json["street"],
      nextTime: json["nextTime"],
      entries: tmp
    );
  }

}