import 'package:bloc/bloc.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/bloc/street_picker_bloc/street_picker_event.dart';
import 'package:brashapp/bloc/street_picker_bloc/street_picker_state.dart';
import 'package:brashapp/models/StreetPickerModel.dart';

class StreetPickerBloc extends Bloc<StreetPickerEvent, StreetPickerState> {

  StreetPickerBloc(this.brashRepository) : 
    assert(brashRepository != null);

  BrashRepository brashRepository;

  @override
  StreetPickerState get initialState => StreetPickerInitial();

  @override
  Stream<StreetPickerState> mapEventToState(StreetPickerEvent event) async* {
    if(event is StreetPickerFetch) {
      yield StreetPickerFetchInProgress();
      try {
        final Streets streets = await brashRepository.getStreets(event.searchQuery);
        yield StreetPickerFetchSuccess(streets: streets);
      } catch(e) {
        yield StreetPickerFetchFailure(errorMessage: e.toString());
      }
    }
  }
  
}