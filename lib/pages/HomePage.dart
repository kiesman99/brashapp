import 'package:brashapp/widgets/CustomSearchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:brashapp/widgets/OverviewWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'HouseNumberPicker.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController;


  void popUpMenuHandler(int index){
    switch(index){
      case 1:
        // Löschen
        Hive.box("pages").deleteAt(_pageController.page.floor());
        break;
      case 2:
        // Kalender
        break;
      default:
        break;
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {

    return WatchBoxBuilder(
      box: Hive.box("pages"),
      builder: (context, box) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Brashapp"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  },
                ),
                // overflow menu
                PopupMenuButton<int>(
                    onSelected: popUpMenuHandler,
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        child: Text("Zum Kalender hinzufügen"),
                        value: 2,
                        enabled: box.values.toList().length != 0,
                      ),
                      PopupMenuItem(
                        child: Text("Löschen"),
                        value: 1,
                        enabled: box.values.toList().length != 0,
                      ),
                    ]
                )
              ],
            ),
            body: main(box)
        );
      },
    );
  }

  Widget main(Box box){
    final items = box.values.toList();
    if(items.length == 0){
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
              "Du hast derzeit noch keine Straße hinzugefügt. Versuche doch mal über die Suche deine Straße zu finden :)",
              textAlign: TextAlign.center,
          ),
        ),
      );
    }



    return PageView.builder(
      controller: _pageController,
      itemCount: items.length,
      itemBuilder: (context, page){
        return OverviewWidget(searchQuery: items.elementAt(page));
      },
    );
  }
}
