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
  bool respire;
  bool conscient;
  String description = "";
  String cas;
  bool needSecouriste = false;

  setNeedSecouriste() {
    this.needSecouriste = true;
    notifyListeners();
  }

  setCas(String cas) {
    this.cas = cas;
    notifyListeners();
  }

  setDescription(String desc) {
    this.description += desc;
    notifyListeners();
  }

  setLatitude(String latitude) {
    this.latitude = latitude;
    notifyListeners();
  }

  setLongitude(String longitude) {
    this.longitude = longitude;
    notifyListeners();
  }

  setRespire(bool val) {
    this.respire = val;
    notifyListeners();
  }

  setConscient(bool val) {
    this.conscient = val;
    notifyListeners();
  }

  Map getInfo() {
    return {
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "description": this.description,
      "cas": this.cas,
      "need_secouriste": this.needSecouriste
    };
  }

  Future<List<Accident>> getInterventions() async {
    var args = await AccidentService.getInProgressInterventions();
    notifyListeners();
    return args;
  }
}
