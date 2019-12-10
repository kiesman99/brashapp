import 'AddressInformationState.dart';

/// These are the Events that can be
/// dispatched to transform the
/// [AddressInformationState] 
class AddressInformationEvent {}

/// This Event will start fetching the information
/// from the provided information
class Fetch extends AddressInformationEvent {

  String url;

  Fetch({this.url});

}