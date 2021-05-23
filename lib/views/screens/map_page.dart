import 'dart:collection';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/widgets/app_bar.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  //Set<Circle> _markers = HashSet<Circle>();
  List<Color> colors = [Colors.green, Colors.yellow, Colors.red];
  Set<Marker> markers = HashSet<Marker>();

  Marker marker = Marker(
      markerId: MarkerId("testing"),
      position: LatLng(36.85, 10.15),
      infoWindow:
          InfoWindow(title: "test Accident ", snippet: '\n description  '),
      onTap: () {},
      onDragEnd: (LatLng position) {});

  MapType mapType = MapType.normal;
  switchMapType() {
    setState(() {
      if (mapType == MapType.normal) {
        mapType = MapType.hybrid;
      } else {
        mapType = MapType.normal;
      }
    });
  }

  void onMapCreated(controller) {}

  @override
  Widget build(BuildContext context) {
    this.markers.add(this.marker);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.message,
        ),
        label: Text("message"),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ChatScreen("test");
              });
        },
        backgroundColor: Colors.redAccent[700],
      ),
      appBar: AppBarComponent(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: mapType,
            onMapCreated: onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(36.85, 10.15), zoom: 12.50),
            markers: markers,
            //circles: _markers,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: IconButton(
                color: Colors.black,
                onPressed: switchMapType,
                icon: Icon(
                  mapType == MapType.normal ? Icons.blur_circular : Icons.map,
                ),
              ),
            ),
          ),
          /*  Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration: BoxDecoration(color: Colors.white),
              child: FlatButton(
                onPressed: () => {},
                child: Text(
                  'Message',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ), */
        ],
      ),
    );
  }
}
