import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'event_list_item_model.dart';
export 'event_list_item_model.dart';

class EventListItemWidget extends StatefulWidget {
  const EventListItemWidget({
    super.key,
    required this.placeDoc,
    required this.eventDoc,
  });

  final PlacesRecord? placeDoc;
  final EventsRecord? eventDoc;

  @override
  State<EventListItemWidget> createState() => _EventListItemWidgetState();
}

class _EventListItemWidgetState extends State<EventListItemWidget> {
  late EventListItemModel _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EventListItemModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => safeSetState(() => currentUserLocationValue = loc));
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: SpinKitWave(
              color: FlutterFlowTheme.of(context).primary,
              size: 50.0,
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 200.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            context.pushNamed(
              ViewPlacePageWidget.routeName,
              queryParameters: {
                'placeDoc': serializeParam(
                  widget.placeDoc,
                  ParamType.Document,
                ),
              }.withoutNulls,
              extra: <String, dynamic>{
                'placeDoc': widget.placeDoc,
              },
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: valueOrDefault<String>(
                      widget.placeDoc?.bannerImg,
                      'https://picsum.photos/seed/809/600',
                    ),
                    transitionOnUserGestures: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        valueOrDefault<String>(
                          widget.placeDoc?.bannerImg,
                          'https://picsum.photos/seed/809/600',
                        ),
                        width: double.infinity,
                        height: 100.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          'assets/images/error_image.png',
                          width: double.infinity,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0.2,
                    child: Container(
                      width: double.infinity,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            if ((currentUserDocument?.favorites.toList() ?? [])
                                .contains(FavoriteObjStruct(
                              placeRef: widget.placeDoc?.reference,
                              type: widget.placeDoc?.placeType,
                            ))) {
                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'favorites': FieldValue.arrayRemove([
                                      getFavoriteObjFirestoreData(
                                        createFavoriteObjStruct(
                                          placeRef: widget.placeDoc?.reference,
                                          type: widget.placeDoc?.placeType,
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });

                              await widget.placeDoc!.reference.update({
                                ...mapToFirestore(
                                  {
                                    'favoritedBy': FieldValue.arrayRemove(
                                        [currentUserReference]),
                                  },
                                ),
                              });
                            } else {
                              await currentUserReference!.update({
                                ...mapToFirestore(
                                  {
                                    'favorites': FieldValue.arrayUnion([
                                      getFavoriteObjFirestoreData(
                                        createFavoriteObjStruct(
                                          placeRef: widget.placeDoc?.reference,
                                          type: widget.placeDoc?.placeType,
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });

                              await widget.placeDoc!.reference.update({
                                ...mapToFirestore(
                                  {
                                    'favoritedBy': FieldValue.arrayUnion(
                                        [currentUserReference]),
                                  },
                                ),
                              });
                            }
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(),
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Stack(
                                children: [
                                  Icon(
                                    Icons.favorite_border,
                                    color: Color(0xFFFFFCEF),
                                    size: 22.0,
                                  ),
                                  if ((currentUserDocument?.favorites
                                              .toList() ??
                                          [])
                                      .contains(FavoriteObjStruct(
                                    placeRef: widget.placeDoc?.reference,
                                    type: widget.placeDoc?.placeType,
                                  )))
                                    AuthUserStreamWidget(
                                      builder: (context) => Icon(
                                        Icons.favorite,
                                        color: Color(0xFFFFFCEF),
                                        size: 22.0,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(-1.0, 0.0),
                        child: Text(
                          '${widget.eventDoc?.name} - ${widget.placeDoc?.name}',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Expanded(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xFFF6EA33),
                                size: 22.0,
                              ),
                              Text(
                                '5.0',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ].divide(SizedBox(width: 5.0)),
                          ),
                        ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        dateTimeFormat(
                          "MMM d, h:00a",
                          widget.eventDoc!.startTime!,
                          locale: FFLocalizations.of(context).languageCode,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                      Text(
                        '${formatNumber(
                          functions.haversineDistance(currentUserLocationValue!,
                              widget.placeDoc!.coordinates!),
                          formatType: FormatType.custom,
                          format: '###.0#',
                          locale: '',
                        )} KM',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Readex Pro',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(SizedBox(width: 10.0)),
                  ),
                ].divide(SizedBox(height: 5.0)),
              ),
              Divider(
                thickness: 1.0,
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
            ].divide(SizedBox(height: 10.0)),
          ),
        ),
      ),
    );
  }
}
