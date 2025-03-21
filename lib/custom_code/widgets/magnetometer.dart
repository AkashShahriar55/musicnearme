// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:sensors_plus/sensors_plus.dart';

class Magnetometer extends StatefulWidget {
  const Magnetometer({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<Magnetometer> createState() => _MagnetometerState();
}

class _MagnetometerState extends State<Magnetometer> {
  MagnetometerEvent? _magnetometerEvent;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];
  Duration sensorInterval = SensorInterval.normalInterval;
  List<double> direction = []; //[x, y, z];

  @override
  void initState() {
    super.initState();
    directionsDegrees().then((value) {
      setState(() {
        direction = value;
      });
    });
  }

  Future<List<double>> directionsDegrees() async {
    // Subscribe to magnetometer events with the desired sampling rate
    List<double> directionList = [];
    print('TESTING!!!!!!!!');
    _streamSubscriptions.add(
      magnetometerEventStream().listen(
        (MagnetometerEvent event) {
          directionList = [
            _magnetometerEvent!.x,
            _magnetometerEvent!.y,
            _magnetometerEvent!.z
          ];
          print('directionList: $directionList');
          /*
          setState(() {
             direction = [
            _magnetometerEvent!.x,
            _magnetometerEvent!.y,
            _magnetometerEvent!.z
          ];
          
            _magnetometerEvent = event;
          });
          */
        },
        onError: (e) {
          showDialog(
              context: context,
              builder: (context) {
                return const AlertDialog(
                  title: Text("Sensor Not Found"),
                  content: Text(
                      "It seems that your device doesn't support User Accelerometer Sensor"),
                );
              });
        },
        // cancelOnError: true,
      ),
    );

    return directionList;
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return direction.isNotEmpty
        ? Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                children: [
                  Text(direction[0].toStringAsFixed(1)),
                  Text(direction[1].toStringAsFixed(1)),
                  Text(direction[2].toStringAsFixed(1)),
                ],
              ),
            ),
          )
        : CircularProgressIndicator();
  }
}
