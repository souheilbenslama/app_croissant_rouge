import 'package:app_croissant_rouge/models/ChoixConscience.dart';
import 'package:app_croissant_rouge/models/ChoixHemorragie.dart';
import 'package:app_croissant_rouge/models/ChoixProtection.dart';
import 'package:app_croissant_rouge/models/ChoixRespiration.dart';
import 'package:flutter/material.dart';

class AccidentProvider with ChangeNotifier {
  double latitude;
  double longitude;
  List<ChoixConscience> choixConscience = [];
  List<ChoixHemorragie> choixHemorragie = [];
  List<ChoixRespiration> choixRespiration = [];
  List<ChoixProtection> choixProtection = [];

  setLatitude(double latitude) {
    this.latitude = latitude;
    notifyListeners();
  }

  setLongitude(double longitude) {
    this.longitude = longitude;
    notifyListeners();
  }

  addConscience(ChoixConscience choix) {
    this.choixConscience.add(choix);
    notifyListeners();
  }

  addRespiration(ChoixRespiration choix) {
    this.choixRespiration.add(choix);
    notifyListeners();
  }

  addHemorragie(ChoixHemorragie choix) {
    this.choixHemorragie.add(choix);
    notifyListeners();
  }

  addProtection(ChoixProtection choix) {
    this.choixProtection.add(choix);
    notifyListeners();
  }
}
