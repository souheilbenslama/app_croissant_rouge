//KHALIL

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
}
