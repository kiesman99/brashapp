import 'package:brashapp/pages/FinalSelectionPage.dart';
import 'package:brashapp/pages/StreetPickerPage.dart';
import 'package:flutter/material.dart';
import 'package:brashapp/widgets/OverviewWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<String> pages = [
    "http%3A%2F%2F213.168.213.236%2Fbremereb%2Fbify%2Fbify.jsp%3Fstrasse%3DEmanuelstra%25DFe%26hausnummer%3D15",
    "http%3A%2F%2F213.168.213.236%2Fbremereb%2Fbify%2Fbify.jsp%3Fstrasse%3DPagentorner Stra%25DFe%26hausnummer%3D4",
    "http%3A%2F%2F213.168.213.236%2Fbremereb%2Fbify%2Fbify.jsp%3Fstrasse%3DPagentorner Stra%25DFe%26hausnummer%3D13",
    "http%3A%2F%2F213.168.213.236%2Fbremereb%2Fbify%2Fbify.jsp%3Fstrasse%3DLachmundsdamm%26hausnummer%3D5"
  ];

  void popUpMenuHandler(int index){

    switch(index){
      case 1:
        // Hinzufügen
        Navigator.push(context, MaterialPageRoute(builder: (context) => StreetPickerPage()));
        break;
      case 2:
        // Löschen
        break;
      case 3:
        // Kalender
        break;
      default:
        break;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Brashapp"),
        actions: <Widget>[
          // overflow menu
          PopupMenuButton<int>(
            onSelected: popUpMenuHandler,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Text("Hinzufügen"),
                value: 1,
              ),
              PopupMenuItem(
                child: Text("Zum Kalender hinzufügen"),
                value: 2,
              ),
              PopupMenuItem(
                child: Text("Löschen"),
                value: 3,
              ),
            ]
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (context, page){
          return OverviewWidget(pages.elementAt(page));
        },
      ),
    );
  }
}
