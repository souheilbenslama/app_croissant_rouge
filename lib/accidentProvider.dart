import 'package:app_croissant_rouge/models/choix_conscience.dart';
import 'package:app_croissant_rouge/models/choix_hemorragie.dart';
import 'package:app_croissant_rouge/models/message_model.dart';
import 'package:app_croissant_rouge/models/accident.dart';
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
  List<String> description = [];
  List<Message> messages = [];
  String cas;
  bool needSecouriste = false;
  LocationData currentLocation;
  String token;
  Accident currentAccident;

  getMessages() {}

  addMessage(Message m) {
    this.messages.add(m);
    notifyListeners();
  }

  setCurrentAccident(Accident accident) {
    this.currentAccident = accident;
    notifyListeners();
  }

  Accident getCurrentAccident() {
    return this.currentAccident;
  }

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
    notifyListeners();
  }

  gettoken() {
    return this.token;
  }

  setNeedSecouriste() {
    this.needSecouriste = true;
    notifyListeners();
  }

  clear() {
    this.cas = null;
    this.description = [];
    this.needSecouriste = false;
    notifyListeners();
  }

  setNotNeedSecouriste() {
    this.needSecouriste = false;
    notifyListeners();
  }

  setCas(String cas) {
    this.cas = cas;
    notifyListeners();
  }

  setDescription(String desc) {
    if (this.description[this.description.length - 1] != desc)
      this.description.add(desc);
    notifyListeners();
  }

  removeDescription() {
    if (this.description.length > 0)
      this.description.removeAt(this.description.length - 1);
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
    String dsc = "";
    if (description != null)
      this.description.forEach((element) {
        dsc = dsc + element + "\n";
      });

    return {
      "latitude": latitude,
      "longitude": longitude,
      "description": dsc,
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
