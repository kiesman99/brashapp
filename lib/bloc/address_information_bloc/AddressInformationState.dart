import 'AddressInformationEvent.dart';

/// This is the state that will provide 
/// all information collected in the bloc
/// 
/// It can be transformed by dispatching
/// an [AddressInformationEvent]
class AddressInformationState {}

class Loading extends AddressInformationState{

}

class Fetched extends AddressInformationState {
  
}