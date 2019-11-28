import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class AbstractSpiderProvider<T extends ApiResponse> with ChangeNotifier{

  ApiResponse response;

  String get spiderName;
  String get baseURL => 'https://brash.tandashi.de/crawl.json?spider_name=$spiderName&url=';

  void fetch(String searchQuery) async {
    response = await _getResponse(searchQuery);
    notifyListeners();
  }


  Future<ApiResponse> _getResponse(String searchQuery) async {
    final url = baseURL + searchQuery;
    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      // checkForErrors
      if(jsonMap["errors"] != null || jsonMap["status"] == "error"){
        return ErrorModel(
            message: "Ein schwerwiegender Fehler ist aufgetreten"
        );
      }else if(jsonMap["items"][0]["error"] != null) {
        return ErrorModel(
            message: "Die Straße wurde nicht gefunden"
        );
      }

      return parseJson(jsonMap["items"][0]);
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  /// This function will define how the json elements
  /// will be parsed into the actual element [T]
  ///
  /// Each [ApiResponse] should have a [ApiResponse.parseJson]
  /// function that should be used
  ///
  /// Example:
  ///
  /// ```dart
  /// ErrorModel parseJson(Map<String, dynamic> json){
  ///   return ErrorModel.parseJson(json);
  /// }
  T parseJson(Map<String, dynamic> json);

}