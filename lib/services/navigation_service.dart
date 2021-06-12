import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/models/accident.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, acc) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: acc);
  }

  goBack() {
    return navigatorKey.currentState.pop();
  }
}
