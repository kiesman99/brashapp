import 'package:brashapp/models/TrashEntriesModel.dart';
import 'package:brashapp/service/AbstractSpiderService.dart';

class TrashSpiderService extends AbstractSpiderService<TrashEntriesModel>{

  final String spiderName = "trashEntries";

  @override
  TrashEntriesModel parseJson(Map<String, dynamic> json) {
    return TrashEntriesModel.fromJson(json);
  }


}