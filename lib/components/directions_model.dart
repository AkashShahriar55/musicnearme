import '/flutter_flow/flutter_flow_util.dart';
import 'directions_widget.dart' show DirectionsWidget;
import 'package:flutter/material.dart';

class DirectionsModel extends FlutterFlowModel<DirectionsWidget> {
  ///  Local state fields for this component.

  LatLng? placePoint;

  List<LatLng> allRoutePoints = [];
  void addToAllRoutePoints(LatLng item) => allRoutePoints.add(item);
  void removeFromAllRoutePoints(LatLng item) => allRoutePoints.remove(item);
  void removeAtIndexFromAllRoutePoints(int index) =>
      allRoutePoints.removeAt(index);
  void insertAtIndexInAllRoutePoints(int index, LatLng item) =>
      allRoutePoints.insert(index, item);
  void updateAllRoutePointsAtIndex(int index, Function(LatLng) updateFn) =>
      allRoutePoints[index] = updateFn(allRoutePoints[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
