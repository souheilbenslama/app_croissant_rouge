import 'package:google_maps_flutter/google_maps_flutter.dart';

class Accident {
  final String id;
  final String idtemoin;
  final String idsecouriste;
  final String protectionDesc;
  final String respirationDesc;
  final String hemorragieDesc;
  final String conscienceDesc;
  final String status;
  final LatLng localisation;

  Accident(
      {this.id,
      this.idsecouriste,
      this.idtemoin,
      this.conscienceDesc,
      this.hemorragieDesc,
      this.localisation,
      this.protectionDesc,
      this.respirationDesc,
      this.status});
  Accident.fromJson(Map<dynamic, dynamic> json)
      : id = json["id"],
        idtemoin = json["id_temoin"],
        idsecouriste = json["id_secouriste"],
        protectionDesc = json["protectionDesc"],
        respirationDesc = json["respirationDesc"],
        hemorragieDesc = json["hemorragieDesc"],
        conscienceDesc = json["conscienceDesc"],
        status = json["status"],
        localisation = LatLng(json["latitude"], json["longitude"]);
  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "id_secouriste": idsecouriste,
        "id_temoin": idtemoin,
        "protectionDesc": protectionDesc,
        "respirationDesc": respirationDesc,
        "hemorragieDesc": hemorragieDesc,
        "conscienceDesc": conscienceDesc,
        "status": status,
        "localisation": localisation,
      };
}
