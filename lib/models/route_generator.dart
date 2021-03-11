import 'package:flutter/material.dart';

import '../views/screens/page_alerte.dart';
import '../views/screens/map_page.dart';
import '../views/screens/Protection.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => PageAlerte());
      //case '/profile':
      case '/map':
        return MaterialPageRoute(builder: (_) => MapPage());
      case '/options':
        return MaterialPageRoute(builder: (_) => Protection());
      default:
        // if there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Error',
          ),
          backgroundColor: Colors.redAccent[700],
        ),
        body: Center(
          child: Text('ERROR!!'),
        ),
      );
    });
  }
}
