import 'package:bloc/bloc.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationEvent.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationState.dart';
import 'package:brashapp/models/AddressInformation.dart';

/// This Bloc will handle resolving the Information
/// for a selected address

class AddressInformationBloc extends Bloc<AddressInformationEvent, AddressInformationState> {

  AddressInformationBloc(this.brashRepository);

  final BrashRepository brashRepository;

  @override
  AddressInformationState get initialState => AddressInformationFetchInProgress();

  @override
  Stream<AddressInformationState> mapEventToState(AddressInformationEvent event) async* {
    if(event is Fetch){
      yield AddressInformationFetchInProgress();
      try {
        final AddressInformation information = await brashRepository.getAddressInformation(event.url);
        yield AddressInformationFetchSuccess(addressInformation: information);
      }catch(e) {
        yield AddressInformationFetchFailure(errorMessage: e.toString());
      }
    }
  }
  
}