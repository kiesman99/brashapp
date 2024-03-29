import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/TrashEntryModel.dart';

/// This is the model that is holding all information about
/// a street + housnumber in a list of [TrashEntry]
class AddressInformation extends ApiResponse{

  AddressInformation({this.currentStreet, this.pickUpDay, this.allTrashEntries, this.nextDateIndex});

  AddressInformation.empty(){
    currentStreet = '';
    allTrashEntries = null;
    nextDateIndex = null;
    pickUpDay = '';
  }

  factory AddressInformation.fromJson(Map<String, dynamic> json){
    final List<TrashEntry> entries = <TrashEntry>[];
    json['data']['data'].forEach((dynamic json) => entries.add(TrashEntry.fromJson(json)));

    return AddressInformation(
      currentStreet: json['currentStreet'] ?? '',
      pickUpDay: json['data']['abholtag'] ?? '',
      allTrashEntries: entries,
      nextDateIndex: getNextDateIndex(entries)
    );
  }
  
  /// This is the street that the information is about
  String currentStreet;

  /// This is the day on which the pick ups happen
  String pickUpDay;

  /// This holds the next date the pick up will happen
  int nextDateIndex;

  /// This is the list of all [TrashEntry] models that were fetched from the api
  List<TrashEntry> allTrashEntries;

  /// This is the list of all [TrashEntry] models that are relevant
  ///
  /// [TrashEntry] models that have a surpassed date are not considered
  /// as relevant
  List<TrashEntry> get relevantTrashEntries => allTrashEntries.where(
    (TrashEntry entry) => DateTime.now().compareTo(DateTime.parse(entry.date)) < 0
    ).toList();

  // TODO(kiesman): This has to be refactored to retrieving the actual Date and not the index
  /// This function will get the index of the next date
  /// that the pick up will happen
  static int getNextDateIndex(List<TrashEntry> entries){
    //return 2;
    final DateTime now = DateTime.now();
    int index = -1;
    
    for(int i = 0; i < entries.length; i++){
      final DateTime d = DateTime.parse(entries.elementAt(i).date);
      if(now.compareTo(d) > 0)
        index = i;
    }

    return now.compareTo(DateTime.parse(entries.elementAt(index).date)) == 0 ? index : ++index;
  }

}