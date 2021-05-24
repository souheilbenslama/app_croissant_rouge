import 'package:app_croissant_rouge/models/accident.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/services/accident_service.dart';
import 'package:app_croissant_rouge/services/user_service.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:app_croissant_rouge/models/hemorragie_Instruction.dart';
import 'package:get/get.dart';
import 'package:app_croissant_rouge/views/screens/my_hemorragie_detail_page.dart';
import 'package:app_croissant_rouge/services/socket_service.dart';
import 'package:app_croissant_rouge/models/hemorragie_Instruction.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../accidentProvider.dart';

class HemorexOui extends StatefulWidget {
  @override
  _HemorexOuiState createState() => _HemorexOuiState();
}

class _HemorexOuiState extends State<HemorexOui> {
  List<Widget> _instructionTiles = [];
  final GlobalKey _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _addInstructions();
  }

  void _addInstructions() {
    List<HemorragieInstruction> _instructions = [
      HemorragieInstruction(
          title: 'Hémorragie au travers d’un plaie',
          needButton: true,
          img: 'b1.png',
          alerteSecoure: true,
          needSecouriste: true,
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-Comprimer immédiatement et fortement l’endroit qui saigne avec votre main.\n-Allonger la victime.\n-Surveiller la victime et parler avec elle régulièrement.  "),
      HemorragieInstruction(
          title: 'La victime vomit ou crache du sang ',
          needButton: true,
          alerteSecoure: true,
          needSecouriste: false,
          img: 'b2.png',
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-Mettre la victime à la position ou elle se sent le mieux\n-Alerter les secours.\n-Conserver les vomissements ou les crachés si possible.\n-Surveiller la victime et parler avec elle régulièrement."),
      HemorragieInstruction(
          title: 'La victime saigne du nez',
          alerteSecoure: false,
          needSecouriste: false,
          needButton: true,
          img: 'b3.png',
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-Faire asseoir la victime tête penchée en avant.\n-Lui demander de se moucher vigoureusement.\n-Lui demander de se comprimer les narines pendant 10 minutes.\n"),
      HemorragieInstruction(
          title: 'Saignement d’un orifice naturel'.tr,
          alerteSecoure: true,
          needSecouriste: false,
          needButton: true,
          img: 'b4.png',
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-La victime perd du sang d’un orifice naturel.\n-Allonger la victime.\n-Alerter les secours.\n-Appliquer les consignes du service des secours.\n-Surveiller la victime et parler avec elle régulièrement."),
    ];

    _instructions.forEach((HemorragieInstruction instruction) {
      _instructionTiles.add(_buildTile(instruction));
    });
  }

  Widget _buildTile(HemorragieInstruction instruction) {
    LocationData _locationData;
    String userId;
    return Container(
      height: 500,
      width: 500,
      child: ListTile(
        onTap: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HemorragieDetails(instruction: instruction),
            ),
          );
          if (instruction.alerteSecoure) {
            const number = '198';
            FlutterPhoneDirectCaller.callNumber(number);
          }

          if (instruction.needSecouriste) {
            final doc = Provider.of<AccidentProvider>(context, listen: false);

            doc.setDescription(" " + instruction.title);
            doc.setNeedSecouriste();

            if (doc.getCurrentLocation() != null) {
              _locationData = doc.currentLocation;
              String latitude = _locationData.latitude.toString();
              String longitude = _locationData.longitude.toString();
              doc.setLatitude(latitude);
              doc.setLongitude(longitude);
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  _locationData.latitude, _locationData.latitude);

              final localite = placemarks[0].subAdministrativeArea;

              final address = placemarks[0].administrativeArea +
                  "  " +
                  placemarks[0].subAdministrativeArea +
                  " " +
                  placemarks[0].locality +
                  " " +
                  placemarks[0].street +
                  " " +
                  placemarks[0].postalCode;

              var jsondoc = doc.getInfo();
              print(jsondoc);

              if (doc.gettoken() != null) {
                final decodedToken = JwtDecoder.decode(doc.gettoken());
                userId = decodedToken["id"];
              } else {
                var details = await getDeviceDetails();
                String deviceId = details[2];
                userId = jsonDecode(
                    await UserService.attemptgetUser(deviceId))["_id"];
              }
              var res2 = await AccidentService.createAccident(
                  userId,
                  jsondoc["longitude"],
                  jsondoc["latitude"],
                  jsondoc["cas"],
                  jsondoc["description"],
                  jsondoc["need_secouriste"],
                  address,
                  localite);
              doc.setCurrentAccident(Accident.fromJson(jsonDecode(res2)));
              SocketService.connect();
            }
          }
        },
        contentPadding: EdgeInsets.all(25),
        title: Card(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Hero(
                  tag: 'case-img-${instruction.img}',
                  child: Image.asset(
                    'assets/images/${instruction.img}',
                    height: 50,
                    width: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                instruction.title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Hemorragies Externes'.tr),
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.09,
            ),
            Image.asset(
              "assets/profil.png",
              height: 100,
            ),
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              key: _listKey,
              shrinkWrap: true,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              crossAxisCount: 2,
              children: _instructionTiles,
            ),
          ],
        ),
      ),
    );
  }
}
