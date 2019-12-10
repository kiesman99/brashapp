import 'AddressInformationState.dart';

/// These are the Events that can be
/// dispatched to transform the
/// [AddressInformationState] 
class AddressInformationEvent {}

/// This Event will start fetching the information
/// from the provided information
class AddressInformationFetch extends AddressInformationEvent {

  AddressInformationFetch({this.url});

  String url;
}