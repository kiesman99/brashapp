import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/HouseNumberModel.dart';

class HouseNumberPickerModel extends ApiResponse{
  String street;
  List<HouseNumberModel> houseNumbers;
  bool error;

  HouseNumberPickerModel({this.street, this.houseNumbers});

  HouseNumberPickerModel.fromJson(Map<String, dynamic> json){
    List<HouseNumberModel> houseNumbers = List();

    json["data"].forEach((el) => houseNumbers.add(HouseNumberModel.fromJson(el)));
    this.street = json["currentStreet"];
    this.houseNumbers = houseNumbers;
  }

}