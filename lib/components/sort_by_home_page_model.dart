import '';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:math';
import 'dart:ui';
import 'sort_by_home_page_widget.dart' show SortByHomePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SortByHomePageModel extends FlutterFlowModel<SortByHomePageWidget> {
  ///  Local state fields for this component.

  bool isDateDecending = true;

  bool isDistanceDecending = true;

  bool isDate = true;

  bool isDistance = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
