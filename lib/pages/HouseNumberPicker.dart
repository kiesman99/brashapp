import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/models/HouseNumberPickerModel.dart';
import 'package:brashapp/pages/FinalSelectionPage.dart';
import 'package:brashapp/provider/HouseNumberProvider.dart';
import 'package:brashapp/widgets/ApiHandlerWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<HouseNumberProvider>(context).fetch(widget.searchQuery);
    return Consumer<HouseNumberProvider>(
      builder: (context, provider, _){
        if(provider.response is ErrorModel){
          ErrorModel model = provider.response as ErrorModel;
          return Scaffold(
            body: Center(
              child: Text(model.message),
            ),
          );
        }else if(provider.response is HouseNumbers){
          HouseNumbers model = provider.response as HouseNumbers;
          return Scaffold(
            appBar: AppBar(
              title: Text(model.street),
            ),
            body: ListView.builder(
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
            ),
          );
        }

        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    return ApiHandlerWidget(
      future: houseNumbers,
      childBuilder: (response){
        HouseNumbers model = response as HouseNumbers;
        return Scaffold(
          appBar: AppBar(
            title: Text(model.street),
          ),
          body: ListView.builder(
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
          ),
        );
      },
    );
  }
}