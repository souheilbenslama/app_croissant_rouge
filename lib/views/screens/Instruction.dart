import 'package:flutter/material.dart';
import './MyDetailPage.dart';

class Instructions extends StatefulWidget {
  Instructions({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _InstructionsState createState() => _InstructionsState();
}

class Case {
  final String img;
  final String title;
  final String body;

  Case(this.img, this.title, this.body);
}

class _InstructionsState extends State<Instructions> {
  List<Case> items = new List<Case>();
  _InstructionsState() {
    items.add(new Case("assets/suffocation.png", "L'etouffement",
        "Donnez un maximum de 5 claques dans le dos de la victime (entre les omoplates), afin de provoquer une toux et de déloger l'objet bloquant la respiration. \n Si cette action ne suffit pas, effectuez un maximum de 5 compressions abdominales. \n Placez-vous derrière la victime et posez un de vos point fermé entre le nombril et l'extrémité inférieure du sternum. \n Le problème persiste. \n Alternez 5 claques dans le dos et 5 pressions abdominales. \n La victime perd connaissance, posez-la délicatement au sol et alertez rapidement les secours. \n Entreprenez par la suite une réanimation cardio-pulmonaire en effectuant 30 compressions thoraciques. \n Poursuivez la réanimation jusqu'à l'arrivée des secours ou jusqu'au retour d'une respiration normale."));
    items.add(new Case("assets/bleed.png", "Le saignement",
        "°Dans un premier temps, évitez de mettre vos mains, non protégées, au contact de son sang. \n Demandez-lui d'effectuer un point de compression sur sa plaie. \nDemandez à une personne de prévenir les secours, ou faites-le vous-même si vous êtes seul. \nSi vos mains sont protégées, exercez directement une pression sur sa plaie.\n Allongez la victime en position horizontale.\n La vue du sang provoque souvent des malaises chez les victimes.\n Si la blessure ne cesse de saigner, appuyez plus fermement sur la plaie, et attendez l'arrivée des secours."));
    items.add(new Case("assets/inconsciene.png", "La perte de conscience",
        "Avant d'entreprendre quoi que se soit, vérifiez que la victime ne réagit pas.\n Libérez les voies aériennes, et dégagez son cou de tout accessoire qui gênerait sa respiration.\n Tournez la victime sur le côté en position latérale de sécurité.\n Demandez à quelqu'un d'appeler les secours ou allez chercher de l'aide si vous êtes seul.\n Vérifiez régulièrement la respiration de la victime jusqu'à l'arrivée des secours."));
    items.add(new Case("assets/heart.png", "L'arret cardiaque",
        "Si la victime ne réagit pas et ne respire pas normalement, prévenez les secours ou demandez à des personnes de le faire à votre place, chaque minute compte.\n Libérez les voies aériennes et commencez par effectuer 30 compressions thoraciques. \n Pratiquez ensuite 2 insufflations (si cela vous a été enseigné). \nContinuez la réanimation jusqu'à l'arrivée des secours."));
  }

  Widget caseCell(BuildContext ctx, int index) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text("Tap"));
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyDetailPage(items[index])));
      },
      child: Card(
          margin: EdgeInsets.all(8),
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Hero(
                      tag: items[index],
                      child: Image.asset(items[index].img),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      items[index].title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Icon(Icons.navigate_next, color: Colors.black38),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) => caseCell(context, index),
            ),
          ],
        ),
      ),
    );
  }
}
