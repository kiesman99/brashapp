import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/HouseNumberModel.dart';

/// This class is holding multiple instances
/// of [HousenNumber] and will provide all
/// HouseNumbers to a given Street
class HouseNumbers extends ApiResponse{

  /// The name of the street that the house numbers
  /// belong to
  String street;

  /// The house numbers of the street [name]
  List<HouseNumber> houseNumbers;

  HouseNumbers({this.street, this.houseNumbers});

  /// custom constructor that will be used to generate
  /// a [HouseNumbers] model from json data that
  /// will be retrieved by the api
  HouseNumbers.fromJson(Map<String, dynamic> json){
    List<HouseNumber> houseNumbers = List();

    json["data"].forEach((el) => houseNumbers.add(HouseNumber.fromJson(el)));
    this.street = json["currentStreet"];
    this.houseNumbers = houseNumbers;
  }

}