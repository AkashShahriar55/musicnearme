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

import 'index.dart'; // Imports other custom widgets
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll;
import 'dart:ui' as ui;
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

class CustomMap extends StatefulWidget {
  const CustomMap({
    super.key,
    this.width,
    this.height,
    required this.addActivityAction,
    required this.testing,
    required this.events,
    required this.showCarouselAction,
    required this.hideCarouselAction,
    required this.geofenceCallback,
    required this.currentSearchedArea,
    required this.placesFoundCallback,
    required this.mapLoadingCallback,
    required this.findPlaces,
  });

  final double? width;
  final double? height;
  final Future Function(LatLng clickedPosition) addActivityAction;
  final bool testing;
  final List<EventsRecord> events;
  final Future Function(List<EventsRecord> placeData, int index)
      showCarouselAction;
  final Future Function() hideCarouselAction;
  final Future Function(GeofenceObjectStruct geofenceObj) geofenceCallback;
  final LatLng currentSearchedArea;
  final Future Function(bool placesFound) placesFoundCallback;
  final Future Function() mapLoadingCallback;
  final Future Function(String query) findPlaces;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  /* 
  
  
  DECLARATIONS 
  
  
  */

  late MapController _mapController;
  ll.LatLng? _currentPosition;
  late bool hasPermission;
  final List<LatLng> currentRoute = [];
  Timer? timer;
  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';
  bool startNewRoute = false;
  ll.LatLng? tappedCoords;
  Uint8List? tappedActivityMarker;
  Uint8List? addActivityMarker;
  late AnimationController _waveController;
  late AnimationController _waveController2;
  ll.LatLng? _previousPosition;
  bool mapIsInitialized = false;
  StreamSubscription<Position>? positionStream;
  bool canHideCarousel = false;
  LatLng? previousMarker;
  List<ll.LatLng> geolocationPoints = [];
  bool placesAddedToMap = false;
  List<Marker> allMarkers = [];
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<Widget> _waves = [];

/* 
  
  
  INITIALIZATION 
  
  
*/

  @override
  void initState() {
    super.initState();
    addActivityMarkerFn();
    _mapController = MapController();
    _searchController.addListener(_onSearchChanged);

    print('Initializing... these are key variables');
    print('placesAddedToMap: $placesAddedToMap');
    print('allMarkers: $allMarkers');
    print('currentPosition: $_currentPosition');

    if (widget.testing) {
      ll.LatLng fakePlace = const ll.LatLng(23.777176, 90.399452);
      setState(() {
        _currentPosition = fakePlace;
      });
      FFAppState().update(() {
        FFAppState().currentUserLocation =
            LatLng(fakePlace.latitude, fakePlace.longitude);
      });
      //addPlacesToMap();
      _initializeMapData(FFAppState().placeTypePref);
    } else {
      _initializeGeolocation();
    }
    /*
    _initializeBackgroundGeofencing();
    */
    _initializeWaveController();
  }

/* 
  
  
  GEOLOCATION / GEOFENCING FUNCTIONS 
  
  
*/

  Future<void> _initializeMapData(List<String> placeTypePref) async {
    await addActivityMarkerFn();
    addEventsToMap(placeTypePref);
  }

  void _initializeWaveController() {
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _waveController2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
  }

