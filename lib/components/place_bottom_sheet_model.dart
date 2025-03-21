import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'place_bottom_sheet_widget.dart' show PlaceBottomSheetWidget;
import 'package:flutter/material.dart';

class PlaceBottomSheetModel extends FlutterFlowModel<PlaceBottomSheetWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 0;

  // Stores action output result for [Backend Call - Read Document] action in Carousel widget.
  PlacesRecord? scrolledToPlace;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
