import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    bleExec2();
                  },
                  child: Text('ble btn', style: TextStyle(fontSize: 30)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void bleExec() {
  //   // Start scanning
  //   flutterBlue.startScan(timeout: Duration(seconds: 4));
  //
  //   // Listen to scan results
  //   var subscription = flutterBlue.scanResults.listen((results) {
  //     // do something with scan results
  //     for (ScanResult r in results) {
  //       print('${r.device.name} found! rssi: ${r.rssi}');
  //     }
  //   });
  //
  //   // Stop scanning
  //   flutterBlue.stopScan();
  // }

  void bleExec2() async {
    // 블루투스 스캔 권한 요청
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothAdvertise, // error: bluetoothAdmin,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
    ].request();

    // 권한 확인
    if (statuses[Permission.bluetoothScan] == PermissionStatus.granted) {
      // 블루투스 스캔 수행
      // Start scanning
      flutterBlue.startScan(timeout: Duration(seconds: 4));

      // Listen to scan results
      var subscription = flutterBlue.scanResults.listen((results) {
        // do something with scan results
        for (ScanResult r in results) {
          print('${r.device.name} found! rssi: ${r.rssi}');
        }
      });
    } else {
      // 권한이 거부되었을 때의 처리
      print('error');
      // Stop scanning
      flutterBlue.stopScan();
    }
  }
}
