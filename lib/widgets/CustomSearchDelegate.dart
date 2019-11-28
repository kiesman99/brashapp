import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/pages/HouseNumberPicker.dart';
import 'package:brashapp/service/StreetPickerSpiderService.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {

  // final Debouncer _debouncer = Debouncer(milliseconds: 500);

  CustomSearchDelegate() : super(
      searchFieldLabel: "Straße suchen",
      textInputAction: TextInputAction.search
  );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future<ApiResponse> streets = StreetPickerSpiderService().getResponse(query);

    return FutureBuilder<ApiResponse>(
      future: streets,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text("Leider gab es einen Fehler."),
              )
            ],
          );
        }

        if(snapshot.hasData){
          if(snapshot.data is ErrorModel){
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Leider gab es einen Fehler."),
                )
              ],
            );
          }

          StreetPickerModel _model = snapshot.data as StreetPickerModel;
          return ListView.builder(
            itemCount: _model.streets.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(_model.streets.elementAt(index).name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseNumberPicker(_model.streets.elementAt(index).href)
                      )
                  );
                },
              );
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Future<ApiResponse> streets = StreetPickerSpiderService().getResponse(query);
    return FutureBuilder<ApiResponse>(
      future: streets,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text("Leider gab es einen Fehler."),
              )
            ],
          );
        }

        if(snapshot.hasData){
          if(snapshot.data is ErrorModel){
            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text("Leider gab es einen Fehler."),
                )
              ],
            );
          }

          StreetPickerModel _model = snapshot.data as StreetPickerModel;
          return ListView.builder(
            itemCount: _model.streets.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(_model.streets.elementAt(index).name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseNumberPicker(_model.streets.elementAt(index).href)
                      )
                  );
                },
              );
            },
          );
        }

        return ListView(
          children: <Widget>[
            ListTile(
              title: Text("Suche nach einer Straße"),
            )
          ],
        );
      },
    );
  }
}