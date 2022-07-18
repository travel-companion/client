import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class CircuitMap extends StatelessWidget {
  var markerDataList = [];
  // var markerList = [];
  late Set<Marker> markerList = {};
  getMarkers() async {
    //
    await FirebaseFirestore.instance.collection('stops').get().then(
          (value) => value.docs.forEach((element) {
            var gPoint = element.data()['position'] as GeoPoint;
            markerDataList.add({
              'lat': gPoint.latitude,
              'lon': gPoint.longitude,
              'city': element.data()['city'],
              'name': element.data()['name'],
              'type': element.data()['type'],
              'all': element.data()['all']
            });
            markerList.add(Marker(
                markerId: MarkerId(element.data()['city']),
                infoWindow: InfoWindow(title: element.data()['name']),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(gPoint.latitude, gPoint.longitude)));
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getMarkers(),
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Google Maps Demo',
            home: MapSample(markerList: markerList),
          );
        });
  }
}

class MapSample extends StatefulWidget {
  final markerList;
  const MapSample({
    required this.markerList,
    Key? key,
  });
  @override
  State<MapSample> createState() => MapSampleState(markerList: markerList);
}

class MapSampleState extends State<MapSample> {
  final markerList;
  MapSampleState({
    required this.markerList,
    Key? key,
  });
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  late Position currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    Future<void> requestPermission() async {
      await Permission.location.request();
    }

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 15);

    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static const CameraPosition _Tunisie = CameraPosition(
    target: LatLng(36.799748880595764, 10.171296710937465),
    zoom: 14.4746,
  );

  static const Marker Charguia = Marker(
      markerId: MarkerId('_kGooglePlex'),
      infoWindow: InfoWindow(title: 'station bus la charguia 1'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(36.8392, -10.2045));

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static Marker LakeMarker = Marker(
      markerId: const MarkerId('_kLake'),
      infoWindow: const InfoWindow(title: 'Lake Libya'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      position: const LatLng(37.43296265331129, -122.08832357078792));

  var markerData = [];
  // var markerList = [];
  late List<Marker> markers = [];
  getMarkers() async {
    //
    await FirebaseFirestore.instance.collection('stops').get().then(
          (value) => value.docs.forEach((element) {
            var gPoint = element.data()['position'] as GeoPoint;
            markers.add(Marker(
                markerId: MarkerId(element.data()['city']),
                infoWindow: InfoWindow(title: element.data()['name']),
                icon: BitmapDescriptor.defaultMarker,
                position: LatLng(gPoint.latitude, gPoint.longitude)));
          }),
        );
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getMarkers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleMap(
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      markers: <Marker>{...markers},
                      initialCameraPosition: _Tunisie,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                        locatePosition();
                      },
                    );
                  }
                  return const Text("data");
                }),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
  }
}
