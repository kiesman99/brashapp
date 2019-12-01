import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/provider/AbstractSpiderProvider.dart';

class HouseNumberProvider extends AbstractSpiderProvider {

  @override
  String get spiderName => "houseNumberPicker";

  @override
  ApiResponse parseJson(Map<String, dynamic> json) {
    return HouseNumberPickerModel.fromJson(json);
  }

}