class HouseNumberModel{
  String number;
  String href;

  HouseNumberModel({this.number, this.href});

  factory HouseNumberModel.fromJson(Map<String, dynamic> json){
    return HouseNumberModel(
      number: json["house_number"],
      href: json["href"]
    );
  }
}