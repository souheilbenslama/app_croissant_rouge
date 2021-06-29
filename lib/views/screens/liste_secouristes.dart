import 'package:app_croissant_rouge/views/screens/intervention_par_secouriste.dart';
import 'package:app_croissant_rouge/services/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ListeSecouristes extends StatefulWidget {
  ListeSecouristes({Key key}) : super(key: key);
  @override
  _ListeSecouristesState createState() => _ListeSecouristesState();
}

class _ListeSecouristesState extends State<ListeSecouristes> {
  Future<List> listSecouristes = AdminService.listSecourists();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.redAccent[700],
        title: Text("listeSec".tr),
      ),
      body: FutureBuilder(
        future: listSecouristes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var secouristes = snapshot.data;
            return Container(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                    itemCount: secouristes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 40,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => InterventionParSecouriste(
                                  secouriste: secouristes[index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            child: Text(
                              secouristes[index].name.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20,
                                  letterSpacing: 0.3,
                                  height: 1.3),
                            ),
                          ),
                        ),
                      );
                    }));
          } else {
            return Container(
                color: Colors.white,
                child: Align(
                    alignment: Alignment.center,
                    child: Center(
                        child: SpinKitFadingCircle(
                      color: Colors.grey[800],
                      size: 80,
                    ))));
          }
        },
      ),
    );
  }
}
