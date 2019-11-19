import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/service/AbstractSpiderService.dart';

class StreetPickerSpiderService extends AbstractSpiderService<StreetPickerModel>{

  final String spiderName = "streetPicker";

  @override
  StreetPickerModel parseJson(Map<String, dynamic> json) {
    // TODO: implement parseJson
    return StreetPickerModel.fromJson(json);
  }

}