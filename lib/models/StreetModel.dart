class StreetModel {
  String name;
  String href;

  StreetModel({this.name, this.href});

  factory StreetModel.fromJson(Map<String, dynamic> json){
    return StreetModel(
      name: json["street"],
      href: json["href"]
    );
  }
}