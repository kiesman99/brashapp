import 'package:brashapp/models/AddressInformation.dart';
import 'package:brashapp/service/AbstractSpiderService.dart';

class TrashSpiderService extends AbstractSpiderService<AddressInformation>{

  final String spiderName = "trashEntries";

  @override
  AddressInformation parseJson(Map<String, dynamic> json) {
    return AddressInformation.fromJson(json);
  }


}