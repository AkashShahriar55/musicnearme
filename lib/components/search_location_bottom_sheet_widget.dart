import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/location_info_item_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/permissions_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_location_bottom_sheet_model.dart';
export 'search_location_bottom_sheet_model.dart';

class SearchLocationBottomSheetWidget extends StatefulWidget {
  const SearchLocationBottomSheetWidget({
    super.key,
    required this.currentLocationInfoFromPage,
  });

  final LocationInfoStruct? currentLocationInfoFromPage;

  @override
  State<SearchLocationBottomSheetWidget> createState() =>
      _SearchLocationBottomSheetWidgetState();
}

class _SearchLocationBottomSheetWidgetState
    extends State<SearchLocationBottomSheetWidget>
    with TickerProviderStateMixin {
  late SearchLocationBottomSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchLocationBottomSheetModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 0.0),
          child: TextFormField(
            controller: _model.textController,
            focusNode: _model.textFieldFocusNode,
            onChanged: (_) => EasyDebounce.debounce(
              '_model.textController',
              Duration(milliseconds: 2000),
              () async {
                if (_model.isSuggestionLoading == false) {
                  _model.isSuggestionLoading = true;
                  safeSetState(() {});
                  _model.searchedLocations = await LocationSuggestCall.call(
                    q: _model.textController.text,
                    accessToken:
                        'pk.eyJ1Ijoic2VhcmNoLW1hY2hpbmUtdXNlci0xIiwiYSI6ImNrNnJ6bDdzdzA5cnAza3F4aTVwcWxqdWEifQ.RFF7CVFKrUsZVrJsFzhRvQ',
                    sessionToken: '5721220b-013a-495a-af56-ab9c1d93e16d',
                  );

                  if ((_model.searchedLocations?.succeeded ?? true) == true) {
                    _model.locationSuggestions =
                        LocationSuggestCall.suggestionMap(
                      (_model.searchedLocations?.jsonBody ?? ''),
                    )!
                            .toList()
                            .cast<LocationSuggestionStruct>();
                    safeSetState(() {});
                  }
                  _model.isSuggestionLoading = false;
                  safeSetState(() {});
                }

                safeSetState(() {});
              },
            ),
            textInputAction: TextInputAction.go,
            obscureText: false,
            decoration: InputDecoration(
              isDense: false,
              labelText: 'Search for patients...',
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: FlutterFlowTheme.of(context).primaryBackground,
              prefixIcon: Icon(
                Icons.search_outlined,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  letterSpacing: 0.0,
                ),
            maxLines: null,
            validator: _model.textControllerValidator.asValidator(context),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 0.0),
          child: Builder(
            builder: (context) {
              final locationDataList = _model.locationSuggestions.toList();

              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: locationDataList.length,
                itemBuilder: (context, locationDataListIndex) {
                  final locationDataListItem =
                      locationDataList[locationDataListIndex];
                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.getLocationInfo = await LocationRetreiveCall.call(
                        id: locationDataListItem.mapboxId,
                        sessionToken: '02edef93-9c11-48d1-895d-c195f9a0ee21',
                        accessToken:
                            'pk.eyJ1Ijoic2VhcmNoLW1hY2hpbmUtdXNlci0xIiwiYSI6ImNrNnJ6bDdzdzA5cnAza3F4aTVwcWxqdWEifQ.RFF7CVFKrUsZVrJsFzhRvQ',
                      );

                      if ((_model.getLocationInfo?.succeeded ?? true) == true) {
                        FFAppState().selectedLocation = LocationInfoStruct(
                          latlng: LocationRetreiveCall.locationlatlong(
                            (_model.getLocationInfo?.jsonBody ?? ''),
                          ),
                          address:
                              '${locationDataListItem.name},${locationDataListItem.placeFormatted}',
                        );
                        _model.updatePage(() {});
                        context.safePop();
                      }

                      safeSetState(() {});
                    },
                    child: LocationInfoItemWidget(
                      key: Key(
                          'Keygoc_${locationDataListIndex}_of_${locationDataList.length}'),
                      locationInfo: locationDataListItem,
                    ),
                  );
                },
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 1.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              await requestPermission(locationPermission);
              FFAppState().selectedLocation =
                  widget!.currentLocationInfoFromPage!;
              safeSetState(() {});
              context.safePop();
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.0,
                    color: FlutterFlowTheme.of(context).alternate,
                    offset: Offset(
                      0.0,
                      1.0,
                    ),
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.my_location_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                12.0, 0.0, 0.0, 0.0),
                            child: Text(
                              'Your current location',
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FFButtonWidget(
                onPressed: () async {
                  context.safePop();
                },
                text: 'Cancel',
                options: FFButtonOptions(
                  height: 40.0,
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  iconPadding:
                      EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
