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
    /*List<ItemModel> itemData = <ItemModel>[
      ItemModel(
        isFree: widget.secouristes[0].isFree,
        headerValue: widget.secouristes[1].name.toString(),
        expandedValue: widget.secouristes[1].email.toString(),
      ),
      ItemModel(
        isFree: widget.secouristes[1].isFree,
        headerValue: widget.secouristes[1].name.toString(),
        expandedValue: widget.secouristes[1].email.toString(),
      ),
    ];*/
    List<ItemModel> generateItems(int numberOfItems) {
      return List.generate(numberOfItems, (index) {
        return ItemModel(
          headerValue: widget.secouristes[index].name.toString(),
          expandedValue: widget.secouristes[index].email.toString(),
          isFree: widget.secouristes[index].isFree,
        );
      });
    }

    List<ItemModel> _data = generateItems(widget.secouristes.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("listeSec".tr),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: widget.secouristes.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionPanelList(
              animationDuration: Duration(milliseconds: 1000),
              dividerColor: Colors.red,
              elevation: 1,
              children: [
                ExpansionPanel(
                  body: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _data[index].expandedValue,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                              letterSpacing: 0.3,
                              height: 1.3),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: LiteRollingSwitch(
                                value: false,
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
                      ],
                    ),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        _data[index].headerValue,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
                  },
                  isExpanded: _data[index].isExpanded,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  _data[index].isExpanded = !_data[index].isExpanded;
                });
              },
            );
          },
        ),
      ),
      /* body: ExpansionPanelList(
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
                  
                  ),
                 
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),*/
    );
  }
}

class ItemModel {
  String expandedValue;
  String headerValue;
  bool isExpanded;
  bool isFree;

  ItemModel({
    this.expandedValue,
    this.headerValue,
    this.isExpanded: true,
    this.isFree,
  });
}
