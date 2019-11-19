import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/pages/FinalSelectionPage.dart';
import 'package:brashapp/service/HouseNumberPickerSpiderService.dart';
import 'package:brashapp/widgets/ApiHandlerWidget.dart';
import 'package:flutter/material.dart';

import 'package:brashapp/widgets/OverviewWidget.dart';

class HouseNumberPicker extends StatefulWidget {

  final String searchQuery;

  HouseNumberPicker(this.searchQuery);

  @override
  _HouseNumberPickerState createState() => _HouseNumberPickerState();
}

class _HouseNumberPickerState extends State<HouseNumberPicker> {

  Future<ApiResponse> houseNumbers;

  @override
  void initState() {
    super.initState();
    houseNumbers = HouseNumberPickerSpiderService().getResponse(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hinzufügen"),
      ),
      body: ApiHandlerWidget(
        future: houseNumbers,
        childBuilder: (response){
          HouseNumberPickerModel model = response as HouseNumberPickerModel;
          return ListView.builder(
            itemCount: model.houseNumbers.length,
            itemBuilder: (_, index){
              return ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FinalSelectionPage(searchQuery: model.houseNumbers[index].href),
                        ));
                  },
                  title: Text(model.houseNumbers[index].number.toString())
              );
            },
          );
        },
      )
    );
  }
}