import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_detail_page.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:get/get.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';

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
          img: 'b1.png',
          steps:
              "-Comprimer immédiatement et fortement l’endroit qui saigne avec votre main.\n-Allonger la victime.\n-Alerter les secours.\n-Surveiller la victime et parler avec elle régulièrement.  "),
      Instruction(
          title: 'La victime vomit ou crache du sang ',
          img: 'b2.png',
          steps:
              "-Si la victime est CONSCIENTE :La mettre à la position ou elle se sent le mieux.\n-Si la victime est INCONSCIENTE: La mettre allongée sur le coté.\n-Alerter les secours.\n-Appliquer les consignes du service des secours.\n-Conserver les vomissements ou les crachés si possible.\n-Surveiller la victime et parler avec elle régulièrement."),
      Instruction(
          title: 'La victime saigne du nez',
          img: 'b3.png',
          steps:
              "-Faire asseoir la victime tête penchée en avant.\n-Lui demander de se moucher vigoureusement.\n-Lui demander de se comprimer les narines pendant 10 minutes.\n"),
      Instruction(
          title: 'La victime perd du sang d’un orifice naturel'.tr,
          img: 'b4.png',
          steps:
              "-La victime perd du sang d’un orifice naturel.\n-Allonger la victime.\n-Alerter les secours.\n-Appliquer les consignes du service des secours.\n-Surveiller la victime et parler avec elle régulièrement."),
    ];

    _instructions.forEach((Instruction instruction) {
      _instructionTiles.add(_buildTile(instruction));
    });
  }

  Widget _buildTile(Instruction instruction) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(instruction: instruction)));
      },
      contentPadding: EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(instruction.title,
              style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'case-img-${instruction.img}',
          child: Image.asset(
            'assets/images/${instruction.img}',
            height: 100.0,
            width: 100.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ChatScreen();
              })
        },
        tooltip: 'Increment',
        backgroundColor: Colors.red,
        child: Icon(Icons.messenger),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Center(child: Text('Saignement'.tr)),
        backgroundColor: Colors.redAccent[700],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Material(
              child: Text(
                '-Assurez vous que la victime est en sécurité (isoler la des risques).\n\n-Portez des gants ou glisser votre main dans un sac plastique imperméable (protégez vous).\n ',
                style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                key: _listKey,
                shrinkWrap: true,
                itemCount: _instructionTiles.length,
                itemBuilder: (context, index) {
                  return _instructionTiles[index];
                }), //CONTACTER NOUS
          ],
        ),
      ),
    );
  }
}
