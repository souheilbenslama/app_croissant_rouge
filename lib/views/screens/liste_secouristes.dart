import 'package:app_croissant_rouge/models/secouriste.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class ListeSecouristes extends StatefulWidget {
  final secouristes;
  ListeSecouristes({Key key, @required this.secouristes}) : super(key: key);
  @override
  _ListeSecouristesState createState() => _ListeSecouristesState();
}

class _ListeSecouristesState extends State<ListeSecouristes> {
  @override
  Widget build(BuildContext context) {
    List<Item> generateItems(int numberOfItems) {
      return List.generate(numberOfItems, (index) {
        return Item(
          headerValue: widget.secouristes[index].name.toString(),
          expandedValue: widget.secouristes[index].email.toString(),
          isFree: widget.secouristes[index].isFree,
        );
      });
    }

    List<Item> _data = generateItems(widget.secouristes.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("listeSec".tr),
      ),
      body: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        // ignore: missing_return
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(
                  item.headerValue != null ? item.headerValue : "none",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              );
            },
            body: ListTile(
              title: Text(item.expandedValue),
              trailing: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: LiteRollingSwitch(
                      value: item.isFree,
                      textOn: 'Activer',
                      textOff: 'Desactiver',
                      colorOn: Colors.green,
                      colorOff: Colors.red[700],
                      iconOn: Icons.done,
                      iconOff: Icons.alarm_off,
                      textSize: 13.0,
                      onChanged: (bool state) {
                        print('turned ${(state) ? 'on' : 'off'}');
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: LiteRollingSwitch(
                      value: true,
                      textOn: 'Admin',
                      textOff: 'Normal',
                      colorOn: Colors.green,
                      colorOff: Colors.red[700],
                      iconOn: Icons.done,
                      iconOff: Icons.alarm_off,
                      textSize: 13.0,
                      onChanged: (bool state) {
                        print('turned ${(state) ? 'on' : 'off'}');
                      },
                    ),
                  ),
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }),
      ),
    );
  }
}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;
  bool isFree;

  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded,
    this.isFree,
  });
}
