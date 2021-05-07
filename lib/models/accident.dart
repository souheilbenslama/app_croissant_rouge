import 'package:google_maps_flutter/google_maps_flutter.dart';

class Accident {
  String id;
  String id_temoin;
  String id_secouriste;
  String protectionDesc;
  String respirationDesc;
  String hemorragieDesc;
  String conscienceDesc;
  String status;
  LatLng localisation;

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
      : id = json["id"],
        id_temoin = json["id_temoin"],
        id_secouriste = json["id_secouriste"],
        protectionDesc = json["protectionDesc"],
        respirationDesc = json["respirationDesc"],
        hemorragieDesc = json["hemorragieDesc"],
        conscienceDesc = json["conscienceDesc"],
        status = json["status"],
        localisation = LatLng(json["latitude"], json["longitude"]);
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