  void _initializeBackgroundGeofencing() {
    bg.BackgroundGeolocation.ready(bg.Config(
      desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
      distanceFilter: 3,
      stopOnTerminate: false,
      startOnBoot: true,
    )).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });

    // Listen to geofence events
    bg.BackgroundGeolocation.onGeofence((bg.GeofenceEvent event) {
      if (event.action == "DWELL") {
        Map<String, dynamic> map =
            Map<String, dynamic>.from(event.extras!["placeData"] as Map);
        GeofenceObjectStruct struct = GeofenceObjectStruct(
          name: map['name'],
          placeRef: FirebaseFirestore.instance.doc(map['reference']),
          message: map['advertisementMessage'],
          messageImg: map['advertisementImg'],
        );
        /*
         PlaceDataStruct(
                  coordinates: place.coordinates,
                  createdBy: place.createdBy,
                  bannerImg: place.bannerImg,
                  markerIcon: place.markerIcon,
                  websiteLink: place.websiteLink,
                  name: place.name,
                  ref: place.reference,
                  location: place.location,
                  placeType: place.placeType,
                  index: i,
                ),
        */
        widget.geofenceCallback(struct);

        FFAppState().update(() {
          FFAppState().geofenceTest =
              "Geofence event: ${event.identifier}, action: ${event.action}";
        });
      }

      //print('Geofence event: ${event.identifier}, action: ${event.action}');
    });
  }

  void addGeofence(bg.Geofence geofence) {
    bg.BackgroundGeolocation.addGeofence(geofence).then((bool success) {
      /*
      FFAppState().update(() {
        FFAppState().geofenceTest = "[addGeofence] success!";
      });
      */
    }).catchError((error) {
      /*
      String s = '[addGeofence] ERROR: $error';
      FFAppState().update(() {
        FFAppState().geofenceTest = s;
      });
      */
    });
  }

  void _initializeGeolocation() {
    checkPermissions().then((permissionAccepted) {
      setState(() {
        hasPermission = permissionAccepted;
      });
      _getCurrentLocation();
    }).catchError((error) {
      print('Error: $error');
    });
  }

  Future<bool> checkPermissions() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return true;
  }

  void _getCurrentLocation() async {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 3,
        //timeLimit: Duration(seconds: 5),
      ),
    ).listen((Position position) {
      ll.LatLng newLocation = ll.LatLng(position.latitude, position.longitude);
      /*

      Get Bearings

      if (_previousPosition != null) {
        double bearing = calculateBearing(_previousPosition!, newLocation);
        if (bearing != 0.0) {
          _animatedMapRotate(bearing);
        }
      }
      */
      print(
          'This is the found Location: (${position.latitude},${position.longitude}).');

      FFAppState().update(() {
        FFAppState().currentUserLocation =
            LatLng(position.latitude, position.longitude);
        FFAppState().centerOnUser = false;
      });

      if (FFAppState().centerOnUser) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _animatedMapMove(newLocation, _mapController.camera.zoom);
        });
        FFAppState().update(() {
          FFAppState().centerOnUser = false;
        });
      }
      if (!placesAddedToMap) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          FFAppState().update(() {
            FFAppState().mapLoading = true;
          });

          _initializeMapData(FFAppState().placeTypePref).then((_) {
            return Future.delayed(const Duration(milliseconds: 500));
          }).then((_) {
            if (mounted) {
              //widget.placesFoundCallback(allMarkers.isNotEmpty);
              setState(() {
                _currentPosition = newLocation;
                _previousPosition = newLocation;
              });
            }

            FFAppState().update(() {
              FFAppState().setBounds = true;
              FFAppState().mapLoading = false;
            });
          });
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _waveController.dispose();
    _waveController2.dispose();
    positionStream?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

