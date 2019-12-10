abstract class StreetPickerEvent {}

class StreetPickerFetch extends StreetPickerEvent {

  StreetPickerFetch({this.searchQuery});

  String searchQuery;
}