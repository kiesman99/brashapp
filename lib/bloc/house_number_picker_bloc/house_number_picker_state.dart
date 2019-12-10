import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:meta/meta.dart';

abstract class HouseNumberPickerState {

  HouseNumberPickerState({@required this.houseNumbers}) : 
    assert(houseNumbers != null);

  HouseNumbers houseNumbers;
}

class HouseNumberPickerInitial extends HouseNumberPickerState {
  HouseNumberPickerInitial() 
    : super(houseNumbers: HouseNumbers.empty());
}

class HouseNumberPickerFetchInProgress extends HouseNumberPickerState {
  HouseNumberPickerFetchInProgress() 
    : super(houseNumbers: HouseNumbers.empty());
}

class HouseNumberPickerFetchSuccess extends HouseNumberPickerState {

  HouseNumberPickerFetchSuccess({HouseNumbers houseNumbers}) 
    : super(houseNumbers: houseNumbers);
}

class HouseNumberPickerFetchFailure extends HouseNumberPickerState {

  HouseNumberPickerFetchFailure({
    @required this.errorMessage
  })
    : assert(errorMessage.isNotEmpty),
      super(houseNumbers: HouseNumbers.empty());

  final String errorMessage;
}