import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/pages/HouseNumberPicker.dart';
import 'package:brashapp/provider/StreetPickerProvider.dart';
import 'package:brashapp/service/StreetPickerSpiderService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Consumer<StreetPickerProvider>(
      builder: (context, provider, _){
        if(provider.response is ErrorModel){
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text((provider.response as ErrorModel).message),
              )
            ],
          );
        }else if(provider.response is StreetPickerModel){
          StreetPickerModel model = provider.response;
          return ListView.builder(
            itemCount: model.streets.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(model.streets.elementAt(index).name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseNumberPicker(model.streets.elementAt(index).href)
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
    // if search term is empty
    if(query.isEmpty){
      return ListView(
        children: <Widget>[
          ListTile(
            title: Text("Suche nach einer Straße"),
          )
        ],
      );
    }

    Provider.of<StreetPickerProvider>(context).fetch(query);

    return Consumer<StreetPickerProvider>(
      builder: (context, provider, _){
        if(provider.response is ErrorModel){
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text((provider.response as ErrorModel).message),
              )
            ],
          );
        }else if(provider.response is StreetPickerModel){
          StreetPickerModel model = provider.response;
          return ListView.builder(
            itemCount: model.streets.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(model.streets.elementAt(index).name),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HouseNumberPicker(model.streets.elementAt(index).href)
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
}