import 'dart:io';
import 'package:brashapp/api/client/BrashApiClient.dart';
import 'package:brashapp/api/repositories/BrashRepository.dart';
import 'package:brashapp/bloc/address_information_bloc/AddressInformationBloc.dart';
import 'package:brashapp/bloc/house_number_picker_bloc/house_number_picker_bloc.dart';
import 'package:brashapp/bloc/street_picker_bloc/street_picker_bloc.dart';
import 'package:brashapp/pages/HouseNumberPicker.dart';
import 'package:brashapp/provider/HomePageProvider.dart';
import 'package:brashapp/provider/HouseNumberProvider.dart';
import 'package:brashapp/provider/StreetPickerProvider.dart';
import 'package:brashapp/provider/TrashEntriesProvider.dart';
import 'package:brashapp/utils/vm.dart' if (dart.library.html) 'package:brashapp/utils/js.dart';
import 'package:brashapp/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {

  final BrashRepository brashRepository = BrashRepository(
    apiClient: BrashApiClient(
      httpClient: http.Client()
    )
  );

  // init language and then init app
  initializeDateFormatting('de_DE', null).then((dynamic _) => runApp(MyApp(brashRepository: brashRepository)));
}

class MyApp extends StatelessWidget {

  MyApp({this.brashRepository});

  BrashRepository brashRepository;

  Future<void> openBoxes() async {
    if (!isBrowser) {
      final Directory dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }
    return Future.wait(<Future<Box<dynamic>>>[
      Hive.openBox<dynamic>('pages'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StreetPickerBloc>(
          create: (BuildContext _) => StreetPickerBloc(brashRepository),
        ),
        BlocProvider<HouseNumberPickerBloc>(
          create: (BuildContext _) => HouseNumberPickerBloc(brashRepository)
        ),
        BlocProvider<AddressInformationBloc>(
          create: (BuildContext _) => AddressInformationBloc(brashRepository)
        )
      ],
      child: MaterialApp(
          title: 'Brash',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage()
      ),
    );
  }
}
