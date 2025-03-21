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

import 'dart:async';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'package:geolocator/geolocator.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

class RoutingMap extends StatefulWidget {
  const RoutingMap({
    super.key,
    this.width,
    this.height,
    required this.userLocation,
    required this.testing,
    required this.placePoint,
    required this.allRoutePoints,
  });

  final double? width;
  final double? height;
  final LatLng userLocation;
  final bool testing;
  final LatLng placePoint;
  final List<LatLng> allRoutePoints;

  @override
  State<RoutingMap> createState() => _RoutingMapState();
}

class _RoutingMapState extends State<RoutingMap> with TickerProviderStateMixin {
  late MapController _mapController;
  Uint8List? addActivityMarker;
  bool isLoading = true;
  ll.LatLng centerLatLng = ll.LatLng(0, 0);
  late AnimationController _waveController;
  late bool hasPermission;
  ll.LatLng? _currentPosition;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<ll.LatLng> newList = [];
      newList.add(ll.LatLng(
          widget.userLocation.latitude, widget.userLocation.longitude));
      newList.add(
          ll.LatLng(widget.placePoint.latitude, widget.placePoint.longitude));
      final bounds = LatLngBounds.fromPoints(newList);
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: bounds,
          padding: const EdgeInsets.all(30),
        ),
      );
    });
  }

  List<Polyline> setRoute(List<LatLng> routeCoordinates) {
    List<Polyline> polyLines = [];
    polyLines.add(
      Polyline(
        points: routeCoordinates
            .map((point) => ll.LatLng(point.latitude, point.longitude))
            .toList(),
        strokeWidth: 8,
        color: Colors.blue,
      ),
    );
    return polyLines;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: ll.LatLng(
          widget.userLocation.latitude,
          widget.userLocation.longitude,
        ),
        initialZoom: 15,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        if (widget.allRoutePoints.length >= 2)
          PolylineLayer(polylines: setRoute(widget.allRoutePoints)),
        MarkerLayer(
          //User Location
          markers: [
            Marker(
              width: 12.0,
              height: 12.0,
              point: ll.LatLng(
                  widget.userLocation.latitude, widget.userLocation.longitude),
              child: CustomPaint(
                painter: LocationPainter(_waveController),
                child: SizedBox(
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
        MarkerLayer(
          //Other place
          markers: [
            Marker(
              width: 12.0,
              height: 12.0,
              point: ll.LatLng(
                  widget.placePoint.latitude, widget.placePoint.longitude),
              child: Center(
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.blue,
                ),
              ),
              alignment: Alignment(-1, -2.5),
            ),
          ],
        ),
      ],
    );
  }
}

class LocationPainter extends CustomPainter {
  final Animation<double> animation;

  LocationPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = 10;
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw the location icon (a simple circle for this example)
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Draw the animated wave effect
    final double waveRadius = (size.width / 2) * animation.value;
    paint
      ..color = Colors.blue.withOpacity(0.5 * (1 - animation.value))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(Offset(centerX, centerY), waveRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
