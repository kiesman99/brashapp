import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/service/AbstractSpiderService.dart';

class StreetPickerSpiderService extends AbstractSpiderService<StreetPickerModel>{

  final String spiderName = "streetPicker";

  /*
   * This Provider needs a fixURL, because it's the first entry point.
   * The other URLs will be provided by the 'href' item in the response
   * JSON
   */
  @override
  String get urlPrefix => "http%3A%2F%2F213.168.213.236%2Fbremereb%2Fbify%2Fstrasse.jsp%3Fstrasse%3D";


  @override
  StreetPickerModel parseJson(Map<String, dynamic> json) {
    return StreetPickerModel.fromJson(json);
  }
  
  String _queryFormatter(String query) {
    query = query.replaceAll(":", "%3A");
    query = query.replaceAll("/", "%2F");
    query = query.replaceAll("?", "%3F");
    query = query.replaceAll("=", '%3D');
    query = query.replaceAll("&", '%26');
    query = query.replaceAll('%DF', "%25DF");
    query = query.replaceAll('ß', "%25DF");
    query = query.replaceAll("ä", "%25E4");
    query = query.replaceAll("Ä", "%25C4");
    query = query.replaceAll("ö", "%25F6");
    query = query.replaceAll("Ö", "%25D6");
    query = query.replaceAll("ü", "%25FC");
    query = query.replaceAll("Ü", "%25DC");
    query = query.replaceAll(" ", "%7F");

    print("QUERY: $query");

    return query;
  }

  @override
  Future<ApiResponse> getResponse(String searchQuery) {
    return super.getResponse(_queryFormatter(searchQuery));
  }


}