import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/models/StreetPickerModel.dart';
import 'package:brashapp/pages/HouseNumberPicker.dart';
import 'package:brashapp/widgets/ApiHandlerWidget.dart';
import 'package:flutter/material.dart';
import 'package:brashapp/service/StreetPickerSpiderService.dart';

class StreetPickerPage extends StatefulWidget {

  @override
  _StreetPickerPageState createState() => _StreetPickerPageState();
}

class _StreetPickerPageState extends State<StreetPickerPage> {

  TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hinzufügen"),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 20.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Wähle deine Straße",
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 10.0),
            Text(
              "Gebe den gesamten Namen der Straße, oder den Anfangsbuchstaben ein",
                style: Theme.of(context).textTheme.subtitle,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 15.0
                  ),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: "Straßenname oder Anfangsbuchstabe"
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _StreetPicker(textEditingController.text),
          ));
        },
        child: Icon(Icons.forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _StreetPicker extends StatefulWidget {

  final String searchQuery;

  _StreetPicker(this.searchQuery);

  @override
  __StreetPickerState createState() => __StreetPickerState();
}

class __StreetPickerState extends State<_StreetPicker> {

  Future<ApiResponse> streets;



  @override
  void initState() {
    super.initState();
    streets = StreetPickerSpiderService().getResponse(widget.searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Straße Wählen"),
      ),
      body: ApiHandlerWidget(
        future: streets,
        childBuilder: (response){
          Streets model = response as Streets;
          return ListView.builder(
            itemCount: model.streets.length,
            itemBuilder: (_, index){
              return ListTile(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HouseNumberPicker(model.streets[index].href),
                        ));
                  },
                  title: Text(model.streets[index].name)
              );
            },
          );
        },
      )
    );
  }
}