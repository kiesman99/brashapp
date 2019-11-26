import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/provider/AbstractSpiderProvider.dart';
import 'package:brashapp/service/StreetPickerSpiderService.dart';

class StreetPickerProvider extends AbstractSpiderProvider{

  @override
  // TODO: implement spiderName
  String get spiderName => "streetPicker";

  /*
   * This Provider needs a fixURL, because it's the first entry point.
   * The other URLs will be provided by the 'href' item in the response
   * JSON
   */
  @override
  String get urlPrefix => "http%3A%2F%2F213.168.213.236%2Fbremereb%2Fbify%2Fstrasse.jsp%3Fstrasse%3D";

  Future<ApiResponse> streets;

  @override
  ApiResponse parseJson(Map<String, dynamic> json) {
    return StreetPickerModel.fromJson(json);
  }

}