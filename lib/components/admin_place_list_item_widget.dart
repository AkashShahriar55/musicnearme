import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'admin_place_list_item_model.dart';
export 'admin_place_list_item_model.dart';

class AdminPlaceListItemWidget extends StatefulWidget {
  const AdminPlaceListItemWidget({
    super.key,
    this.bannerImg,
    this.name,
    this.coordinates,
    this.placeRef,
    required this.favoritedBy,
    required this.placeType,
  });

  final String? bannerImg;
  final String? name;
  final LatLng? coordinates;
  final DocumentReference? placeRef;
  final List<DocumentReference>? favoritedBy;
  final String? placeType;

  @override
  State<AdminPlaceListItemWidget> createState() =>
      _AdminPlaceListItemWidgetState();
}

class _AdminPlaceListItemWidgetState extends State<AdminPlaceListItemWidget> {
  late AdminPlaceListItemModel _model;

  LatLng? currentUserLocationValue;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminPlaceListItemModel());

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
      height: 175.0,
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
              AdminViewPlaceWidget.routeName,
              queryParameters: {
                'placeRef': serializeParam(
                  widget.placeRef,
                  ParamType.DocumentReference,
                ),
              }.withoutNulls,
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: 100.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(
                      widget.bannerImg!,
                    ).image,
                  ),
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
                          placeRef: widget.placeRef,
                          type: widget.placeType,
                        ))) {
                          await currentUserReference!.update({
                            ...mapToFirestore(
                              {
                                'favorites': FieldValue.arrayRemove([
                                  getFavoriteObjFirestoreData(
                                    createFavoriteObjStruct(
                                      placeRef: widget.placeRef,
                                      type: widget.placeType,
                                      clearUnsetFields: false,
                                    ),
                                    true,
                                  )
                                ]),
                              },
                            ),
                          });

                          await widget.placeRef!.update({
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
                                      placeRef: widget.placeRef,
                                      type: widget.placeType,
                                      clearUnsetFields: false,
                                    ),
                                    true,
                                  )
                                ]),
                              },
                            ),
                          });

                          await widget.placeRef!.update({
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
                              if (!widget.favoritedBy!
                                  .contains(currentUserReference))
                                Icon(
                                  Icons.favorite_border,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 22.0,
                                ),
                              if (widget.favoritedBy
                                      ?.contains(currentUserReference) ??
                                  true)
                                Icon(
                                  Icons.favorite,
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  size: 22.0,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      widget.name!,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                  ),
                  Text(
                    '${formatNumber(
                      functions.haversineDistance(
                          currentUserLocationValue!, widget.coordinates!),
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
