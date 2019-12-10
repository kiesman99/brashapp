abstract class HouseNumberPickerEvent {}

class HouseNumberPickerFetch extends HouseNumberPickerEvent {

  HouseNumberPickerFetch({this.streetUrl});

  final String streetUrl;
}