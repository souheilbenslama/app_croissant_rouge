import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:app_croissant_rouge/views/screens/my_detail_page.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';

class StepList extends StatefulWidget {
  @override
  _StepListState createState() => _StepListState();
}

class _StepListState extends State<StepList> {
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
          title: '1ère étape',
          img: 'e1.PNG',
          steps:
              "Avant de mettre une personne en position latérale de sécurité(PLS), il faut vérifier qu'elle qoit inconsciente sur le dos mais qu'elle respire toujours normalement. Desserrez si vous le pouvez le col, la cravate ou la ceinture. Si elle porte des lunettes, commencez par les lui retirer "),
      Instruction(
          title: '2ème étape',
          img: 'e2.PNG',
          steps:
              "Tout d'abord, il faut se positionner à côté(ici à droite) de la personne étendue et vérifier que vous êtes bien stable sur vos deux genoux. Une fois que vous êtes bien installé, prenez, avec votre main gauche, celle du patient. Et appliquez le dos de sa main gauche contre son oreille droite."),
      Instruction(
          title: '3ème étape',
          img: 'e3.PNG',
          steps:
              "Ensuite, tout en maintenant la pression contre cette main gauche, relevez, avec votre main droite, la jambe gauche de la personne inconsciente. Puis en appuyant sur son genou gauche, le patient va automatiquement se tourner sur le côté droit grâce à un système de balancier. "),
      Instruction(
          title: '4ème étape',
          img: 'e4.PNG',
          steps:
              "Après avoir délicatement retiré votre main gauche, de sous la tête de la victime, ajustez sa jambe gauche."),
      Instruction(
          title: '5ème étape',
          img: 'e5.PNG',
          steps:
              "Pour éviter que le patient ne perde l'équilibre, le genou gauche doit former un qngle droit entre le tibia et la cuisse. Une fois que la personne est en PSL, entrouvrez délicatement sa bouche pour permettre l'écoulement d'éventuels liquides vers l'extérieur et vérifiez régulièrement sa respiration. Enfin, appelez les secours."),
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
            width: 50.0,
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
          backgroundColor: Colors.redAccent[700],
          child: Icon(Icons.messenger)),
      //appBar
      appBar: AppBar(
        title: Center(
            child: Text('Perte de connaissance-PLS',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 20))),
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
            mainAxisAlignment: MainAxisAlignment.center,
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
            ]),
      ),
    );
  }
}