/* 
  
  
  MAP FUNCTIONS 
  
  
*/

  double calculateDistanceBetweenTwoPoints(LatLng point1, LatLng point2) {
    const double R = 6371; // Earth's radius in kilometers
    double lat1 = point1.latitude;
    double lon1 = point1.longitude;
    double lat2 = point2.latitude;
    double lon2 = point2.longitude;

    double dLat = (lat2 - lat1) * (pi / 180.0);
    double dLon = (lon2 - lon1) * (pi / 180.0);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1 * (pi / 180.0)) *
            cos(lat2 * (pi / 180.0)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in kilometers
  }

  double calculateBearing(ll.LatLng start, ll.LatLng end) {
    double startLat = start.latitude * (pi / 180);
    double startLng = start.longitude * (pi / 180);
    double endLat = end.latitude * (pi / 180);
    double endLng = end.longitude * (pi / 180);

    double dLng = endLng - startLng;

    double x = sin(dLng) * cos(endLat);
    double y =
        cos(startLat) * sin(endLat) - (sin(startLat) * cos(endLat) * cos(dLng));

    double bearing = atan2(x, y) * (180 / pi);
    double adjustedBearing = (bearing + 360) % 360; // Adjust to 0-360 range
    return adjustedBearing;
  }

  void _animatedMapMove(ll.LatLng destLocation, double destZoom) {
    final camera = _mapController.camera;
    final latTween = Tween<double>(
        begin: camera.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: camera.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: camera.zoom, end: destZoom);

    final controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }
      hasTriggeredMove |= _mapController.move(
        ll.LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
        id: id,
      );
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  void _animatedMapRotate(double targetBearing) {
    final camera = _mapController.camera;
    final currentBearing = camera.rotation;
    final bearingTween = Tween<double>(
      begin: currentBearing,
      end: targetBearing,
    );

    final controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );

    controller.addListener(() {
      _mapController.rotate(bearingTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  List<Marker> filterAllMarkers(List<String> filter) {
    print('re-initializing map data with filter: $filter');
    _initializeMapData(filter);
    FFAppState().update(() {
      FFAppState().placePrefChanged = false;
    });
    return [];
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
    //_mapController.rotate(degree);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animatedMapMove(_currentPosition!, 16);
    });
    return polyLines;
  }

  Marker mapZoomOut(bool zoom) {
    if (zoom && _mapController.camera.zoom >= 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapMove(
            _mapController.camera.center, _mapController.camera.zoom - 1);
        FFAppState().update(() {
          FFAppState().mapZoomOut = false;
        });
      });
    }

    return Marker(point: _currentPosition!, child: Container());
  }

  Marker mapZoomIn(bool zoom) {
    if (zoom && _mapController.camera.zoom <= 17) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapMove(
            _mapController.camera.center, _mapController.camera.zoom + 1);
        FFAppState().update(() {
          FFAppState().mapZoomIn = false;
        });
      });
    }

    return Marker(point: _currentPosition!, child: Container());
  }

  Marker mapSetNorth(bool setNorth) {
    if (setNorth) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapRotate(0);
        FFAppState().update(() {
          FFAppState().mapSetNorth = false;
        });
      });
    }
    return Marker(point: _currentPosition!, child: Container());
  }

  Marker zoomOutFn(bool zoom) {
    if (zoom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapMove(_currentPosition!, _mapController.camera.zoom);
        FFAppState().update(() {
          FFAppState().zoomOut = false;
        });
      });
    }

    return Marker(point: _currentPosition!, child: Container());
  }

  List<Marker> setZoomToPoint(LatLng point) {
    Marker m = Marker(
      point: ll.LatLng(point.latitude, point.longitude),
      height: 12,
      width: 12,
      child: Container(),
      alignment: const Alignment(-1, -2.5),
    );
    if (point != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FFAppState().update(() {
          FFAppState().mapLoading = true;
        });

        _initializeMapData(FFAppState().placeTypePref).then((_) {
          return Future.delayed(const Duration(milliseconds: 500));
        }).then((_) {
          if (mounted) {
            //widget.placesFoundCallback(allMarkers.isNotEmpty);
          }

          FFAppState().update(() {
            FFAppState().mapLoading = false;
          });
        });
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapMove(ll.LatLng(point.latitude, point.longitude), 11);
        FFAppState().update(() {
          FFAppState().zoomTo = null;
        });
        setState(() {
          _searchController.text = "";
        });
      });
    }

    return [m];
  }

  List<Marker> setZoomToBoundaries(List<LatLng> points) {
    Marker m = Marker(
      point: ll.LatLng(points[0].latitude, points[0].longitude),
      height: 12,
      width: 12,
      child: Container(),
      alignment: const Alignment(-1, -2.5),
    );
    if (points != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeMapData(FFAppState().placeTypePref).then((_) {
          return Future.delayed(const Duration(milliseconds: 500));
        }).then((_) {
          if (mounted) {
            //widget.placesFoundCallback(allMarkers.isNotEmpty);
          }
        });
        FFAppState().update(() {
          FFAppState().zoomToNoLoad = null;
        });
      });
    }

    return [m];
  }

  List<Marker> setZoomToPointNoLoad(LatLng point) {
    Marker m = Marker(
      point: ll.LatLng(point.latitude, point.longitude),
      height: 12,
      width: 12,
      child: Container(),
      alignment: const Alignment(-1, -2.5),
    );
    if (point != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _initializeMapData(FFAppState().placeTypePref).then((_) {
          FFAppState().update(() {
            FFAppState().setBounds = true;
          });
          return Future.delayed(const Duration(milliseconds: 500));
        });
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapMove(ll.LatLng(point.latitude, point.longitude), 11);
        FFAppState().update(() {
          FFAppState().zoomToNoLoad = null;
        });
      });
    }

    return [m];
  }

  List<Marker> setZoomToSwipe(LatLng point) {
    Marker m = Marker(
      point: ll.LatLng(point.latitude, point.longitude),
      height: 12,
      width: 12,
      child: Container(),
      alignment: const Alignment(-1, -2.5),
    );
    if (point != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _animatedMapMove(ll.LatLng(point.latitude, point.longitude), 15);
        FFAppState().update(() {
          FFAppState().zoomToSwipe = null;
        });
      });
    }

    return [m];
  }

  List<Marker> zoomToBounds(List<ll.LatLng> bounds) {
    Marker m = Marker(
      point: ll.LatLng(bounds[0].latitude, bounds[0].longitude),
      height: 12,
      width: 12,
      child: Container(),
      alignment: const Alignment(-1, -2.5),
    );
    print('calling zoom to bounds!');

    WidgetsBinding.instance.addPostFrameCallback((_) {
// Calculate the center point
      final mapBounds = LatLngBounds.fromPoints(bounds);
      final centerLat =
          (mapBounds.southWest.latitude + mapBounds.northEast.latitude) / 2;
      final centerLng =
          (mapBounds.southWest.longitude + mapBounds.northEast.longitude) / 2;

      final centerPoint = LatLng(centerLat, centerLng);
      _animatedMapMove(
          ll.LatLng(centerPoint.latitude, centerPoint.longitude), 11);
      FFAppState().update(() {
        FFAppState().setBounds = false;
      });
    });
    return [m];
  }

  List<Marker> rebuildMap() {
    Marker m = Marker(
      point: ll.LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
      height: 12,
      width: 12,
      child: Container(),
      alignment: const Alignment(-1, -2.5),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeMapData(FFAppState().placeTypePref);
      FFAppState().update(() {
        FFAppState().rebuildMap = false;
      });
    });
    /*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      _mapController.fitCamera(
        CameraFit.bounds(
          bounds: mapBounds,
          padding: const EdgeInsets.symmetric(horizontal: 30),
        ),
      );
      
    });
    */

    return [m];
  }

