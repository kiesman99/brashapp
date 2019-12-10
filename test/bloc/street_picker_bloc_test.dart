import 'package:brashapp/bloc/street_picker_bloc/street_picker_bloc.dart';
import 'package:brashapp/bloc/street_picker_bloc/street_picker_event.dart';
import 'package:brashapp/bloc/street_picker_bloc/street_picker_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/api/client/BrashApiClient.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_test/bloc_test.dart';

void main() {

  group('Testing StreetPickerBloc', () {

    StreetPickerBloc bloc;

    setUp(() {
      bloc = StreetPickerBloc(
        BrashRepository(
          apiClient: BrashApiClient(
            httpClient: http.Client()
          )
        )
      );
    });

    test('Check if initial State is correct', () {
      expect(bloc.initialState is StreetPickerInitial, true);
    });

    blocTest<StreetPickerBloc, StreetPickerEvent, StreetPickerState>(
      'Test Fetch Event --> working, one letter',
      build: () => bloc,
      act: (StreetPickerBloc bloc) async => bloc.add(
        StreetPickerFetch(searchQuery: 'E')
        ),
      expect: <dynamic>[
        isA<StreetPickerInitial>(),
        isA<StreetPickerFetchInProgress>(),
        isA<StreetPickerFetchSuccess>()
      ]
    );

    blocTest<StreetPickerBloc, StreetPickerEvent, StreetPickerState>(
      'Test Fetch Event --> working, more than one letter',
      build: () => bloc,
      act: (StreetPickerBloc bloc) async => bloc.add(
        StreetPickerFetch(searchQuery: 'Emanue')
        ),
      expect: <dynamic>[
        isA<StreetPickerInitial>(),
        isA<StreetPickerFetchInProgress>(),
        isA<StreetPickerFetchSuccess>()
      ]
    );

    blocTest<StreetPickerBloc, StreetPickerEvent, StreetPickerState>(
      'Test Fetch Event --> full street name',
      build: () => bloc,
      act: (StreetPickerBloc bloc) async => bloc.add(
        StreetPickerFetch(searchQuery: 'Emanuelstraße')
        ),
      expect: <dynamic>[
        isA<StreetPickerInitial>(),
        isA<StreetPickerFetchInProgress>(),
        isA<StreetPickerFetchSuccess>()
      ]
    );

    blocTest<StreetPickerBloc, StreetPickerEvent, StreetPickerState>(
      'Test Fetch Event --> non existing street',
      build: () => bloc,
      act: (StreetPickerBloc bloc) async => bloc.add(
        StreetPickerFetch(searchQuery: 'Blubedi')
        ),
      expect: <dynamic>[
        isA<StreetPickerInitial>(),
        isA<StreetPickerFetchInProgress>(),
        isA<StreetPickerFetchFailure>()
      ]
    );

  });

}