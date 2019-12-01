import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePageProvider extends ChangeNotifier {

  void addToHomePage(String url){
    Hive.box("pages").add(url);
  }

  void removeFromHomePage(int index){
    Hive.box("pages").deleteAt(index);
  }

}