import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_detail_page.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:get/get.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    List<Instruction> _instructions = [
      Instruction(
          title: 'Hémorragie au travers d’un plaie',
          needButton: true,
          img: 'b1.png',
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-Comprimer immédiatement et fortement l’endroit qui saigne avec votre main.\n-Allonger la victime.\n-Alerter les secours.\n-Surveiller la victime et parler avec elle régulièrement.  "),
      Instruction(
          title: 'La victime vomit ou crache du sang ',
          needButton: true,
          img: 'b2.png',
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-La mettre allongée sur le coté.\n-Alerter les secours.\n-Appliquer les consignes du service des secours.\n-Conserver les vomissements ou les crachés si possible.\n-Surveiller la victime et parler avec elle régulièrement."),
      Instruction(
          title: 'La victime saigne du nez',
          needButton: true,
          img: 'b3.png',
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-Faire asseoir la victime tête penchée en avant.\n-Lui demander de se moucher vigoureusement.\n-Lui demander de se comprimer les narines pendant 10 minutes.\n"),
      Instruction(
          title: 'Saignement d’un orifice naturel'.tr,
          needButton: true,
          img: 'b4.png',
          steps:
              "-Assurez vous que la victime est en sécurité (isoler la des risques).\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n-La victime perd du sang d’un orifice naturel.\n-Allonger la victime.\n-Alerter les secours.\n-Appliquer les consignes du service des secours.\n-Surveiller la victime et parler avec elle régulièrement."),
    ];

    _instructions.forEach((Instruction instruction) {
      _instructionTiles.add(_buildTile(instruction));
    });
  }

  Widget _buildTile(Instruction instruction) {
    return Container(
      height: 500,
      width: 500,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Details(instruction: instruction),
            ),
          );
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
        automaticallyImplyLeading: false,
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
