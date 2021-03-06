<<<<<<< HEAD
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
=======
import 'package:app_croissant_rouge/views/screens/MyHomePage.dart';
import 'package:app_croissant_rouge/views/screens/Protection.dart';
>>>>>>> 4410a9d3a388f4408c7b7ea15881c0295c68ebca
import 'package:flutter/material.dart';
import './views/page_alerte.dart';

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
<<<<<<< HEAD
      home: ChatScreen(),
=======
      home: PageAlerte(),

>>>>>>> 4410a9d3a388f4408c7b7ea15881c0295c68ebca
    );
  }
}
