import 'package:app_croissant_rouge/models/ChoixConscience.dart';
import 'package:app_croissant_rouge/models/ChoixHemorragie.dart';
import 'package:app_croissant_rouge/models/ChoixProtection.dart';
import 'package:app_croissant_rouge/models/ChoixRespiration.dart';
import 'package:flutter/material.dart';

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
}
