import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'blank_model.dart';
export 'blank_model.dart';

/// For when there's nothing in a listview
class BlankWidget extends StatefulWidget {
  const BlankWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.titleSize,
    required this.subtitleSize,
  });

  final String? title;
  final String? subtitle;
  final Widget? icon;
  final int? titleSize;
  final int? subtitleSize;

  @override
  State<BlankWidget> createState() => _BlankWidgetState();
}

class _BlankWidgetState extends State<BlankWidget> {
  late BlankModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BlankModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget!.title!,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: widget!.titleSize?.toDouble(),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            widget!.subtitle!,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: widget!.subtitleSize?.toDouble(),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          widget!.icon!,
        ].divide(SizedBox(height: 15.0)),
      ),
    );
  }
}
