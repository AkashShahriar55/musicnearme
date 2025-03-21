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

class StaticMap extends StatefulWidget {
  const StaticMap({
    super.key,
    this.width,
    this.height,
    required this.userLocation,
    required this.testing,
    required this.zoomLevel,
    required this.places,
  });

  final double? width;
  final double? height;
  final LatLng userLocation;
  final bool testing;
  final double zoomLevel;
  final List<PlacesRecord> places;

  @override
  State<StaticMap> createState() => _StaticMapState();
}

class _StaticMapState extends State<StaticMap> with TickerProviderStateMixin {
  late MapController _mapController;
  Uint8List? addActivityMarker;
  bool isLoading = true;
  late AnimationController _waveController;
  late bool hasPermission;
  ll.LatLng? _currentPosition;
  Timer? timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mapController = MapController();
    _waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
    addActivityMarkerFn().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  double haversineDistance(LatLng point1, LatLng point2) {
    const double R = 6371; // Earth's radius in kilometers
    double lat1 = point1.latitude;
    double lon1 = point1.longitude;
    double lat2 = point2.latitude;
    double lon2 = point2.longitude;

    double dLat = (lat2 - lat1) * (math.pi / 180.0);
    double dLon = (lon2 - lon1) * (math.pi / 180.0);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1 * (math.pi / 180.0)) *
            math.cos(lat2 * (math.pi / 180.0)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return R * c; // Distance in kilometers
  }

  List<Marker> getLatLngFromNearbyPlaces() {
    List<Marker> allMarkers = [];

    for (int i = 0; i < widget.places.length; i++) {
      PlacesRecord activity = widget.places[i];
      LatLng coordinates = activity.coordinates!;

      double distance;

      distance = haversineDistance(
          LatLng(widget.userLocation.latitude, widget.userLocation.longitude),
          coordinates);

      if (distance < 100) {
        String imgPath = activity.markerIcon;
        allMarkers.add(
          Marker(
            point: ll.LatLng(coordinates.latitude, coordinates.longitude),
            width: 36,
            height: 36,
            child: addActivityMarker != null
                ? Stack(
                    children: [
                      Center(child: Image.memory(addActivityMarker!)),
                      Center(
                        child: SizedBox(
                          width: 18,
                          height: 18,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Image.network(imgPath),
                          ),
                        ),
                      ),
                    ],
                  )
                : CircularProgressIndicator(),
            //alignment: Alignment(0, -1),
            alignment: Alignment(0, 0),
          ),
        );
      } else {
        print('Point is farther than 100 km');
      }
    }

    return allMarkers;
  }

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
    final markerImage = await widgetToImageBytes(markerWidget, Size(200, 200));
    setState(() {
      addActivityMarker = markerImage;
    });
  }

  Widget _darkModeContainerIfEnabled(Widget child) {
    if (!FFAppState().darkMode) return child;

    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.grey.shade800,
        BlendMode.saturation,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading &&
            (widget.userLocation.latitude != 0.0 ||
                widget.userLocation.latitude != 0.0)
        ? Center(child: CircularProgressIndicator())
        : ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FlutterMap(
              key: UniqueKey(),
              mapController: _mapController,
              options: MapOptions(
                initialCenter: ll.LatLng(
                  widget.userLocation.latitude,
                  widget.userLocation.longitude,
                ),
                initialZoom: widget.zoomLevel,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.none,
                ),
              ),
              children: [
                _darkModeContainerIfEnabled(
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                ),
                if (widget.places.isNotEmpty)
                  MarkerLayer(
                    markers: getLatLngFromNearbyPlaces(),
                  ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: ll.LatLng(widget.userLocation.latitude,
                          widget.userLocation.longitude),
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
              ],
            ),
          );
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
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!

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
