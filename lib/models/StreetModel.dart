import 'package:brashapp/models/HouseNumberPickerModel.dart';

/// This is the model, that will hold one street
class Street {
  
  Street({this.name, this.href});

  /// A custom factory that will generate a [Street] from
  /// the retrieved json
  factory Street.fromJson(Map<String, dynamic> json){
    return Street(
      name: json['street'],
      href: json['href']
    );
  }

  /// This is the name of the street
  String name;

  /// This is the url that has to be injected into the api request
  /// to retrieve all available [HouseNumbers]
  String href;
}