import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import './MyDetailPage.dart';
import 'package:get/get.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/widgets/rating.dart';

class InstructionList extends StatefulWidget {
  @override
  _InstructionListState createState() => _InstructionListState();
}

class _InstructionListState extends State<InstructionList> {
  //rating Dialog
  int _rating;
  createRatingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (buildContext) {
          return Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            padding: EdgeInsets.all(40.0),
            margin: EdgeInsets.all(20.0),
            height: 200,
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo croissant rouge
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/profil.png',
                      height: 80,
                      width: 100,
                    ),
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.redAccent[700],
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                ),
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12))),
                    child: Column(children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        'NOTE DE SECOURISTE',
                        style: TextStyle(fontSize: 18, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Rating((rating) {
                        setState(() {
                          _rating = rating;
                        });
                      }, 5),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PageAlerte()),
                        ),
                        child: Text('Soumettre'),
                        color: Colors.white,
                        textColor: Colors.redAccent[100],
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                    ]))
              ],
            ),
          );
        });
  }

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
          title: 'L\'étouffement',
          img: 'suffocation.PNG',
          steps:
              "Donnez un maximum de 5 claques dans le dos de la victime (entre les omoplates), afin de provoquer une toux et de déloger l'objet bloquant la respiration. \n Si cette action ne suffit pas, effectuez un maximum de 5 compressions abdominales. \n Placez-vous derrière la victime et posez un de vos point fermé entre le nombril et l'extrémité inférieure du sternum. \n Le problème persiste? Alternez 5 claques dans le dos et 5 pressions abdominales. \n La victime perd connaissance, posez-la délicatement au sol et alertez rapidement les secours. "),
      Instruction(
          title: 'Le saignement',
          img: 'bleed.PNG',
          steps:
              "Dans un premier temps, évitez de mettre vos mains, non protégées, au contact de son sang. \n Demandez-lui d'effectuer un point de compression sur sa plaie. \nDemandez à une personne de prévenir les secours, ou faites-le vous-même si vous êtes seul. \nSi vos mains sont protégées, exercez directement une pression sur sa plaie.\n Allongez la victime en position horizontale.\n La vue du sang provoque souvent des malaises chez les victimes.\n Si la blessure ne cesse de saigner, appuyez plus fermement sur la plaie, et attendez l'arrivée des secours."),
      Instruction(
          title: 'La perte de conscience',
          img: 'inconscient.PNG',
          steps:
              "Avant d'entreprendre quoi que se soit, vérifiez que la victime ne réagit pas.\n Libérez les voies aériennes, et dégagez son cou de tout accessoire qui gênerait sa respiration.\n Tournez la victime sur le côté en position latérale de sécurité.\n Demandez à quelqu'un d'appeler les secours ou allez chercher de l'aide si vous êtes seul.\n Vérifiez régulièrement la respiration de la victime jusqu'à l'arrivée des secours."),
      Instruction(
          title: 'L\'arret cardiaque',
          img: 'heart.PNG',
          steps:
              "Si la victime ne réagit pas et ne respire pas normalement, prévenez les secours ou demandez à des personnes de le faire à votre place, chaque minute compte.\n Libérez les voies aériennes et commencez par effectuer 30 compressions thoraciques. \n Pratiquez ensuite 2 insufflations (si cela vous a été enseigné). \nContinuez la réanimation jusqu'à l'arrivée des secours."),
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
            height: 50.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //messaginButton
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ChatScreen();
                    })
              },
          tooltip: 'Increment',
          backgroundColor: Colors.redAccent[700],
          child: Icon(Icons.messenger)),
      //appBar
      appBar: AppBar(
        title: Center(
            child: Text(
          'Instructions',
          textAlign: TextAlign.center,
        )),
        backgroundColor: Colors.redAccent[700],
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.home_outlined, size: 30),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageAlerte()),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  key: _listKey,
                  shrinkWrap: true,
                  itemCount: _instructionTiles.length,
                  itemBuilder: (context, index) {
                    return _instructionTiles[index];
                  }), //CONTACTER NOUS
              //EndAlertButton
              Container(
                padding: EdgeInsets.only(top: 60),
                height: 120.0,
                width: 150.0,
                //margin: EdgeInsets.all(20),
                child: RaisedButton(
                  onPressed: () => createRatingDialog(context),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFFe84f4c), Color(0xFFe2231e)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "endButton".tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2.2),
                      ),
                    ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
