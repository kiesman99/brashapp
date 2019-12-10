import 'package:brashapp/bloc/house_number_picker_bloc/house_number_picker_bloc.dart';
import 'package:brashapp/bloc/house_number_picker_bloc/house_number_picker_event.dart';
import 'package:brashapp/bloc/house_number_picker_bloc/house_number_picker_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/api/client/BrashApiClient.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_test/bloc_test.dart';

void main() {

  group('Testing StreetPickerBloc', () {

    HouseNumberPickerBloc bloc;

    setUp(() {
      bloc = HouseNumberPickerBloc(
        BrashRepository(
          apiClient: BrashApiClient(
            httpClient: http.Client()
          )
        )
      );
    });

    test('Check if initial State is correct', () {
      expect(bloc.initialState is HouseNumberPickerInitial, true);
    });

    blocTest<HouseNumberPickerBloc, HouseNumberPickerEvent, HouseNumberPickerState>(
      'Test Fetch Event --> working, one letter',
      build: () => bloc,
      act: (HouseNumberPickerBloc bloc) async => bloc.add(
        HouseNumberPickerFetch(streetUrl: 'http://213.168.213.236/bremereb/bify/hausnummer.jsp?strasse=Emanuelstra%2525DFe')
        ),
      expect: <dynamic>[
        isA<HouseNumberPickerInitial>(),
        isA<HouseNumberPickerFetchInProgress>(),
        isA<HouseNumberPickerFetchSuccess>()
      ]
    );

    blocTest<HouseNumberPickerBloc, HouseNumberPickerEvent, HouseNumberPickerState>(
      'Test Fetch Event --> working, with multiple umlauts (Ölmühlenstraße)',
      build: () => bloc,
      act: (HouseNumberPickerBloc bloc) async => bloc.add(
        HouseNumberPickerFetch(streetUrl: 'http://213.168.213.236/bremereb/bify/hausnummer.jsp?strasse=%2525D6lm%2525FChlenstra%2525DFe')
        ),
      expect: <dynamic>[
        isA<HouseNumberPickerInitial>(),
        isA<HouseNumberPickerFetchInProgress>(),
        isA<HouseNumberPickerFetchSuccess>()
      ]
    );

    blocTest<HouseNumberPickerBloc, HouseNumberPickerEvent, HouseNumberPickerState>(
      'Test Fetch Event --> not working, umlaut broken',
      build: () => bloc,
      act: (HouseNumberPickerBloc bloc) async => bloc.add(
        HouseNumberPickerFetch(streetUrl: 'http://213.168.213.236/bremereb/bify/hausnummer.jsp?strasse=Emanuelstra%DFe')
        ),
      expect: <dynamic>[
        isA<HouseNumberPickerInitial>(),
        isA<HouseNumberPickerFetchInProgress>(),
        isA<HouseNumberPickerFetchFailure>()
      ]
    );

    /*
    blocTest<HouseNumberPickerBloc, HouseNumberPickerEvent, HouseNumberPickerState>(
      'Test Fetch Event --> not working, broken url',
      build: () => bloc,
      act: (HouseNumberPickerBloc bloc) async => bloc.add(
        HouseNumberPickerFetch(streetUrl: 'http://213.168.213.236/bremereb/bify/hausnummer.jsp?strass')
        ),
      expect: <dynamic>[
        isA<HouseNumberPickerInitial>(),
        isA<HouseNumberPickerFetchInProgress>(),
        isA<HouseNumberPickerFetchFailure>()
      ]
    );
    */

  });

}