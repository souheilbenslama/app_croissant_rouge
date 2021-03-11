import 'package:app_croissant_rouge/models/route_generator.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:app_croissant_rouge/views/screens/MyHomePage.dart';
import 'package:app_croissant_rouge/views/screens/Protection.dart';
import 'package:flutter/material.dart';
import 'views/screens/page_alerte.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
