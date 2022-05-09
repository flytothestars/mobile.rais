import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currenIndex = 0;

  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  List<Marker> markersPostamat = [];
  double lat = 0;
  double lng = 0;
  // Completer<GoogleMapController> _controller = Completer();
  // late GoogleMapController newGoogleMapController;
  // late Position currentPosition;
  // var geoLocator = Geolocator();

  // void locatePosition() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   currentPosition = position;

  //   LatLng latLngPosition = LatLng(position.latitude, position.longitude);

  //   CameraPosition cameraPosition =
  //       new CameraPosition(target: latLngPosition, zoom: 14);

  //   newGoogleMapController
  //       .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  // }

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(43.238949, 76.889709),
  //   zoom: 14.4746,
  // );

  _initUserCurrentPosition() async {
    Position position = await _determinePosition();
    lat = position.latitude;
    lng = position.longitude;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(position.latitude, position.longitude), zoom: 15)));
    markers.clear();

    markers.add(Marker(
        markerId: const MarkerId('currentLocation'),
        position: LatLng(position.latitude, position.longitude)));
  }

  _initPostamatPosition() {
    markersPostamat.add(Marker(
        markerId: MarkerId("Postamat1"),
        position: LatLng(43.224671, 76.862497),
        infoWindow: InfoWindow(title: "Postamat #1634"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          _showButtomModel(context);
        }));
    markersPostamat.add(Marker(
        markerId: MarkerId("Postamat2"),
        position: LatLng(43.226911, 76.861837),
        infoWindow: InfoWindow(title: "Postamat #1635"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          _showButtomModel(context);
        }));
    setState(() {});
  }

  void _scanBarcode() async {
    // List<Barcode> barcodes = List();
  }

  @override
  void initState() {
    _initPostamatPosition();
    _initUserCurrentPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currenIndex == 0
          ? GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(lat, lng),
                zoom: 15,
              ),
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                googleMapController = controller;
              },
              markers: markersPostamat.map((e) => e).toSet(),
            )
          : Profile(),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
              onPressed: () {
                _scanBarcode();
              },
              child: Container(
                height: 30,
                width: 30,
                child: new Image.asset('assets/qr_code_48px.png'),
              )),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          elevation: 10,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
            currentIndex: currenIndex,
            onTap: (val) {
              setState(() {
                currenIndex = val;
              });
            },
          )),
    );
  }

  void _showButtomModel(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return Container();
        });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnable) {
      return Future.error("Location services are disable");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
