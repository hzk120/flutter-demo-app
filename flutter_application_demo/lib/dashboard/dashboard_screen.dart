import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_demo/widgets/custom_appbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
//import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
//import 'package:location/location.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Completer<GoogleMapController> _controller = Completer();

  late double lat = 28.4595;
  late double lng = 77.0266;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  LatLng? markerPosition;
  int _markerIdCounter = 1;
  // 28.4595, 77.0266

  CameraPosition? _currentPosition;
  MarkerId? selectedMarker;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _onMarkerTapped(MarkerId markerId) {
    final Marker? tappedMarker = markers[markerId];
    if (tappedMarker != null) {
      setState(() {
        final MarkerId? previousMarkerId = selectedMarker;
        if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
          final Marker resetOld = markers[previousMarkerId]!
              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
          markers[previousMarkerId] = resetOld;
        }
        selectedMarker = markerId;
        final Marker newMarker = tappedMarker.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueGreen,
          ),
        );
        markers[markerId] = newMarker;

        markerPosition = null;
      });
    }
  }

  void _add() {
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);

    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        lat + sin(_markerIdCounter * pi / 6.0) / 20.0,
        lng + cos(_markerIdCounter * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () => _onMarkerTapped(markerId),
      //onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      //onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  // Future<List<Address>> _getAddress(double lat, double lang) async {
  //   final coordinates = new Coordinates(lat, lang);
  //   List<Address> add =
  //   await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   return add;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 249, 255, 1),
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Text(
                  'Current Location:',
                  style: GoogleFonts.inter(
                    fontSize: 42,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(120, 42)),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromRGBO(32, 32, 148, 1),
                    ),
                  ),
                  onPressed: () async {
                    var locationError = "";

                    _determinePosition().then((location) {
                      print('${location.latitude} ${location.longitude}');

                      SnackBar(
                        content: Text(
                            "Your Current Location Coordinates are ${location.latitude} ${location.longitude}"),
                      );

                      setState(() {
                        lat = location.latitude;
                        lng = location.longitude;
                      });
                    });
                  },
                  child: const Text(
                    'Get Current Location',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w200,
                      letterSpacing: 0.75,
                    ),
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  width: 300,
                  height: 200,
                  child: GoogleMap(
                    //mapType: MapType.hybrid,
                    initialCameraPosition: _currentPosition!,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    markers: Set<Marker>.of(markers.values),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: _add,
                      child: const Text('Add'),
                    ),
                    // TextButton(
                    //   onPressed:
                    //       selectedId == null ? null : () => _remove(selectedId),
                    //   child: const Text('Remove'),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
