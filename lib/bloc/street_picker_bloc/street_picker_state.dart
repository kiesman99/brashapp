import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:flutter/material.dart';

abstract class StreetPickerState {

  StreetPickerState({this.streets});

  final Streets streets;
}

class StreetPickerInitial extends StreetPickerState {

  StreetPickerInitial() :
    super(streets: Streets.empty());

}

class StreetPickerFetchInProgress extends StreetPickerState {

  StreetPickerFetchInProgress() : 
    super(streets: Streets.empty());
}

class StreetPickerFetchSuccess extends StreetPickerState {

  StreetPickerFetchSuccess({
    @required Streets streets
    }) :
      assert(streets != null),
      super(streets: streets);

}

class StreetPickerFetchFailure extends StreetPickerState {

  StreetPickerFetchFailure({this.errorMessage}) :
    assert(errorMessage.isNotEmpty),
    super(streets: Streets.empty());

  final String errorMessage;
}


