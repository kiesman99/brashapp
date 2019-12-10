import 'package:bloc/bloc.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationEvent.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationState.dart';

/// This Bloc will handle resolving the Information
/// for a selected address

class AddressInformationBloc extends Bloc<AddressInformationEvent, AddressInformationState> {

  @override
  AddressInformationState get initialState => Loading();

  @override
  Stream<AddressInformationState> mapEventToState(AddressInformationEvent event) {
    if(event is Fetch){
      
    }
  }
  
}