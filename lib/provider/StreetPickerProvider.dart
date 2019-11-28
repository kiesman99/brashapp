import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/provider/AbstractSpiderProvider.dart';

class StreetPickerProvider extends AbstractSpiderProvider{

  @override
  // TODO: implement spiderName
  String get spiderName => "streetPicker";

  /*
   * This Provider needs a fixURL, because it's the first entry point.
   * The other URLs will be provided by the 'href' item in the response
   * JSON
   */
  String urlPrefix = "http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=";

  Future<ApiResponse> streets;

  @override
  ApiResponse parseJson(Map<String, dynamic> json) {
    return StreetPickerModel.fromJson(json);
  }

}