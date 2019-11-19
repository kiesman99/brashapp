import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/service/AbstractSpiderService.dart';

class HouseNumberPickerSpiderService extends AbstractSpiderService<HouseNumberPickerModel>{

  final String spiderName = "houseNumberPicker";

  @override
  HouseNumberPickerModel parseJson(Map<String, dynamic> json) {
    return HouseNumberPickerModel.fromJson(json);
  }

}