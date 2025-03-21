import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'favorites_page_widget.dart' show FavoritesPageWidget;
import 'package:flutter/material.dart';

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
