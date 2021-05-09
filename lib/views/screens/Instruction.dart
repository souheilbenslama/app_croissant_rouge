import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'my_detail_page.dart';
import 'package:app_croissant_rouge/models/Instruction.dart';
import 'package:get/get.dart';

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
          title: 'etouffement'.tr,
          img: 'suffocation.PNG',
          steps: "etouffInst".tr),
      Instruction(
          title: 'saignement'.tr, img: 'bleed.PNG', steps: "saignInst".tr),
      Instruction(
          title: 'perteCons'.tr, img: 'inconscient.PNG', steps: "perteInst".tr),
      Instruction(
          title: 'arretCard'.tr, img: 'heart.PNG', steps: "arretCardInst".tr),
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
        title: Center(child: Text('instructions'.tr)),
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
                      "endButton".tr,
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
