import 'package:brashapp/models/ErrorModel.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {

  final ErrorModel errorModel;

  ErrorWidget(this.errorModel);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorModel.message),
    );
  }
}
