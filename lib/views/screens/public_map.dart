import 'dart:collection';
import 'package:app_croissant_rouge/models/accident.dart';
import 'package:app_croissant_rouge/views/screens/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:app_croissant_rouge/views/widgets/app_bar.dart';
import 'package:location/location.dart';
import 'dart:async';

const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 20;
const double CAMERA_BEARING = 100;

const LatLng SOURCE_LOCATION = LatLng(35.427163, 10.9903381);
const LatLng DEST_LOCATION = LatLng(35.4236578, 10.9921817);

class PublicMap extends StatefulWidget {
  @override
  _PublicMapState createState() => _PublicMapState();
}

class _PublicMapState extends State<PublicMap> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = HashSet<Marker>();

  Set<Marker> _markers = Set<Marker>();

  Marker marker = Marker(
      markerId: MarkerId("testing"),
      position: LatLng(37.4221, 10.9903381),
      infoWindow: InfoWindow(title: "test", snippet: '*'),
      onTap: () {},
      onDragEnd: (LatLng position) {},
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));

  Marker marker2 = Marker(
      markerId: MarkerId("testing2"),
      position: LatLng(38.4221, 11.9903381),
      infoWindow: InfoWindow(title: "test2", snippet: '*'),
      onTap: () {},
      onDragEnd: (LatLng position) {},
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));

  MapType mapType = MapType.normal;
  // the user's initial location and current location
  // as it moves
  LocationData currentLocation;
  // a reference to the destination location
  LocationData destinationLocation;
  // wrapper around the location API
  Location location;

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
    List<Accident> accidentList = ModalRoute.of(context).settings.arguments;
    accidentList.forEach((element) {
      markers.add(Marker(
      markerId: MarkerId(element.id),
      position: LatLng(
      element.localisation.latitude, element.localisation.longitude),
      infoWindow: InfoWindow(title: element.id, snippet: element.status)));
    }); 

    //markers.add(marker);
    //markers.add(marker2);

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION);

    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          // zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBarComponent(),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            compassEnabled: true,
            mapType: mapType,
            onMapCreated: (GoogleMapController controller) {
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
