import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/service/AbstractSpiderService.dart';

class HouseNumberPickerSpiderService extends AbstractSpiderService<HouseNumbers>{

  final String spiderName = "houseNumberPicker";

  @override
  HouseNumbers parseJson(Map<String, dynamic> json) {
    return HouseNumbers.fromJson(json);
  }

}