import 'package:brashapp/models/ApiResponse.dart';
import 'package:brashapp/models/ErrorModel.dart';
import 'package:brashapp/widgets/ErrorWidget.dart' as err;
import 'package:flutter/material.dart';

typedef responseWidgetBuilder = Function(ApiResponse response);

class ApiHandlerWidget extends StatelessWidget {

  final responseWidgetBuilder childBuilder;
  final Future future;

  ApiHandlerWidget({this.childBuilder, this.future});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse>(
      future: future,
      builder: (context, snapshot){

        if(snapshot.hasError){
          print("BAAAAM");
          return err.ErrorWidget(
              ErrorModel(
                  message: "Es gab leider einen Fehler..."
              )
          );
        }

        if(snapshot.hasData){

          if(snapshot.data is ErrorModel){
            print("BOOOM");
            return err.ErrorWidget((snapshot.data as ErrorModel));
          }

          return childBuilder(snapshot.data);

        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
