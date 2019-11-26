import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/TrashEntriesModel.dart';
import 'package:brashapp/models/TrashInformationModel.dart';
import 'package:brashapp/pages/HomePage.dart';
import 'package:brashapp/service/TrashSpiderService.dart';
import 'package:brashapp/widgets/ApiHandlerWidget.dart';
import 'package:brashapp/widgets/OverviewWidget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FinalSelectionPage extends StatefulWidget {

  final String searchQuery;

  FinalSelectionPage({this.searchQuery});

  @override
  _FinalSelectionPageState createState() => _FinalSelectionPageState();
}

class _FinalSelectionPageState extends State<FinalSelectionPage> {

  Future<ApiResponse> trashInformation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    trashInformation = TrashSpiderService().getResponse(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bestätigen"),
      ),
      body: ApiHandlerWidget(
        future: trashInformation,
        childBuilder: (response) {
          return OverviewWidget(model: response as TrashEntriesModel);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Hive.box("pages").add(widget.searchQuery);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage())
            );
          },
          label: Text("Hinzufügen")
      ),
    );
  }
}
