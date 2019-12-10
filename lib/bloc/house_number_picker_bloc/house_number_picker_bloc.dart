import 'package:bloc/bloc.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/bloc/house_number_picker_bloc/house_number_picker_event.dart';
import 'package:brashapp/bloc/house_number_picker_bloc/house_number_picker_state.dart';
import 'package:brashapp/models/HouseNumberPickerModel.dart';

class HouseNumberPickerBloc extends Bloc<HouseNumberPickerEvent, HouseNumberPickerState> {

  HouseNumberPickerBloc(this.brashRepository)
    : assert(brashRepository != null);

  BrashRepository brashRepository;

  @override
  HouseNumberPickerState get initialState => HouseNumberPickerInitial();

  @override
  Stream<HouseNumberPickerState> mapEventToState(HouseNumberPickerEvent event) async* {
    if(event is HouseNumberPickerFetch) {
      yield HouseNumberPickerFetchInProgress();

      try {
        final HouseNumbers houseNumbers = await brashRepository.getHouseNumbers(event.streetUrl);
        yield HouseNumberPickerFetchSuccess(houseNumbers: houseNumbers);
      } catch(e) {
        yield HouseNumberPickerFetchFailure(errorMessage: e.toString());
      }
    }
  }

}