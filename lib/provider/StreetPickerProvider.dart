import 'dart:convert';

import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/models/StreetModel.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/provider/AbstractSpiderProvider.dart';

class StreetPickerProvider extends AbstractSpiderProvider<StreetPickerModel> {

  @override
  String get spiderName => "streetPicker";

  /*
   * This Provider needs a fixURL, because it's the first entry point.
   * The other URLs will be provided by the 'href' item in the response
   * JSON
   */
  String urlPrefix = "http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=";

  @override
  StreetPickerModel parseJson(Map<String, dynamic> json) {
    return StreetPickerModel.fromJson(json);
  }

  String _queryParamFormatter(String query) {
    return Uri.encodeQueryComponent(
        Uri.encodeQueryComponent(
            query,
            encoding: Encoding.getByName("iso_8859-1")
        ),
        encoding: Encoding.getByName("iso_8859-1")
    );
  }

  @override
  Future<ApiResponse> getResponse(String searchQuery) {
    return super.getResponse(urlPrefix + _queryParamFormatter(searchQuery));
  }

}