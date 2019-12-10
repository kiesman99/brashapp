import 'package:brashapp/models/ApiResponse.dart';

/// This model will hold errors that might
/// be the response from the call if something
/// goes wrong
class ErrorModel extends ApiResponse {

  ErrorModel({this.message});
  
  /// The error message that will be delivered by the response
  String message;
}