import 'package:brashapp/provider/HomePageProvider.dart';
import 'package:brashapp/widgets/CustomSearchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:brashapp/widgets/OverviewWidget.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController;

  HomePageProvider get provider => Provider.of<HomePageProvider>(context);


  void popUpMenuHandler(int index){
    switch(index){
      case 1:
        // Löschen
        provider.removeFromHomePage(_pageController.page.floor());
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
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
            appBar: AppBar(
              title: const Text('Brashapp'),
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
                      // TODO(kiesman): Add functionality for disabillity of items
                      PopupMenuItem<int>(
                        child: const Text('Zum Kalender hinzufügen'),
                        value: 2,
                        enabled: true,
                      ),
                      PopupMenuItem<int>(
                        child: const Text('Löschen'),
                        value: 1,
                        enabled: true,
                      ),
                    ]
                )
              ],
            ),
            body: const Center(
              child: Text('Hier ist noch nicht viel'),
            )
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
