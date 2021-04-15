import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import './MyDetailPage.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';

class InstructionList extends StatefulWidget {
  @override
  _InstructionListState createState() => _InstructionListState();
}

class _InstructionListState extends State<InstructionList> {
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
        title: Center(child: Text('Instructions')),
        backgroundColor: Colors.redAccent[700],
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
            Container(
              padding: EdgeInsets.only(top: 60),
              height: 120.0,
              width: 150.0,
              //margin: EdgeInsets.all(20),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
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
                      "Terminer ",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
