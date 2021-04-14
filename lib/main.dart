import 'package:app_croissant_rouge/models/accident.dart';
import 'package:app_croissant_rouge/models/route_generator.dart';
import 'package:app_croissant_rouge/views/screens/PublicMap.dart';
import 'package:app_croissant_rouge/views/screens/admin_dashboard.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:app_croissant_rouge/views/screens/MyHomePage.dart';
import 'package:app_croissant_rouge/views/screens/Profile.dart';
import 'package:app_croissant_rouge/views/screens/SignUp.dart';
import 'package:app_croissant_rouge/views/screens/SignIn.dart';
import 'package:app_croissant_rouge/views/screens/map_page.dart';
import 'package:app_croissant_rouge/views/screens/test_map.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'views/screens/page_alerte.dart';

import './views/screens/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './views/screens/Profile.dart';
import 'dart:convert' show json, base64, ascii;
import './views/screens/page_alerte.dart';
import 'views/screens/page_alerte.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Accident> ll = new List();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: SignUp(),
      //home: MapePage()
      home: PublicMap(),
    );
  }
}
