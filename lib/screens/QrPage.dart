import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/aboutpostpage.dart';

import '../models/api_response.dart';
import '../services/post_service.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  MobileScannerController cameraController = MobileScannerController();
  bool stopScan = true;
  List listPost = [];
  _checkPost() async {
    ApiResponse response = await getPost();
    listPost = response.data as List;
  }

  @override
  void initState() {
    _checkPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('QR'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
          ],
        ),
        body: MobileScanner(
            allowDuplicates: true,
            fit: BoxFit.cover,
            controller: cameraController,
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                print('Failed to scan Barcode');
              } else {
                for (int i = 0; i < listPost.length; i++) {
                  if (barcode.rawValue == listPost[i]['qr_code'] && stopScan) {
                    setState(() {
                      stopScan = false;
                    });
                    print("=================================");
                    print(listPost[i]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AboutPostPage(
                                id: listPost[i]['id'],
                                qr_code: listPost[i]['qr_code'],
                                address: listPost[i]['address'],
                                slot: listPost[i]['slot'],
                                freeslot: listPost[i]['freeslot'])));
                    final String code = barcode.rawValue!;
                    print('Barcode found! $code');
                  }
                }
              }
            }));
  }
}
