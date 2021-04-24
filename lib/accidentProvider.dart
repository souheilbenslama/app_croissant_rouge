import 'package:app_croissant_rouge/models/choix_conscience.dart';
import 'package:app_croissant_rouge/models/choix_hemorragie.dart';
import 'package:app_croissant_rouge/models/choix_protection.dart';
import 'package:app_croissant_rouge/models/choix_respiration.dart';
import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:flutter/material.dart';

import 'models/accident.dart';

class AccidentProvider with ChangeNotifier {
  String latitude;
  String longitude;
  List<ChoixConscience> choixConscience = [];
  List<ChoixHemorragie> choixHemorragie = [];
  List<ChoixRespiration> choixRespiration = [];
  List<ChoixProtection> choixProtection = [];

  setLatitude(String latitude) {
    this.latitude = latitude;
    notifyListeners();
  }

  setLongitude(String longitude) {
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

  Map getInfo() {
    return {
      "hemorragie": this.choixHemorragie.last.title,
      "respiration": this.choixRespiration.last.title,
      "protection": this.choixProtection.last.title,
      "conscience": this.choixConscience.last.title,
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
    };
  }

  Future<List<Accident>> getInterventions() async {
    var args = await AccidentService.getInProgressInterventions();
    notifyListeners();
    return args;
  }
}
