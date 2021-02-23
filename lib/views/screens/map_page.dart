import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/widgets/app_bar.dart';
import 'package:app_croissant_rouge/models/data.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController mapController;
  Set<Circle> _markers = HashSet<Circle>();
  List<Color> colors = [Colors.green, Colors.yellow, Colors.red];
  // Set<Marker> _markers = HashSet<Marker>();
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

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
      // for(var region in data) {
      // _markers.add(
      //     Marker(
      //       markerId: MarkerId(region['id']),
      //       position: LatLng(double.parse(region['lat'])	,double.parse(region['lng'])),
      //       infoWindow: InfoWindow(
      //           title: region['region'],
      //           snippet: ''
      //       ),
      //
      //     )
      // );}
      for (var region in data) {
        _markers.add(Circle(
          circleId: CircleId(region['id']),
          center:
              LatLng(double.parse(region['lat']), double.parse(region['lng'])),
          radius: double.parse(region['confirmed']),
          strokeWidth: 2,
          fillColor: double.parse(region['confirmed']) > 20000
              ? colors[2].withOpacity(0.5)
              : double.parse(region['confirmed']) > 5000
                  ? colors[1].withOpacity(0.5)
                  : colors[0].withOpacity(0.5),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: mapType,
            onMapCreated: onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(36, 10), zoom: 8.0),
            // markers: _markers,
            circles: _markers,
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
          Align(
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
          ),
        ],
      ),
    );
  }
}
