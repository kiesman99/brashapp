import 'package:brashapp/api/client/BrashApiClient.dart';
import 'package:brashapp/models/AddressInformation.dart';
import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:flutter/material.dart';

class BrashRepository {
  
  BrashRepository({
    @required this.apiClient
  }) : assert(apiClient != null);

  final BrashApiClient apiClient;

  /// This function will get all available streets 
  /// of the provided [searchQuery]
  Future<Streets> getStreets(String searchQuery) async {
    return await apiClient.getStreets(searchQuery);
  }

  /// This function will get all avaiable house numbers of the
  /// provided [streetUrl]
  Future<HouseNumbers> getHouseNumbers(String streetUrl) async {
    return await apiClient.getHouseNumbers(streetUrl);
  }

  /// This function will get the trash information of the provided 
  /// addess via the [addressUrl]
  Future<AddressInformation> getAddressInformation(String addressUrl) async {
    return await apiClient.getAddressInformation(addressUrl);
  }

}