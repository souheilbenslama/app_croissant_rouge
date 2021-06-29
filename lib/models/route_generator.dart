import 'package:app_croissant_rouge/views/screens/public_map.dart';
import 'package:flutter/material.dart';

import '../views/screens/page_alerte.dart';
import '../views/screens/map_page.dart';
import '../views/screens/question_conscience.dart';
import '../views/screens/sign_in.dart';

import '../views/screens/admin_dashboard.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    var arguments = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => PageAlerte());
      case '/signIn':
        return MaterialPageRoute(builder: (_) => SignIn());
      case '/map':
        return MaterialPageRoute(builder: (_) => MapPage(arguments));
      case '/publicmap':
        return MaterialPageRoute(builder: (_) => PublicMap());
      case '/options':
        return MaterialPageRoute(builder: (_) => Conscient());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => AdminDashboard());

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
