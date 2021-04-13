import 'dart:html';

import 'package:app_croissant_rouge/model/locationData.dart';

class Accident {
  int id;
  int id_temoin;
  int id_secouriste;
  String protectionDesc;
  String respirationDesc;
  String hemorragieDesc;
  String conscienceDesc;
  String status;
  LocationData localisation;

  Accident(
      {this.id,
      this.id_secouriste,
      this.id_temoin,
      this.conscienceDesc,
      this.hemorragieDesc,
      this.localisation,
      this.protectionDesc,
      this.respirationDesc,
      this.status});
  Accident.fromJson(Map<dynamic, dynamic> json)
      : id = int.parse(json["id"]),
        id_temoin = int.parse(json["id_temoin"]),
        id_secouriste = int.parse(json["id_secouriste"]),
        protectionDesc = json["protectionDesc"],
        respirationDesc = json["respirationDesc"],
        hemorragieDesc = json["hemorragieDesc"],
        conscienceDesc = json["conscienceDesc"],
        status = json["status"],
        localisation = json["LocationData"];
  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "id_secouriste": id_secouriste,
        "id_temoin": id_temoin,
        "protectionDesc": protectionDesc,
        "respirationDesc": respirationDesc,
        "hemorragieDesc": hemorragieDesc,
        "conscienceDesc": conscienceDesc,
        "status": status,
        "localisation": localisation,
      };
}
