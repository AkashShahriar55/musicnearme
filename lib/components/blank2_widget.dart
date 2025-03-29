import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'blank2_model.dart';
export 'blank2_model.dart';

/// For when there's nothing in a listview
class Blank2Widget extends StatefulWidget {
  const Blank2Widget({super.key});

  @override
  State<Blank2Widget> createState() => _Blank2WidgetState();
}

class _Blank2WidgetState extends State<Blank2Widget> {
  late Blank2Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Blank2Model());

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
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 20.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFDADADA),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