/*
  
  
  CUSTOM MARKER BUILDERS
  
  
  */

  Future<Uint8List> widgetToImageBytes(CustomPainter painter, Size size) async {
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder,
        Rect.fromPoints(const Offset(0, 0), Offset(size.width, size.height)));

    painter.paint(canvas, size);

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> addActivityMarkerFn() async {
    final markerWidget = CustomCircleMarkerPainter();
    final markerImage =
        await widgetToImageBytes(markerWidget, const Size(150, 150));
    setState(() {
      addActivityMarker = markerImage;
    });
  }

/*
  
  
  ADD VENUES, SHOPS, LESSONS TO MAP 
  
  
  */

  List<Marker> addEventsToMap(List<String> placeTypePref) {
    allMarkers.clear();
    List<EventsRecord> docs = [];
    List<Marker> newMarkers = [];
    List<bg.Geofence> newGeofences = [];
    List<EventsRecord> eventsInArea = [];

    for (EventsRecord event in widget.events) {
      if (placeTypePref.contains(event.placeType) ||
          placeTypePref.contains("All")) {
        LatLng coordinates = event.coordinates!;
        double distance = calculateDistanceBetweenTwoPoints(
            LatLng(widget.currentSearchedArea.latitude,
                widget.currentSearchedArea.longitude),
            coordinates);

        if (distance < 15) {
          docs.add(event);
          eventsInArea.add(event);
          //geolocationPoints.add(ll.LatLng(coordinates.latitude, coordinates.longitude));

          String imgPath = event.markerIcon;
          newMarkers.add(
            Marker(
              point: ll.LatLng(coordinates.latitude, coordinates.longitude),
              width: FFAppState().scrolledToPlaceIndex ==
                      eventsInArea.indexOf(event)
                  ? 60
                  : 36,
              height: FFAppState().scrolledToPlaceIndex ==
                      eventsInArea.indexOf(event)
                  ? 60
                  : 36,
              child: addActivityMarker != null
                  ? GestureDetector(
                      onTap: () {
                        // if (_mapController.camera.zoom < 15) {
                        _animatedMapMove(
                            ll.LatLng(
                                coordinates.latitude, coordinates.longitude),
                            15);
                        //} else {
                        // _animatedMapMove(
                        //    ll.LatLng(
                        //        coordinates.latitude, coordinates.longitude),
                        //   _mapController.camera.zoom);
                        //}

                        widget.showCarouselAction(
                            docs, eventsInArea.indexOf(event));
                        canHideCarousel = false;
                      },
                      child: Stack(
                        children: [
                          Center(child: Image.memory(addActivityMarker!)),
                          Center(
                            child: SizedBox(
                              width: FFAppState().scrolledToPlaceIndex ==
                                      eventsInArea.indexOf(event)
                                  ? 27.5
                                  : 18,
                              height: FFAppState().scrolledToPlaceIndex ==
                                      eventsInArea.indexOf(event)
                                  ? 27.5
                                  : 18,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Image.network(imgPath),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(),
              alignment: const Alignment(0, 0),
            ),
          );
          /*
          Map<String, dynamic> geofenceDataMap = {
            'name': place.name,
            'reference': place.reference.path,
            'advertisementMessage': place.currentAdvertisement,
            'advertisementImg': place.currentAdvertisementImg,
          };
          newGeofences.add(
            bg.Geofence(
              identifier: place.name,
              latitude: coordinates.latitude,
              longitude: coordinates.longitude,
              radius: 500,
              notifyOnEntry: true,
              notifyOnExit: true,
              notifyOnDwell: true,
              loiteringDelay: 15000, // 30 seconds
              extras: {
                "placeData": geofenceDataMap,
              },
            ),
          );
          */
        }
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        allMarkers.addAll(newMarkers);
        placesAddedToMap = true;
        print('allMarkers: $allMarkers');
        if (!FFAppState().mapSheetOpen) {
          widget.placesFoundCallback(allMarkers.isNotEmpty);
        }
      });

      // Update the app state with the new places in the area.
      FFAppState().update(() {
        FFAppState().currentPlacesInArea.clear();
        FFAppState()
            .currentPlacesInArea
            .addAll(eventsInArea.map((p) => p.reference).toList());

        //FFAppState().setBounds = true;
      });

      // Add geofences outside of setState.
      for (var geofence in newGeofences) {
        addGeofence(geofence);
      }
    });
    //widget.placesFoundCallback(allMarkers.isNotEmpty);

    print('newMarkers: $allMarkers');
    print('currentPlacesInArea: ${FFAppState().currentPlacesInArea}');
    return allMarkers;

    // return [Marker(point: const ll.LatLng(0, 0), child: Container())];
  }

  List<CircleMarker> setGeolocationPoints(List<ll.LatLng> geolocationPoints) {
    List<CircleMarker> allCircles = [];
    for (ll.LatLng point in geolocationPoints) {
      allCircles.add(CircleMarker(
        point: point,
        color: Colors.purple.withOpacity(0.3),
        borderStrokeWidth: 2,
        useRadiusInMeter: true,
        radius: 500, // 150 meters
      ));
    }
    return allCircles;
  }

/*
  
  
  BUILD MAP
  
  
*/

  void _onSearchChanged() {
    FFAppState().update(() {
      FFAppState().mapSearchText = _searchController.text;
    });
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      // Make the API call
      _makeApiCall(_searchController.text);
    });
  }

  Future<void> _makeApiCall(String query) async {
    // Encode the query parameter to make it safe for use in the URL
    final String encodedQuery = Uri.encodeComponent(query);

    // Convert the latitude and longitude to strings with fixed precision
    String latStr = _currentPosition!.latitude.toStringAsFixed(15);
    String lngStr = _currentPosition!.longitude.toStringAsFixed(15);
    String apiToken =
        "pk.eyJ1Ijoib2pvLW11c2ljbmVhcm1lIiwiYSI6ImNsdzk2ZTQxZTAwOWUya25ma2RkemRpaTEifQ.mYwaQETrxMSBgDlNZKpuMg";

    // Encode the latitude and longitude with the comma separator

    // Construct the URL with the encoded query
    final String apiUrl =
        'https://api.mapbox.com/search/geocode/v6/forward?q=$encodedQuery&country=CA,US&proximity=${Uri.encodeComponent(lngStr)}%2C${Uri.encodeComponent(latStr)}&language=en&types=place&access_token=$apiToken';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Step 1: Parse the JSON response
        final Map<String, dynamic> parsedJson = jsonDecode(response.body);

        // Step 2: Extract the 'features' list
        final List<dynamic> features = parsedJson['features'];

        // Step 3: Extract "name, city" strings
        final List<String> cityStateList = features.map((feature) {
          final properties = feature['properties'];
          final city = properties['context']['place']['name'] ?? 'Unknown City';
          final stateProvince =
              properties['context']['region']['name'] ?? 'Unknown Region';
          return '$city, $stateProvince';
        }).toList();

        final List<LatLng> latLngList = features.map((feature) {
          final coordinates = feature['geometry']['coordinates'];
          final longitude = coordinates[0];
          final latitude = coordinates[1];
          return LatLng(latitude, longitude);
        }).toList();

        FFAppState().update(() {
          FFAppState().placesFound = cityStateList;
        });
        FFAppState().update(() {
          FFAppState().placesFoundCoordinates = latLngList;
        });
        print('Response data: ${response.body}');
      } else {
        print('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }

    print("Searching for: $query");
  }

/*
  
    // Your API call logic here

    
  }
  */

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
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : IgnorePointer(
                  ignoring: false,
                  child: Container(
                    color: FFAppState().darkMode
                        ? Colors.black.withOpacity(0.3)
                        : Colors.transparent,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: ll.LatLng(_currentPosition!.latitude,
                            _currentPosition!.longitude),
                        initialZoom: 11,
                        onTap: (_, latLng) {
                          //final mapSize = MediaQuery.of(context).size;
                          //final mapHeight = mapSize.height;
                          //final point = _mapController.camera.project(latLng);
                          //_waveController2.reset();
                          //_waveController2.forward();
                          //setState(() {
                          //tappedCoords = latLng;
                          //});

                          //FFAppState().update(() {
                          //FFAppState().mapClicked = true;
                          //FFAppState().currentSeachedArea = LatLng(
                          //latLng.latitude,
                          //latLng.longitude,
                          //);

                          //FFAppState().zoomToNoLoad = LatLng(
                          //latLng.latitude,
                          //latLng.longitude,
                          //);
                          //});
                          //Future.delayed(const Duration(seconds: 1), () {});
                          //set currentSearchedArea. Call ZoomTo
                        },
                        onPointerDown: (_, pos) {
                          setState(() {
                            canHideCarousel = true;
                          });
                        },
                        onPositionChanged: (_, changed) {
                          if (FFAppState().mapClicked) {
                            FFAppState().update(() {
                              FFAppState().mapClicked = false;
                            });
                          }

                          if (FFAppState().zoomTo != null) {
                            LatLng mapCenter = LatLng(
                                _mapController.camera.center.latitude,
                                _mapController.camera.center.longitude);
                            if (calculateDistanceBetweenTwoPoints(
                                    mapCenter, previousMarker!) <=
                                1.0) {
                              FFAppState().update(() {
                                FFAppState().zoomTo = null;
                              });
                            }
                          }
                          if (canHideCarousel) {
                            widget.hideCarouselAction();
                          }
                        },
                      ),
                      children: [
                        _darkModeContainerIfEnabled(
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 80.0,
                              height: 80.0,
                              point: ll.LatLng(_currentPosition!.latitude,
                                  _currentPosition!.longitude),
                              child: CustomPaint(
                                painter: LocationPainter(_waveController),
                                child: const SizedBox(
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (FFAppState().mapClicked)
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 50,
                                height: 50,
                                point: ll.LatLng(tappedCoords!.latitude,
                                    tappedCoords!.longitude),
                                child: CustomPaint(
                                  painter: ModifiedLocationPainter(
                                      _waveController2, context),
                                  child: const SizedBox(
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        /*
                    if (geolocationPoints.isNotEmpty)
                      CircleLayer(
                        circles: setGeolocationPoints(geolocationPoints),
                      ),
                      */

                        if (FFAppState().mapSetNorth)
                          MarkerLayer(
                            markers: [
                              mapSetNorth(FFAppState().mapSetNorth)
                            ], //zoom
                          ),
                        if (FFAppState().mapZoomOut)
                          MarkerLayer(
                            markers: [
                              mapZoomOut(FFAppState().mapZoomOut)
                            ], //zoom
                          ),
                        if (FFAppState().mapZoomIn)
                          MarkerLayer(
                            markers: [mapZoomIn(FFAppState().mapZoomIn)], //zoom
                          ),
                        if (FFAppState().directionCoordinates.isNotEmpty)
                          PolylineLayer(
                              polylines:
                                  setRoute(FFAppState().directionCoordinates)),
                        if (FFAppState().placePrefChanged)
                          MarkerLayer(
                            markers: filterAllMarkers(
                                FFAppState().placeTypePref), //zoom
                          ),
                        /*
                    if (widget.places.isNotEmpty && !placesAddedToMap)
                      MarkerLayer(
                        markers: addPlacesToMap(),
                      ),
                      */
                        if (allMarkers.isNotEmpty && placesAddedToMap)
                          MarkerLayer(
                            markers: allMarkers,
                          ),
                        if (FFAppState().zoomTo != null)
                          MarkerLayer(
                            markers: setZoomToPoint(FFAppState().zoomTo!),
                          ),
                        if (FFAppState().zoomToNoLoad != null)
                          MarkerLayer(
                            markers: setZoomToPointNoLoad(
                                FFAppState().zoomToNoLoad!),
                          ),
                        if (FFAppState().zoomToSwipe != null)
                          MarkerLayer(
                            markers: setZoomToSwipe(FFAppState().zoomToSwipe!),
                          ),
                        if (FFAppState().zoomOut)
                          MarkerLayer(
                            markers: [zoomOutFn(FFAppState().zoomOut)], //zoom
                          ),
                        if (FFAppState().rebuildMap)
                          MarkerLayer(
                            markers: rebuildMap(), //zoom
                          ),
                        if (FFAppState().setBounds &&
                            allMarkers.isNotEmpty &&
                            placesAddedToMap)
                          MarkerLayer(
                            markers: zoomToBounds(allMarkers
                                .map((marker) => marker.point)
                                .toList()), //zoom
                          ),
                        /*
                        MarkerLayer(
                          markers: FFAppState().mapClicked
                              ? [
                                  Marker(
                                      width: 80,
                                      height: 80,
                                      point: ll.LatLng(tappedCoords!.latitude,
                                          tappedCoords!.longitude),
                                      child: addActivityMarker != null
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Center(
                                                    child: Image.memory(
                                                        addActivityMarker!)),
                                                ClipPath(
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const CircularProgressIndicator(),
                                      alignment: const Alignment(0, -0.25))
                                ]
                              : [],
                        ),
                        */
                      ],
                    ),
                  ),
                ),
          Container(
            width: double.infinity,
            height: 170.0,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0x8B000000),
                  Color(0x18000000),
                  Color(0x00FFFFFF)
                ],
                stops: [0.0, 0.8, 1.0],
                begin: AlignmentDirectional(0.0, -1.0),
                end: AlignmentDirectional(0, 1.0),
              ),
            ),
          ),
          Positioned(
            top: 100.0,
            left: 20.0,
            right: 20.0,
            child: Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 4.0,
                    color: Color(0x33000000),
                    offset: Offset(
                      0.0,
                      2.0,
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(30.0),
                shape: BoxShape.rectangle,
              ),
              child: Stack(
                children: [
                  TextFormField(
                    //controller: _model.textController,
                    //focusNode: _model.textFieldFocusNode,
                    controller: _searchController,
                    onChanged: (_) {
                      _onSearchChanged();
                    },
                    onFieldSubmitted: (_) async {},
                    autofocus: false,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: false,
                      labelStyle:
                          FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0.0,
                              ),
                      alignLabelWithHint: false,
                      hintText: 'Search',
                      hintStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Readex Pro',
                                color: FlutterFlowTheme.of(context).primary,
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.all(12.0),
                      prefixIcon: Icon(
                        Icons.search,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                      suffixIcon: Icon(
                        Icons.tune,
                        color: FlutterFlowTheme.of(context).primary,
                        size: 20.0,
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                        ),
                    textAlign: TextAlign.start,
                  ),
                  Align(
                    alignment: const AlignmentDirectional(1.0, -1.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        FFAppState().update(() {
                          FFAppState().mapFilterActivated =
                              !FFAppState().mapFilterActivated;
                        });
                      },
                      child: Container(
                        width: 40.0,
                        height: 45.0,
                        decoration: const BoxDecoration(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
  
  
  CUSTOM MARKER PAINTERS
  
  
*/

class CustomCircleMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double shadowPadding = 5.0; // Padding for shadow
    const double strokeWidth = 4.0; // Width of the stroke

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final Paint fillPaint = Paint()
      ..color = const Color(0xFFFFFCEF) // Set color to #FFFCEF
      ..style = PaintingStyle.fill;

    final Paint strokePaint = Paint()
      ..color = const Color(0xFFE24B2A) // Set color to #E24B2A
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

class CustomMarkerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cornerRadius = 20.0;
    final double bottomPointHeight = 20.0; // Reduced arrow height
    final double bottomPointWidth = 20.0; // Adjusted width of the arrow
    final double shadowPadding = 5.0;

    final double rectHeight = size.height - bottomPointHeight;
    final double rectWidth = size.width - 2 * shadowPadding;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final RRect roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        shadowPadding,
        shadowPadding,
        rectWidth,
        rectHeight - shadowPadding,
      ),
      Radius.circular(cornerRadius),
    );

    final Path path = Path()
      ..addRRect(roundedRect)
      ..moveTo(size.width / 2 - bottomPointWidth / 2, rectHeight)
      ..lineTo(size.width / 2, rectHeight + bottomPointHeight)
      ..lineTo(size.width / 2 + bottomPointWidth / 2, rectHeight)
      ..close();

    // Draw shadow
    canvas.save();
    canvas.translate(1, 1); // Offset for shadow
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // Draw shape
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class TeardropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define the shadow paint
    Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3) // Shadow color with opacity
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10); // Blur effect

    // Define the main paint
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Define the path
    Path path = Path();

    // Start at the top center
    path.moveTo(size.width / 2, 0);

    // Draw the right side of the circle
    path.quadraticBezierTo(size.width, 0, size.width, size.height / 2);

    // Draw the line to the bottom point
    path.lineTo(size.width / 2, size.height);

    // Draw the left side of the circle
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(0, 0, size.width / 2, 0);

    path.close();

    // Draw the shadow path first
    canvas.save();
    canvas.translate(5, 5); // Offset the shadow slightly
    canvas.drawPath(path, shadowPaint);
    canvas.restore();

    // Draw the main path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ModifiedLocationPainter extends CustomPainter {
  final Animation<double> animation;
  final BuildContext context;

  ModifiedLocationPainter(this.animation, this.context)
      : super(repaint: animation);
  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = 10;

    final Paint paint = Paint()
      ..color =
          Colors.blue.withOpacity(0.0) // Make the central circle invisible
      ..style = PaintingStyle.fill;

    // Draw the invisible location icon (a simple circle for this example)
    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    // Draw the animated wave effect
    final double waveRadius = (size.width / 2) * animation.value;
    paint
      ..color = FlutterFlowTheme.of(context)
          .primary
          .withOpacity(0.5 * (1 - animation.value))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(Offset(centerX, centerY), waveRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
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
