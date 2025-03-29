import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/components/blank_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/pages/places/place_list_item/place_list_item_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favorites_page_model.dart';
export 'favorites_page_model.dart';

class FavoritesPageWidget extends StatefulWidget {
  const FavoritesPageWidget({super.key});

  static String routeName = 'favoritesPage';
  static String routePath = '/favoritesPage';

  @override
  State<FavoritesPageWidget> createState() => _FavoritesPageWidgetState();
}

class _FavoritesPageWidgetState extends State<FavoritesPageWidget> {
  late FavoritesPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavoritesPageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.favorites = (currentUserDocument?.favorites?.toList() ?? [])
          .toList()
          .cast<FavoriteObjStruct>();
      safeSetState(() {});
    });

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
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: 213.0,
                      height: 30.0,
                      decoration: BoxDecoration(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.asset(
                              'assets/images/musicnearmeLogoFilled.png',
                              width: 30.0,
                              height: 30.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              'Music Near Me',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Satisfy',
                                    fontSize: 22.0,
                                    letterSpacing: 0.0,
                                    useGoogleFonts: false,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 10.0, 15.0, 0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.filter = ["Venues", "Shops", "Lessons"]
                                  .toList()
                                  .cast<String>();
                              safeSetState(() {});
                              _model.favorites = functions
                                  .filteredFavorites(
                                      _model.filter.toList(),
                                      (currentUserDocument?.favorites
                                                  ?.toList() ??
                                              [])
                                          .toList())
                                  .toList()
                                  .cast<FavoriteObjStruct>();
                              safeSetState(() {});
                            },
                            child: Container(
                              width: 80.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: valueOrDefault<Color>(
                                  _model.filter.length > 1
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  FlutterFlowTheme.of(context).primary,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: valueOrDefault<Color>(
                                    _model.filter.length > 1
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    Colors.white,
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'All',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: valueOrDefault<Color>(
                                          _model.filter.length > 1
                                              ? FlutterFlowTheme.of(context)
                                                  .primaryBackground
                                              : FlutterFlowTheme.of(context)
                                                  .primaryText,
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.filter =
                                  ["Venues"].toList().cast<String>();
                              safeSetState(() {});
                              _model.favorites = functions
                                  .filteredFavorites(
                                      _model.filter.toList(),
                                      (currentUserDocument?.favorites
                                                  ?.toList() ??
                                              [])
                                          .toList())
                                  .toList()
                                  .cast<FavoriteObjStruct>();
                              safeSetState(() {});
                            },
                            child: Container(
                              width: 80.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: valueOrDefault<Color>(
                                  (_model.filter.elementAtOrNull(0) ==
                                              'Venues') &&
                                          (_model.filter.length == 1)
                                      ? FlutterFlowTheme.of(context).primary
                                      : FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                  FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: valueOrDefault<Color>(
                                    (_model.filter.elementAtOrNull(0) ==
                                                'Venues') &&
                                            (_model.filter.length == 1)
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Venues',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            (_model.filter.elementAtOrNull(0) ==
                                                        'Venues') &&
                                                    (_model.filter.length == 1)
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.filter = ["Shops"].toList().cast<String>();
                              safeSetState(() {});
                              _model.favorites = functions
                                  .filteredFavorites(
                                      _model.filter.toList(),
                                      (currentUserDocument?.favorites
                                                  ?.toList() ??
                                              [])
                                          .toList())
                                  .toList()
                                  .cast<FavoriteObjStruct>();
                              safeSetState(() {});
                            },
                            child: Container(
                              width: 80.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: (_model.filter.elementAtOrNull(0) ==
                                            'Shops') &&
                                        (_model.filter.length == 1)
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: valueOrDefault<Color>(
                                    (_model.filter.elementAtOrNull(0) ==
                                                'Shops') &&
                                            (_model.filter.length == 1)
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Shops',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            (_model.filter.elementAtOrNull(0) ==
                                                        'Shops') &&
                                                    (_model.filter.length == 1)
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              _model.filter =
                                  ["Lessons"].toList().cast<String>();
                              safeSetState(() {});
                              _model.favorites = functions
                                  .filteredFavorites(
                                      _model.filter.toList(),
                                      (currentUserDocument?.favorites
                                                  ?.toList() ??
                                              [])
                                          .toList())
                                  .toList()
                                  .cast<FavoriteObjStruct>();
                              safeSetState(() {});
                            },
                            child: Container(
                              width: 80.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: (_model.filter.elementAtOrNull(0) ==
                                            'Lessons') &&
                                        (_model.filter.length == 1)
                                    ? FlutterFlowTheme.of(context).primary
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                borderRadius: BorderRadius.circular(30.0),
                                border: Border.all(
                                  color: valueOrDefault<Color>(
                                    (_model.filter.elementAtOrNull(0) ==
                                                'Lessons') &&
                                            (_model.filter.length == 1)
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : FlutterFlowTheme.of(context)
                                            .primaryText,
                                    FlutterFlowTheme.of(context).primaryText,
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Text(
                                  'Lessons',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color:
                                            (_model.filter.elementAtOrNull(0) ==
                                                        'Lessons') &&
                                                    (_model.filter.length == 1)
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : FlutterFlowTheme.of(context)
                                                    .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            Builder(
                              builder: (context) {
                                final favorite = _model.favorites.toList();
                                if (favorite.isEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    height: 300.0,
                                    child: BlankWidget(
                                      title: valueOrDefault<String>(
                                        () {
                                          if (_model.filter.length > 1) {
                                            return 'No favorites';
                                          } else if (_model.filter
                                                  .elementAtOrNull(0) ==
                                              'Venues') {
                                            return 'No favorite venues';
                                          } else if (_model.filter
                                                  .elementAtOrNull(0) ==
                                              'Shops') {
                                            return 'No favorite shops';
                                          } else if (_model.filter
                                                  .elementAtOrNull(0) ==
                                              'Lessons') {
                                            return 'No favorite lessons';
                                          } else {
                                            return 'No favorites';
                                          }
                                        }(),
                                        'No favorites',
                                      ),
                                      subtitle:
                                          'Favorite places will show up here',
                                      icon: Icon(
                                        Icons.favorite,
                                      ),
                                      titleSize: 22,
                                      subtitleSize: 16,
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: favorite.length,
                                  itemBuilder: (context, favoriteIndex) {
                                    final favoriteItem =
                                        favorite[favoriteIndex];
                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: StreamBuilder<PlacesRecord>(
                                        stream: PlacesRecord.getDocument(
                                            favoriteItem.placeRef!),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child: SpinKitWave(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 50.0,
                                                ),
                                              ),
                                            );
                                          }

                                          final containerPlacesRecord =
                                              snapshot.data!;

                                          return Container(
                                            decoration: BoxDecoration(),
                                            child: PlaceListItemWidget(
                                              key: Key(
                                                  'Keyzeh_${favoriteIndex}_of_${favorite.length}'),
                                              placeDoc: containerPlacesRecord,
                                              favoritesCallback: () async {
                                                _model.removeFromFavorites(
                                                    favoriteItem);
                                                safeSetState(() {});
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
                    .divide(SizedBox(height: 20.0))
                    .addToStart(SizedBox(height: 60.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
