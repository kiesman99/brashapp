import 'package:brashapp/bloc/address_information_bloc/AddressInformationBloc.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationState.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  AddressInformationBloc bloc;

  group("AddressInformationBloc", () {
    
    setUp(() {
      bloc = AddressInformationBloc();
    });

    test('Initial state is Loading', () {
      expect(bloc.initialState is Loading, true);
    });

  });

}