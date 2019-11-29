import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/StreetModel.dart';

class StreetPickerModel extends ApiResponse {
  List<StreetModel> streets;
  
  StreetPickerModel({this.streets});

  factory StreetPickerModel.fromJson(Map<String, dynamic> json){
    List<StreetModel> streets = new List();
    json["data"].forEach((el) => streets.add(StreetModel.fromJson(el)));
    return StreetPickerModel(
      streets: streets
    );
  }

  StreetPickerModel copyWith({List<StreetModel> streets}){
    return StreetPickerModel(
      streets: streets ?? this.streets
    );
  }

}