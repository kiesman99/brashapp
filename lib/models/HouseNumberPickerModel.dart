import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/HouseNumberModel.dart';

/// This class is holding multiple instances
/// of [HousenNumber] and will provide all
/// HouseNumbers to a given Street
class HouseNumbers extends ApiResponse{
  
  HouseNumbers({this.street, this.houseNumbers});

  /// custom constructor that will be used to generate
  /// a [HouseNumbers] model from json data that
  /// will be retrieved by the api
  HouseNumbers.fromJson(Map<String, dynamic> json){
    final List<HouseNumber> houseNumbers = <HouseNumber>[];

    json['data'].forEach((Map<String, dynamic> json) => houseNumbers.add(HouseNumber.fromJson(json)));
    street = json['currentStreet'];
    this.houseNumbers = houseNumbers;
  }

  /// The name of the street that the house numbers
  /// belong to
  String street;

  /// The house numbers of the street [name]
  List<HouseNumber> houseNumbers;
}