import 'package:brashapp/models/ApiResponse.dart';

class ErrorModel extends ApiResponse {

  String message;

  ErrorModel({this.message});

}