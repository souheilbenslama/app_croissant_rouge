import 'dart:collection';
import 'package:app_croissant_rouge/accidentProvider.dart';
import 'package:app_croissant_rouge/models/accident.dart';
import 'package:app_croissant_rouge/views/widgets/app_bar.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:location/location.dart';
import 'dart:async';
import 'package:provider/provider.dart';

const double CAMERA_ZOOM = 17;
const double CAMERA_TILT = 20;
const double CAMERA_BEARING = 100;

const LatLng SOURCE_LOCATION = LatLng(35.427163, 10.9903381);
const LatLng DEST_LOCATION = LatLng(35.4236578, 10.9921817);

class MapPage extends StatefulWidget {
  Accident accident;

  MapPage(this.accident);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = HashSet<Marker>();

  Set<Marker> _markers = Set<Marker>();

  MapType mapType = MapType.normal;
  // the user's initial location and current location
  // as it moves
  LocationData currentLocation;
  // a reference to the destination location
  LocationData destinationLocation;
  // wrapper around the location API
  Location location;
  dynamic doc;

  var arguments;
  Future<List<Accident>> accidentList;

  switchMapType() {
    setState(() {
      if (mapType == MapType.normal) {
        mapType = MapType.hybrid;
      } else {
        mapType = MapType.normal;
      }
    });
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      //bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position

      var pinPosition =
          LatLng(currentLocation.latitude, currentLocation.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
      _markers
          .add(Marker(markerId: MarkerId('sourcePin'), position: pinPosition));
    });
  }

  @override
  void initState() {
    super.initState();

    location = new Location();
    getLocation();
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      updatePinOnMap();
    });

    //setSourceAndDestinationIcons();
    // set the initial location
    getLocation();
  }

  @override
  @protected
  @mustCallSuper
  // ignore: must_call_super
  void didChangeDependencies() {
    doc = Provider.of<AccidentProvider>(context, listen: false);

    accidentList = arguments;
  }

  void showPinsOnMap() {}

  getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      _permissionGranted = await location.hasPermission();
    }

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }

    if (_permissionGranted != PermissionStatus.granted) {
      currentLocation = await location.getLocation();

      destinationLocation = LocationData.fromMap({
        "latitude": DEST_LOCATION.latitude,
        "longitude": DEST_LOCATION.longitude
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Marker marker = Marker(
        markerId: MarkerId(this.widget.accident.cas),
        position: this.widget.accident.localisation,
        infoWindow: InfoWindow(
            title: this.widget.accident.cas,
            snippet: this.widget.accident.description),
        onTap: () {},
        onDragEnd: (LatLng position) {},
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
    markers.add(marker);
    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: this.widget.accident.localisation,
          // zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return ChangeNotifierProvider(
      create: (context) => AccidentProvider(),
      child: WillPopScope(
          onWillPop: () {
            return Navigator.of(context).pushNamed('/');
          },
          child: Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(
                Icons.message,
              ),
              label: Text("message"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ChatScreen(
                        JwtDecoder.decode(doc.gettoken())["id"],
                        this.widget.accident.id,
                      );
                    });
              },
              backgroundColor: Colors.redAccent[700],
            ),
            appBar: AppBarComponent(),
            body: Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  compassEnabled: true,
                  mapType: mapType,
                  onMapCreated: (GoogleMapController controller) {
                    print("//////////////////////////////////////////////");
                    _controller.complete(controller);
                    // my map has completed being created;
                    // i'm ready to show the pins on the map
                    showPinsOnMap();
                  },
                  initialCameraPosition: initialCameraPosition,
                  markers: markers,
                  //circles: _markers,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: IconButton(
                      color: Colors.black,
                      onPressed: switchMapType,
                      icon: Icon(
                        mapType == MapType.normal
                            ? Icons.blur_circular
                            : Icons.map,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

/*import 'dart:collection';

import 'package:app_croissant_rouge/models/accident.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/widgets/app_bar.dart';

class MapPage extends StatefulWidget {
  Accident accident;
  MapPage(this.accident);
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
    final arguments = ModalRoute.of(context).settings.arguments;
    print("AAAAAA");
    print("zz");
    print(this.widget.accident.cas);
    print("zz");
    print("AAAAAA");
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
*/
