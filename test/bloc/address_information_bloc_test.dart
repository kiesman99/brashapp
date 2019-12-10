import 'package:bloc_test/bloc_test.dart';
import 'package:brashapp/api/client/BrashApiClient.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationBloc.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationEvent.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationState.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {

  AddressInformationBloc addrInfoBloc;

  group('AddressInformationBloc', () {
    
    setUp(() {
      addrInfoBloc = AddressInformationBloc(
        BrashRepository(
          apiClient: BrashApiClient(
            httpClient: http.Client()
          )
        )
      );
    });

    test('Initial state is Loading', () {
      expect(addrInfoBloc.initialState is AddressInformationFetchInProgress, true);
    });

    blocTest<AddressInformationBloc, AddressInformationEvent, AddressInformationState>('Test Fetch Event',
      build: () => addrInfoBloc,
      act: (AddressInformationBloc bloc) async => bloc.add(Fetch(url: 'http://213.168.213.236/bremereb/bify/bify.jsp?strasse=Emanuelstra%25DFe%26hausnummer=15')),
      expect: <dynamic>[
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchSuccess>()
      ]
    );

    blocTest<AddressInformationBloc, AddressInformationEvent, AddressInformationState>(
      'Fetch a non existing URL',
      build: () => addrInfoBloc,
      act: (AddressInformationBloc bloc) async => bloc.add(Fetch(url: '')),
      expect: <dynamic>[
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchFailure>()
      ]
    );

    blocTest<AddressInformationBloc, AddressInformationEvent, AddressInformationState>(
      'Fetch a URL with wrong parsed ß',
      build: () => addrInfoBloc,
      act: (AddressInformationBloc bloc) async => bloc.add(Fetch(url: 'http://213.168.213.236/bremereb/bify/bify.jsp?strasse=Emanuelstra%DFe%26hausnummer=15')),
      expect: <dynamic>[
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchFailure>()
      ]
    );

    blocTest<AddressInformationBloc, AddressInformationEvent, AddressInformationState>(
      'Fetch a URL where an parameter in URL is missing',
      build: () => addrInfoBloc,
      act: (AddressInformationBloc bloc) async => bloc.add(Fetch(url: 'http://213.168.213.236/bremereb/bify/bify.jsp?hausnummer=15')),
      expect: <dynamic>[
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchInProgress>(),
        isA<AddressInformationFetchFailure>()
      ]
    );

  });

}