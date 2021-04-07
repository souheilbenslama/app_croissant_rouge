import 'dart:collection';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/widgets/app_bar.dart';
import 'package:location/location.dart';

class PublicMap extends StatefulWidget {
  @override
  _PublicMapState createState() => _PublicMapState();
}

class _PublicMapState extends State<PublicMap> {
  GoogleMapController mapController;
  //Set<Circle> _markers = HashSet<Circle>();
  List<Color> colors = [Colors.green, Colors.yellow, Colors.red];
  Set<Marker> markers = HashSet<Marker>();
  double _latitude;
  double _longitude;

  Marker marker = Marker(
      markerId: MarkerId("testing"),
      position: LatLng(36.85, 10.15),
      infoWindow: InfoWindow(title: "test", snippet: '*'),
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

  void getLocation(controller) async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      _permissionGranted = await location.hasPermission();
    }

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    if (_permissionGranted != PermissionStatus.granted) {
      _locationData = await location.getLocation();

      this._latitude = _locationData.latitude;
      this._longitude = _locationData.longitude;

      print(this._latitude);
      print(this._longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    this.markers.add(this.marker);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBarComponent(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: mapType,
            onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
                target: LatLng(this._longitude, this._longitude), zoom: 12.50),
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
        ],
      ),
    );
  }
}
