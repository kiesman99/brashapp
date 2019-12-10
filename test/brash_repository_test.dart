import 'package:brashapp/api/client/BrashApiClient.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/models/AddressInformation.dart';
import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

main() {

  group("BrashRepositoryTests", () {

    BrashRepository repository;

    setUp(() {
      repository = new BrashRepository(
        apiClient: new BrashApiClient(
          httpClient: http.Client()
        )
      );
    });

    group("AddressInformation", () {
      test('Fetch existing AddressInformation', () async {
        final String url = "http://213.168.213.236/bremereb/bify/bify.jsp?strasse=Emanuelstra%25DFe%26hausnummer=15";
        AddressInformation response = await repository.getAddressInformation(url);
        print(response.currentStreet);
        expect(response.currentStreet.length > 0, true);
        expect(response.allTrashEntries.isNotEmpty, true);
        expect(response.pickUpDay.isNotEmpty, true);

        // test first item
        expect(response.allTrashEntries[0].date.isNotEmpty, true);
        expect(response.allTrashEntries[0].message.isNotEmpty, true);
        // test last item
        expect(response.allTrashEntries[response.allTrashEntries.length - 1].date.isNotEmpty, true);
        expect(response.allTrashEntries[response.allTrashEntries.length - 1].message.isNotEmpty, true);
      });

      test('Fetch existing AddressInformation (street with umlaut)', () async {
        final String url = "http://213.168.213.236/bremereb/bify/bify.jsp?strasse=%25D6tzener%2520Weg%26hausnummer=2";
        AddressInformation response = await repository.getAddressInformation(url);
        print(response.currentStreet);
        expect(response.currentStreet.length > 0, true);
        expect(response.allTrashEntries.isNotEmpty, true);
        expect(response.pickUpDay.isNotEmpty, true);

        // test first item
        expect(response.allTrashEntries[0].date.isNotEmpty, true);
        expect(response.allTrashEntries[0].message.isNotEmpty, true);
        // test last item
        expect(response.allTrashEntries[response.allTrashEntries.length - 1].date.isNotEmpty, true);
        expect(response.allTrashEntries[response.allTrashEntries.length - 1].message.isNotEmpty, true);
      });

      test('Fetch non-existing AddressInformation', () async {
        final String url = "http://213.168.213.236/bremereb/bify/bify.jsp?strasse=Emanuelstra%25DFe%26hausnummer=32";
        expect(() async => await repository.getAddressInformation(url), throwsException);
      });
    });

    group("StreetPicker", () {

      test("Fetch all Streets starting with 'A'", () async {
        final String query = "A";
        Streets response = await repository.getStreets(query);
        expect(response.streets.isNotEmpty, true);
        // test first element
        expect(response.streets[0].name.isNotEmpty, true);
        expect(response.streets[0].href.isNotEmpty, true);
        // test last element
        expect(response.streets[response.streets.length - 1].name.isNotEmpty, true);
        expect(response.streets[response.streets.length - 1].href.isNotEmpty, true);
      });

      test("Fetch all Streets starting with 'Ü' (umlaut)", () async {
        final String query = "Ü";
        Streets response = await repository.getStreets(query);
        expect(response.streets.isNotEmpty, true);
        // test first element
        expect(response.streets[0].name.isNotEmpty, true);
        expect(response.streets[0].href.isNotEmpty, true);
        // test last element
        expect(response.streets[response.streets.length - 1].name.isNotEmpty, true);
        expect(response.streets[response.streets.length - 1].href.isNotEmpty, true);
      });

      test("Fetch all Streets starting with 'Emanu' (more than one letter)", () async {
        final String query = "Ü";
        Streets response = await repository.getStreets(query);
        expect(response.streets.isNotEmpty, true);
        // test first element
        expect(response.streets[0].name.isNotEmpty, true);
        expect(response.streets[0].href.isNotEmpty, true);
        // test last element
        expect(response.streets[response.streets.length - 1].name.isNotEmpty, true);
        expect(response.streets[response.streets.length - 1].href.isNotEmpty, true);
      });

      test("Fetch for non existing street 'Ä'", () async {
        final String query = "Ä";
        expect(() async => await repository.getStreets(query), throwsException);
      });

      test("Fetch for non existing street 'Blubedi'", () async {
        final String query = "Blubedi";
        expect(() async => await repository.getStreets(query), throwsException);
      });

    });

    group("HouseNumberPicker", () {

      test("Fetch Housenumbers for street 'Emanuelstraße'", () async {
        final String url = "http://213.168.213.236/bremereb/bify/hausnummer.jsp?strasse=Emanuelstra%2525DFe";
        HouseNumbers response = await repository.getHouseNumbers(url);
        expect(response.houseNumbers.isNotEmpty, true);
        expect(response.street.isNotEmpty, true);
        // test first element in list
        expect(response.houseNumbers[0].href.isNotEmpty, true);
        expect(response.houseNumbers[0].number.isNotEmpty, true);
        // test last element in list
        expect(response.houseNumbers[response.houseNumbers.length - 1].href.isNotEmpty, true);
        expect(response.houseNumbers[response.houseNumbers.length - 1].number.isNotEmpty, true);
      });

      test("Fetch HouseNumbers for a non-existing street 'Blubedi'", () async {
        final String url = "http://213.168.213.236/bremereb/bify/hausnummer.jsp?strasse=Blubedi";
        expect(() async => await repository.getHouseNumbers(url), throwsException);
      }, skip: "Skipping because the api does return the error in the currentStreet attribute");

    });

  });

}