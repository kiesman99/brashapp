import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/StreetModel.dart';

/// This is the collection of [Street] models based on the
/// requested inital search
class Streets extends ApiResponse {
  
  Streets({this.streets});

  /// A custom factory that will generate a [Streets] model from
  /// the retrieved json
  factory Streets.fromJson(Map<String, dynamic> json){
    final List<Street> streets = <Street>[];
    json['data'].forEach((Map<String, dynamic> json) => streets.add(Street.fromJson(json)));
    return Streets(
      streets: streets
    );
  }

  /// The list of streets corresponding to
  /// the requested search
  List<Street> streets;
  
  Streets copyWith({List<Street> streets}){
    return Streets(
      streets: streets ?? this.streets
    );
  }

}