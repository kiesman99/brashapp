import 'package:brashapp/models/AddressInformation.dart';
import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/provider/AbstractSpiderProvider.dart';

class TrashEntriesProvider extends AbstractSpiderProvider {

  @override
  String get spiderName => "trashEntries";

  @override
  ApiResponse parseJson(Map<String, dynamic> json) {
    return AddressInformation.fromJson(json);
  }

}