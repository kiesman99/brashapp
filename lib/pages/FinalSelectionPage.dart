import 'package:brashapp/widgets/OverviewWidget.dart';
import 'package:flutter/material.dart';

class FinalSelectionPage extends StatelessWidget {

  final String searchQuery;

  FinalSelectionPage({this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bestätigen"),
      ),
      body: OverviewWidget(searchQuery),
    );
  }
}
