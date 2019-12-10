import 'package:brashapp/models/AddressInformation.dart';
import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/provider/TrashEntriesProvider.dart';
import 'package:flutter/material.dart';

import 'dart:core';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OverviewWidget extends StatefulWidget {
  final searchQuery;
  final AddressInformation model;

  OverviewWidget({this.searchQuery = "", this.model});

  @override
  _OverviewWidgetState createState() => _OverviewWidgetState();
}

class _OverviewWidgetState extends State<OverviewWidget> {
  Future<ApiResponse> trashInformation;
  ScrollController scrollController;

  @override
  void initState() {
    print(widget.searchQuery);
    scrollController = new ScrollController();
    super.initState();
    if(widget.searchQuery != "")
      Provider.of<TrashEntriesProvider>(context).fetch(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.searchQuery != ""){

      return Consumer<TrashEntriesProvider>(
        builder: (context, provider, child){
          if(provider.response is ErrorModel){
            return Scaffold(
              body: Center(
                child: Text("Ein Fehler ist aufgetreten"),
              )
            );
          } else if(provider.response is AddressInformation){
            AddressInformation model = provider.response;
            return _MainElement(model, scrollController);
          }

          return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              )
          );
        },
      );
    }

    return _MainElement(widget.model, scrollController);
  }
}

class _MainElement extends StatelessWidget {

  final AddressInformation model;
  final ScrollController scrollController;

  _MainElement(this.model, this.scrollController);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          //SizedBox(height: 20.0),
          Card(
              margin:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    Text(model.currentStreet,
                        style: Theme.of(context).textTheme.headline),
                    SizedBox(height: 10.0),
                    Text(model.pickUpDay),
                    SizedBox(height: 5.0),
                    Divider(),
                    SizedBox(height: 20.0),
                    Text("Nächster Termin:"),
                    SizedBox(height: 10.0),
                    Text(DateFormat("EEEE - dd.MM.yyyy", "de_DE").format(
                        DateTime.parse(model
                            .allTrashEntries[model.nextDateIndex].date)))
                  ],
                ),
              )),
          //SizedBox(height: 20.0),
          Flexible(
            child: ListView.builder(
              controller: scrollController,
              itemCount: model.relevantTrashEntries.length,
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {},
                  title: Text(model.relevantTrashEntries[index].message
                      .toString()),
                  subtitle: Text(DateFormat("dd.MM.yyyy - EEEE", "de_DE").format(
                      DateTime.parse(
                          model.relevantTrashEntries[index].date))),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

