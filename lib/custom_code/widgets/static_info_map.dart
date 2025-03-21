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

class StaticInfoMap extends StatefulWidget {
  const StaticInfoMap({
    super.key,
    this.width,
    this.height,
    required this.placePoint,
    required this.placeImg,
  });

  final double? width;
  final double? height;
  final LatLng placePoint;
  final String placeImg;

  @override
  State<StaticInfoMap> createState() => _StaticInfoMapState();
}

class _StaticInfoMapState extends State<StaticInfoMap> {
  late MapController _mapController;
  Uint8List? addActivityMarker;
  ll.LatLng? _currentPosition;

  Future<Uint8List> widgetToImageBytes(CustomPainter painter, Size size) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder,
        Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height)));

    painter.paint(canvas, size);

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> addActivityMarkerFn() async {
    final markerWidget = CustomCircleMarkerPainter();
    final markerImage = await widgetToImageBytes(markerWidget, Size(150, 150));
    setState(() {
      addActivityMarker = markerImage;
    });
  }

  @override
  void initState() {
    super.initState();
    addActivityMarkerFn();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return addActivityMarker != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: ll.LatLng(
                  widget.placePoint.latitude,
                  widget.placePoint.longitude,
                ),
                initialZoom: 14,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: ll.LatLng(widget.placePoint.latitude,
                          widget.placePoint.longitude),
                      width: 36,
                      height: 36,
                      child: Stack(
                        children: [
                          Center(child: Image.memory(addActivityMarker!)),
                          Center(
                            child: SizedBox(
                              width: 18,
                              height: 18,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.network(widget.placeImg),
                              ),
                            ),
                          ),
                        ],
                      ),
                      alignment: Alignment(0, 0),
                    ),
                  ],
                ),
              ],
            ),
          )
        : CircularProgressIndicator();
  }
}

class CustomCircleMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double shadowPadding = 5.0; // Padding for shadow
    final double strokeWidth = 4.0; // Width of the stroke

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = Colors.black // Change this to your desired stroke color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final double radius = (size.width - 2 * shadowPadding - strokeWidth) / 2;

    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw shadow
    canvas.save();
    canvas.translate(2, 2); // Offset for shadow
    canvas.drawCircle(center, radius, shadowPaint);
    canvas.restore();

    // Draw circle fill
    canvas.drawCircle(center, radius, fillPaint);

    // Draw circle stroke
    canvas.drawCircle(center, radius, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
