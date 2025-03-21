import '';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_page_copy_model.dart';
export 'search_page_copy_model.dart';

class SearchPageCopyWidget extends StatefulWidget {
  const SearchPageCopyWidget({super.key});

  static String routeName = 'searchPageCopy';
  static String routePath = '/searchPageCopy';

  @override
  State<SearchPageCopyWidget> createState() => _SearchPageCopyWidgetState();
}

class _SearchPageCopyWidgetState extends State<SearchPageCopyWidget> {
  late SearchPageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageCopyModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(8.0, 100.0, 8.0, 0.0),
                child: TextFormField(
                  controller: _model.textController,
                  focusNode: _model.textFieldFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.textController',
                    Duration(milliseconds: 2000),
                    () async {
                      currentUserLocationValue = await getCurrentUserLocation(
                          defaultLocation: LatLng(0.0, 0.0));
                      _model.apiResultjyu = await ForwardGeocodeCall.call(
                        token:
                            'pk.eyJ1IjoiYnJhbnNtYXBib3hhY2MiLCJhIjoiY2x5N2dudmxnMDVxeDJrb2pjaGZqNHR5cCJ9.JpLCapjb4ND8mIOW7g4utQ',
                        encodedQuery: _model.textController.text,
                        encodedCoordinates: functions
                            .getCoordnateQueryString(currentUserLocationValue!),
                        language: 'en',
                      );

                      if ((_model.apiResultjyu?.succeeded ?? true)) {
                        _model.output =
                            'SUCCEEDED! ${(_model.apiResultjyu?.jsonBody ?? '').toString()}';
                        safeSetState(() {});
                      } else {
                        _model.output =
                            'FAILED! ${(_model.apiResultjyu?.jsonBody ?? '').toString()}';
                        safeSetState(() {});
                      }

                      safeSetState(() {});
                    },
                  ),
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Label here...',
                    labelStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                    hintStyle:
                        FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Readex Pro',
                              letterSpacing: 0.0,
                            ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).error,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    suffixIcon: _model.textController!.text.isNotEmpty
                        ? InkWell(
                            onTap: () async {
                              _model.textController?.clear();
                              currentUserLocationValue =
                                  await getCurrentUserLocation(
                                      defaultLocation: LatLng(0.0, 0.0));
                              _model.apiResultjyu =
                                  await ForwardGeocodeCall.call(
                                token:
                                    'pk.eyJ1IjoiYnJhbnNtYXBib3hhY2MiLCJhIjoiY2x5N2dudmxnMDVxeDJrb2pjaGZqNHR5cCJ9.JpLCapjb4ND8mIOW7g4utQ',
                                encodedQuery: _model.textController.text,
                                encodedCoordinates:
                                    functions.getCoordnateQueryString(
                                        currentUserLocationValue!),
                                language: 'en',
                              );

                              if ((_model.apiResultjyu?.succeeded ?? true)) {
                                _model.output =
                                    'SUCCEEDED! ${(_model.apiResultjyu?.jsonBody ?? '').toString()}';
                                safeSetState(() {});
                              } else {
                                _model.output =
                                    'FAILED! ${(_model.apiResultjyu?.jsonBody ?? '').toString()}';
                                safeSetState(() {});
                              }

                              safeSetState(() {});
                              safeSetState(() {});
                            },
                            child: Icon(
                              Icons.clear,
                              size: 12.0,
                            ),
                          )
                        : null,
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                  validator:
                      _model.textControllerValidator.asValidator(context),
                ),
              ),
              if (_model.output != null && _model.output != '')
                Container(
                  width: double.infinity,
                  height: 300.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Text(
                    _model.output!,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
