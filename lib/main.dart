import 'dart:io';
import 'package:brashapp/provider/HouseNumberProvider.dart';
import 'package:brashapp/provider/StreetPickerProvider.dart';
import 'package:brashapp/utils/vm.dart' if (dart.library.html) 'package:brashapp/utils/js.dart';
import 'package:brashapp/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';


void main() {
  // init language and then init app
  initializeDateFormatting("de_DE", null).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {

  Future openBoxes() async {
    if (!isBrowser) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    return Future.wait([
      Hive.openBox('pages'),
    ]);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => HouseNumberProvider()),
        ChangeNotifierProvider(builder: (_) => StreetPickerProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
              future: openBoxes(),
              builder: (_, snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.error != null) {
                    print(snapshot.error);
                    return Scaffold(
                      body: Center(
                        child: Text('Something went wrong :/'),
                      ),
                    );
                  } else {
                    return HomePage();
                  }
                } else {
                  return Scaffold(
                    body: Center(
                      child: Text('Opening Hive...'),
                    ),
                  );
                }
              }
          )
      ),
    );
  }
}
