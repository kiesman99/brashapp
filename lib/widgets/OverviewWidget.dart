import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/TrashEntriesModel.dart';
import 'package:brashapp/service/TrashSpiderService.dart';
import 'package:brashapp/widgets/ApiHandlerWidget.dart';
import 'package:flutter/material.dart';

import 'dart:core';

import 'package:intl/intl.dart';

class OverviewWidget extends StatefulWidget {
  final searchQuery;

  OverviewWidget(this.searchQuery);

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
    trashInformation = TrashSpiderService().getResponse(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return ApiHandlerWidget(
      future: trashInformation,
      childBuilder: (response) {
        TrashEntriesModel model = response as TrashEntriesModel;
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
                        Text(model.abholtag),
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
      },
    );
  }
}

