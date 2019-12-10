import 'package:brashapp/models/AddressInformation.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:meta/meta.dart';
import 'AddressInformationEvent.dart';

/// This is the state that will provide 
/// all information collected in the bloc
/// 
/// It can be transformed by dispatching
/// an [AddressInformationEvent]
abstract class AddressInformationState {
  AddressInformationState({@required this.addressInformation});

  AddressInformation addressInformation;
}

class AddressInformationFetchInProgress extends AddressInformationState{
  AddressInformationFetchInProgress() 
    : super(addressInformation: AddressInformation.empty());
}

class AddressInformationFetchSuccess extends AddressInformationState {
  AddressInformationFetchSuccess({@required AddressInformation addressInformation}) 
    : assert(addressInformation != null),
    super(addressInformation: addressInformation);
}

class AddressInformationFetchFailure extends AddressInformationState {

  AddressInformationFetchFailure({
    @required this.errorMessage
  }) :
  assert(errorMessage.isNotEmpty),
  super(
    addressInformation: AddressInformation.empty()
  );

  final String errorMessage;


}