import 'dart:convert';
import 'package:brashapp/models/AddressInformation.dart';
import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

// Look here: https://bloclibrary.dev/#/flutterweathertutorial
class BrashApiClient {

  static String baseURL(String spiderName) => 'https://brash.tandashi.de/crawl.json?spider_name=$spiderName&url=';
  final http.Client httpClient;

  BrashApiClient({
    @required this.httpClient
  }) : assert(httpClient != null);

  /// This function will format the search query to the 
  /// format, the api endpoint will accept
  String _queryParamFormatter(String query) {
    return Uri.encodeQueryComponent(
        Uri.encodeQueryComponent(
            query,
            encoding: Encoding.getByName("iso_8859-1")
        ),
        encoding: Encoding.getByName("iso_8859-1")
    );
  }

  void _checkResponseForError(Map<String, dynamic> json, String message) {
    if(json["errors"] != null || json["status"] == "error"){
      throw Exception("Ein schwerwiegender Fehler ist aufgetreten.");
    }

    if(json["items"][0]["error"] != null) {
      throw Exception(message);
    }
  }

  /// This function will fetch all streets from the given [searchQuery]
  Future<Streets> getStreets(String searchQuery) async {
    assert(searchQuery.isNotEmpty);

    final String urlPrefix = "http://213.168.213.236/bremereb/bify/strasse.jsp?strasse=";
    final url = "${baseURL("streetPicker")}$urlPrefix${_queryParamFormatter(searchQuery)}";

    final response = await this.httpClient.get(url);

    if(response.statusCode != 200){
      throw Exception("The Website couldn't be reached");
    }

    Map<String, dynamic> json = jsonDecode(response.body);
    _checkResponseForError(json, "Die Straße wurde nicht gefunden");
    
    return Streets.fromJson(json["items"][0]);
  }

  /// This function will provide all available [HouseNumbers]
  /// for the given [streetUrl]
  Future<HouseNumbers> getHouseNumbers(String streetUrl) async {
    assert(streetUrl.isNotEmpty);

    final String url = '${baseURL("houseNumberPicker")}$streetUrl';
    final response = await this.httpClient.get(url);

    if(response.statusCode != 200)
      throw Exception("The Website couldn't be reached");

    Map<String, dynamic> json = jsonDecode(response.body);
    _checkResponseForError(json, "Die Straße wurde nicht gefunden");
    
    return HouseNumbers.fromJson(json["items"][0]);
  }

  /// This function will provide all [AddressInformation]
  /// for a given [addressUrl]
  Future<AddressInformation> getAddressInformation(String addressUrl) async {
    assert(addressUrl.isNotEmpty);

    final String url = '${baseURL("trashEntries")}$addressUrl';
    final response = await this.httpClient.get(url);

    if(response.statusCode != 200)
      throw Exception("The Website couldn't be reached");

    Map<String, dynamic> json = jsonDecode(response.body);
    _checkResponseForError(json, "Die Straße wurde nicht gefunden");
    
    return AddressInformation.fromJson(json["items"][0]);
  }

  
}