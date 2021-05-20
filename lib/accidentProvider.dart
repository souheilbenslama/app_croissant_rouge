import 'package:app_croissant_rouge/models/choix_conscience.dart';
import 'package:app_croissant_rouge/models/choix_hemorragie.dart';
import 'package:app_croissant_rouge/models/choix_protection.dart';
import 'package:app_croissant_rouge/models/choix_respiration.dart';
import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/services/secouriste_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'models/accident.dart';

class AccidentProvider with ChangeNotifier {
  String latitude;
  String longitude;
  bool respire;
  bool conscient;
  String description = "";
  String cas;
  bool needSecouriste = false;
  LocationData currentLocation;
  String token;

  getCurrentLocation() {
    if (currentLocation == null) {
      getPosition().then((value) {
        this.currentLocation = value;
      });
    }
    return this.currentLocation;
  }

  settoken(token) {
    this.token = token;
  }

  gettoken() {
    return this.token;
  }

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
      "latitude": latitude,
      "longitude": longitude,
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
