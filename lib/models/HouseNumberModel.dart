/// This is a model holding a housenumber
/// for a selected street. A collection of
/// all HouseNumbers of a street will be
/// stored in [HouseNumbers]
class HouseNumber{

  /// The street number of the selected house
  String number;

  /// The url that has to be injected into the request to the
  /// api to get information about the selected street + housnumber
  String href;

  HouseNumber({this.number, this.href});

  /// A custom constructor to generate a [HouseNumber] model
  /// from the responses json
  factory HouseNumber.fromJson(Map<String, dynamic> json){
    return HouseNumber(
      number: json["house_number"],
      href: json["href"]
    );
  }
}