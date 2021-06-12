import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../../models/interventions.dart';
import 'package:app_croissant_rouge/services/admin_service.dart';
import 'package:get/get.dart';

class ListeInterventions extends StatefulWidget {
  @override
  _ListeInterventionsState createState() => _ListeInterventionsState();
  final interventions;
  ListeInterventions({Key key, @required this.interventions}) : super(key: key);
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _ListeInterventionsState extends State<ListeInterventions> {
  final _debouncer = Debouncer(milliseconds: 500);
  List interventions = List();
  List filteredInterventions = List();

  @override
  void initState() {
    super.initState();
    AdminService.listinterventions().then((interventionsFromServer) {
      setState(() {
        interventions = interventionsFromServer;
        filteredInterventions = interventions;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent[700],
        title: Text("listeInter".tr),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'hintRegion'.tr),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  filteredInterventions = interventions.where((u) {
                    print(u.localite);
                    print(string);

                    return (u.localite
                            .toLowerCase()
                            .contains(string.toLowerCase()) ||
                        u.localite
                            .toLowerCase()
                            .contains(string.toLowerCase()));
                  }).toList();
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: filteredInterventions.length,
              itemBuilder: (BuildContext context, int index) {
                //   print(filteredInterventions[index].localite);
                return Card(
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "interDe".tr + filteredInterventions[index].cas,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          (filteredInterventions[index].localite != null)
                              ? filteredInterventions[index].localite
                              : "",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          (filteredInterventions[index].date != null)
                              ? DateFormat.yMMMMEEEEd()
                                  .format(filteredInterventions[index].date)
                              : "",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
