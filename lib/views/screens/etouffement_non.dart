import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'my_detail_page.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:get/get.dart';
import 'package:app_croissant_rouge/views/screens/page_alerte.dart';

class EtoufNon extends StatefulWidget {
  @override
  _EtoufNonState createState() => _EtoufNonState();
}

class _EtoufNonState extends State<EtoufNon> {
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
          title: 'Adule-Enfant'.tr,
          img: 'adultkid11.png',
          steps:
              "-Donner 5 claques vigoureuse sur le dos.\n-Donner 5 compressions abdominale avec la pomme de la main.\n-Recommencer les 5 claques et les 5 compressions jusqu’à l’apparition de la toux."),
      Instruction(
          title: 'Enceinte'.tr,
          img: 'pregnant.png',
          steps:
              "-Donner 5 claques vigoureuse sur le dos.\n-Donner 5 compressions du thorax avec la pomme de la main.  \n-Recommencer les 5 claques et les 5 compressions jusqu’à l’apparition de la toux."),
      Instruction(
          title: 'Nourrison'.tr,
          img: 'infant.png',
          steps:
              "-Donner 5 claques vigoureuse sur le dos.\n-Donner 5 compressions du thorax avec 2 doigts. \n-Recommencer les 5 claques et les 5 compressions jusqu’à l’apparition de la toux."),
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
        backgroundColor: Colors.redAccent[700],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 200,
            ),
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
            ),
          ],
        ),
      ),
    );
  }
}
