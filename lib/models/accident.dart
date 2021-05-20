import 'package:google_maps_flutter/google_maps_flutter.dart';

class Accident {
  final String id;
  final String idtemoin;
  final String idsecouriste;
  final String status;
  final LatLng localisation;
  final String localite;
  final String address;
  final bool needSecouriste;
  final String cas;
  final String description;

  Accident(
      {this.id,
      this.idsecouriste,
      this.idtemoin,
      this.localisation,
      this.status,
      this.localite,
      this.address,
      this.cas,
      this.description,
      this.needSecouriste});

  Accident.fromJson(Map<dynamic, dynamic> json)
      : id = json["id"],
        idtemoin = json["id_temoin"],
        idsecouriste = json["id_secouriste"],
        status = json["status"],
        localisation = LatLng(json["latitude"], json["longitude"]),
        cas = json["cas"],
        description = json["description"],
        localite = json["localité"],
        address = json["address"],
        needSecouriste = json["need_secouriste"];

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "id_secouriste": idsecouriste,
        "id_temoin": idtemoin,
        "status": status,
        "localisation": localisation,
        "cas": cas,
        "description": description,
        "need_secouriste": needSecouriste
      };
}
