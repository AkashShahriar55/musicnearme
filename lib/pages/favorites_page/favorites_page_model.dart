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
import 'favorites_page_widget.dart' show FavoritesPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoritesPageModel extends FlutterFlowModel<FavoritesPageWidget> {
  ///  Local state fields for this page.

  List<String> filter = ['Venues', 'Shops', 'Lessons'];
  void addToFilter(String item) => filter.add(item);
  void removeFromFilter(String item) => filter.remove(item);
  void removeAtIndexFromFilter(int index) => filter.removeAt(index);
  void insertAtIndexInFilter(int index, String item) =>
      filter.insert(index, item);
  void updateFilterAtIndex(int index, Function(String) updateFn) =>
      filter[index] = updateFn(filter[index]);

  List<FavoriteObjStruct> favorites = [];
  void addToFavorites(FavoriteObjStruct item) => favorites.add(item);
  void removeFromFavorites(FavoriteObjStruct item) => favorites.remove(item);
  void removeAtIndexFromFavorites(int index) => favorites.removeAt(index);
  void insertAtIndexInFavorites(int index, FavoriteObjStruct item) =>
      favorites.insert(index, item);
  void updateFavoritesAtIndex(
          int index, Function(FavoriteObjStruct) updateFn) =>
      favorites[index] = updateFn(favorites[index]);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
