import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobileapp_diplom2022_1_0_0/models/api_response.dart';
import 'package:mobileapp_diplom2022_1_0_0/models/post.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/QrPage.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/profile.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/constant.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/user_service.dart';

import '../services/post_service.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currenIndex = 0;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  List<Marker> markersPostamat = [];
  Map<MarkerId, Marker> _markersPostamat = <MarkerId, Marker>{};
  List<Post> _postList = [];
  double lat = 0;
  double lng = 0;
  bool timerBron = false;

  _initMarker(dataPos, id) {
    var markerVal = id.toString();
    final MarkerId markerId = MarkerId(markerVal);
    final Marker marker = Marker(
        markerId: markerId,
        position:
            LatLng(double.parse(dataPos['lat']), double.parse(dataPos['lng'])),
        infoWindow: InfoWindow(title: '${dataPos['address']}'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          _showButtomModel(context, dataPos);
        });
    setState(() {
      _markersPostamat[markerId] = marker;
    });
  }

  _checkPost() async {
    ApiResponse response = await getPost();
    List listPost = response.data as List;
    print(listPost);
    for (int i = 0; i < listPost.length; i++) {
      print("============== hello world =================");
      _initMarker(listPost[i], listPost[i]['id']);
      print('${listPost[i]['address']}');
    }
  }

  Future loadPost() async {
    final response = await http
        .get(Uri.parse(listPostURL), headers: {'Accept': 'application/json'});
    final jsonResponse = json.decode(response.body)['post'];
    Post listPost = new Post.fromJson(jsonResponse);
    return listPost;
  }

  //======================================================================
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

  _initPostamatPosition() async {
    markersPostamat.add(Marker(
        markerId: MarkerId(''),
        position: LatLng(43.224671, 76.862497),
        infoWindow: InfoWindow(title: "Postamat #"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        onTap: () {
          //_showButtomModel(context);
        }));
    setState(() {});
  }

  void _scanBarcode() async {
    // List<Barcode> barcodes = List();
  }

  @override
  void initState() {
    _checkPost();
    //_initPostamatPosition();
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
              markers: Set<Marker>.of(_markersPostamat.values),
              //markers: markersPostamat.map((e) => e).toSet(),
            )
          : Profile(
              // : ListView.builder(
              //     itemCount: _postList.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       Post post = _postList[index];
              //       return Text('${post.address}');
              //     },
              ),
      //Profile(),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const QRViewExample()));
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

  void _showButtomModel(context, dataPos) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
                padding: const EdgeInsets.all(25),
                //color: Colors.white,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                height: timerBron ? 250 : 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Адрес: " + '${dataPos['address']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 3),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Доступно PowerBank: " +
                              '${dataPos['slot'] - dataPos['freeslot']}',
                          style: TextStyle(fontSize: 18, color: Colors.green),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Свободные слоты: " + '${dataPos['freeslot']}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ElevatedButton(
                        //     onPressed: () {},
                        //     child: timerBron
                        //         ? Text("Арендовать")
                        //         : Text("Забрать")),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       print("timerbron: ");
                        //       print(timerBron);
                        //     },
                        //     child: Text("Вернуть")),
                      ],
                    ),
                  ],
                ));
          });
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
