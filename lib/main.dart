import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/pages/home.dart';
import 'injection_container.dart' as injectionContainer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = "pt_BR";
  initializeDateFormatting();

  injectionContainer.init();
  GetIt.I.isReady<SharedPreferences>().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}