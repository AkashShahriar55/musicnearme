import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _onboardingComplete =
          prefs.getBool('ff_onboardingComplete') ?? _onboardingComplete;
    });
    _safeInit(() {
      _darkMode = prefs.getBool('ff_darkMode') ?? _darkMode;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _currentPage = 'Home';
  String get currentPage => _currentPage;
  set currentPage(String value) {
    _currentPage = value;
  }

  bool _centerOnUser = false;
  bool get centerOnUser => _centerOnUser;
  set centerOnUser(bool value) {
    _centerOnUser = value;
  }

  bool _mapClicked = false;
  bool get mapClicked => _mapClicked;
  set mapClicked(bool value) {
    _mapClicked = value;
  }

  LatLng? _clickedPosition;
  LatLng? get clickedPosition => _clickedPosition;
  set clickedPosition(LatLng? value) {
    _clickedPosition = value;
  }

  List<String> _placeTypePref = ['Venues', 'Shops', 'Lessons'];
  List<String> get placeTypePref => _placeTypePref;
  set placeTypePref(List<String> value) {
    _placeTypePref = value;
  }

  void addToPlaceTypePref(String value) {
    placeTypePref.add(value);
  }

  void removeFromPlaceTypePref(String value) {
    placeTypePref.remove(value);
  }

  void removeAtIndexFromPlaceTypePref(int index) {
    placeTypePref.removeAt(index);
  }

  void updatePlaceTypePrefAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    placeTypePref[index] = updateFn(_placeTypePref[index]);
  }

  void insertAtIndexInPlaceTypePref(int index, String value) {
    placeTypePref.insert(index, value);
  }

  LatLng? _zoomTo;
  LatLng? get zoomTo => _zoomTo;
  set zoomTo(LatLng? value) {
    _zoomTo = value;
  }

  bool _onboardingComplete = false;
  bool get onboardingComplete => _onboardingComplete;
  set onboardingComplete(bool value) {
    _onboardingComplete = value;
    prefs.setBool('ff_onboardingComplete', value);
  }

  bool _darkMode = false;
  bool get darkMode => _darkMode;
  set darkMode(bool value) {
    _darkMode = value;
    prefs.setBool('ff_darkMode', value);
  }

  bool _zoomOut = false;
  bool get zoomOut => _zoomOut;
  set zoomOut(bool value) {
    _zoomOut = value;
  }

  LatLng? _currentUserLocation;
  LatLng? get currentUserLocation => _currentUserLocation;
  set currentUserLocation(LatLng? value) {
    _currentUserLocation = value;
  }

  List<String> _routeDirections = [];
  List<String> get routeDirections => _routeDirections;
  set routeDirections(List<String> value) {
    _routeDirections = value;
  }

  void addToRouteDirections(String value) {
    routeDirections.add(value);
  }

  void removeFromRouteDirections(String value) {
    routeDirections.remove(value);
  }

  void removeAtIndexFromRouteDirections(int index) {
    routeDirections.removeAt(index);
  }

  void updateRouteDirectionsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    routeDirections[index] = updateFn(_routeDirections[index]);
  }

  void insertAtIndexInRouteDirections(int index, String value) {
    routeDirections.insert(index, value);
  }

  List<LatLng> _routeCoordinates = [];
  List<LatLng> get routeCoordinates => _routeCoordinates;
  set routeCoordinates(List<LatLng> value) {
    _routeCoordinates = value;
  }

  void addToRouteCoordinates(LatLng value) {
    routeCoordinates.add(value);
  }

  void removeFromRouteCoordinates(LatLng value) {
    routeCoordinates.remove(value);
  }

  void removeAtIndexFromRouteCoordinates(int index) {
    routeCoordinates.removeAt(index);
  }

  void updateRouteCoordinatesAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    routeCoordinates[index] = updateFn(_routeCoordinates[index]);
  }

  void insertAtIndexInRouteCoordinates(int index, LatLng value) {
    routeCoordinates.insert(index, value);
  }

  List<LatLng> _directionCoordinates = [];
  List<LatLng> get directionCoordinates => _directionCoordinates;
  set directionCoordinates(List<LatLng> value) {
    _directionCoordinates = value;
  }

  void addToDirectionCoordinates(LatLng value) {
    directionCoordinates.add(value);
  }

  void removeFromDirectionCoordinates(LatLng value) {
    directionCoordinates.remove(value);
  }

  void removeAtIndexFromDirectionCoordinates(int index) {
    directionCoordinates.removeAt(index);
  }

  void updateDirectionCoordinatesAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    directionCoordinates[index] = updateFn(_directionCoordinates[index]);
  }

  void insertAtIndexInDirectionCoordinates(int index, LatLng value) {
    directionCoordinates.insert(index, value);
  }

  bool _directionsActive = false;
  bool get directionsActive => _directionsActive;
  set directionsActive(bool value) {
    _directionsActive = value;
  }

  double _currentUserDegrees = 0.0;
  double get currentUserDegrees => _currentUserDegrees;
  set currentUserDegrees(double value) {
    _currentUserDegrees = value;
  }

  bool _mapZoomIn = false;
  bool get mapZoomIn => _mapZoomIn;
  set mapZoomIn(bool value) {
    _mapZoomIn = value;
  }

  bool _mapZoomOut = false;
  bool get mapZoomOut => _mapZoomOut;
  set mapZoomOut(bool value) {
    _mapZoomOut = value;
  }

  bool _mapSetNorth = false;
  bool get mapSetNorth => _mapSetNorth;
  set mapSetNorth(bool value) {
    _mapSetNorth = value;
  }

  List<String> _filterCategories = ['Venues', 'Shops', 'Lessons'];
  List<String> get filterCategories => _filterCategories;
  set filterCategories(List<String> value) {
    _filterCategories = value;
  }

  void addToFilterCategories(String value) {
    filterCategories.add(value);
  }

  void removeFromFilterCategories(String value) {
    filterCategories.remove(value);
  }

  void removeAtIndexFromFilterCategories(int index) {
    filterCategories.removeAt(index);
  }

  void updateFilterCategoriesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    filterCategories[index] = updateFn(_filterCategories[index]);
  }

  void insertAtIndexInFilterCategories(int index, String value) {
    filterCategories.insert(index, value);
  }

  LatLng? _defaultLatLng = LatLng(0, 0);
  LatLng? get defaultLatLng => _defaultLatLng;
  set defaultLatLng(LatLng? value) {
    _defaultLatLng = value;
  }

  String _geofenceTest = '';
  String get geofenceTest => _geofenceTest;
  set geofenceTest(String value) {
    _geofenceTest = value;
  }

  String _currentUserLocationString = '';
  String get currentUserLocationString => _currentUserLocationString;
  set currentUserLocationString(String value) {
    _currentUserLocationString = value;
  }

  List<DocumentReference> _venuesNearMe = [];
  List<DocumentReference> get venuesNearMe => _venuesNearMe;
  set venuesNearMe(List<DocumentReference> value) {
    _venuesNearMe = value;
  }

  void addToVenuesNearMe(DocumentReference value) {
    venuesNearMe.add(value);
  }

  void removeFromVenuesNearMe(DocumentReference value) {
    venuesNearMe.remove(value);
  }

  void removeAtIndexFromVenuesNearMe(int index) {
    venuesNearMe.removeAt(index);
  }

  void updateVenuesNearMeAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    venuesNearMe[index] = updateFn(_venuesNearMe[index]);
  }

  void insertAtIndexInVenuesNearMe(int index, DocumentReference value) {
    venuesNearMe.insert(index, value);
  }

  List<DocumentReference> _shopsNearMe = [];
  List<DocumentReference> get shopsNearMe => _shopsNearMe;
  set shopsNearMe(List<DocumentReference> value) {
    _shopsNearMe = value;
  }

  void addToShopsNearMe(DocumentReference value) {
    shopsNearMe.add(value);
  }

  void removeFromShopsNearMe(DocumentReference value) {
    shopsNearMe.remove(value);
  }

  void removeAtIndexFromShopsNearMe(int index) {
    shopsNearMe.removeAt(index);
  }

  void updateShopsNearMeAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    shopsNearMe[index] = updateFn(_shopsNearMe[index]);
  }

  void insertAtIndexInShopsNearMe(int index, DocumentReference value) {
    shopsNearMe.insert(index, value);
  }

  List<DocumentReference> _lessonsNearMe = [];
  List<DocumentReference> get lessonsNearMe => _lessonsNearMe;
  set lessonsNearMe(List<DocumentReference> value) {
    _lessonsNearMe = value;
  }

  void addToLessonsNearMe(DocumentReference value) {
    lessonsNearMe.add(value);
  }

  void removeFromLessonsNearMe(DocumentReference value) {
    lessonsNearMe.remove(value);
  }

  void removeAtIndexFromLessonsNearMe(int index) {
    lessonsNearMe.removeAt(index);
  }

  void updateLessonsNearMeAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    lessonsNearMe[index] = updateFn(_lessonsNearMe[index]);
  }

  void insertAtIndexInLessonsNearMe(int index, DocumentReference value) {
    lessonsNearMe.insert(index, value);
  }

  LatLng? _currentSeachedArea;
  LatLng? get currentSeachedArea => _currentSeachedArea;
  set currentSeachedArea(LatLng? value) {
    _currentSeachedArea = value;
  }

  bool _mapLoading = false;
  bool get mapLoading => _mapLoading;
  set mapLoading(bool value) {
    _mapLoading = value;
  }

  bool _placePrefChanged = false;
  bool get placePrefChanged => _placePrefChanged;
  set placePrefChanged(bool value) {
    _placePrefChanged = value;
  }

  LatLng? _zoomToNoLoad;
  LatLng? get zoomToNoLoad => _zoomToNoLoad;
  set zoomToNoLoad(LatLng? value) {
    _zoomToNoLoad = value;
  }

  double _zoomLevel = 0.0;
  double get zoomLevel => _zoomLevel;
  set zoomLevel(double value) {
    _zoomLevel = value;
  }

  bool _setBounds = false;
  bool get setBounds => _setBounds;
  set setBounds(bool value) {
    _setBounds = value;
  }

  List<DocumentReference> _currentPlacesInArea = [];
  List<DocumentReference> get currentPlacesInArea => _currentPlacesInArea;
  set currentPlacesInArea(List<DocumentReference> value) {
    _currentPlacesInArea = value;
  }

  void addToCurrentPlacesInArea(DocumentReference value) {
    currentPlacesInArea.add(value);
  }

  void removeFromCurrentPlacesInArea(DocumentReference value) {
    currentPlacesInArea.remove(value);
  }

  void removeAtIndexFromCurrentPlacesInArea(int index) {
    currentPlacesInArea.removeAt(index);
  }

  void updateCurrentPlacesInAreaAtIndex(
    int index,
    DocumentReference Function(DocumentReference) updateFn,
  ) {
    currentPlacesInArea[index] = updateFn(_currentPlacesInArea[index]);
  }

  void insertAtIndexInCurrentPlacesInArea(int index, DocumentReference value) {
    currentPlacesInArea.insert(index, value);
  }

  bool _mapFilterActivated = false;
  bool get mapFilterActivated => _mapFilterActivated;
  set mapFilterActivated(bool value) {
    _mapFilterActivated = value;
  }

  List<String> _placesFound = [];
  List<String> get placesFound => _placesFound;
  set placesFound(List<String> value) {
    _placesFound = value;
  }

  void addToPlacesFound(String value) {
    placesFound.add(value);
  }

  void removeFromPlacesFound(String value) {
    placesFound.remove(value);
  }

  void removeAtIndexFromPlacesFound(int index) {
    placesFound.removeAt(index);
  }

  void updatePlacesFoundAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    placesFound[index] = updateFn(_placesFound[index]);
  }

  void insertAtIndexInPlacesFound(int index, String value) {
    placesFound.insert(index, value);
  }

  String _mapSearchText = '';
  String get mapSearchText => _mapSearchText;
  set mapSearchText(String value) {
    _mapSearchText = value;
  }

  List<LatLng> _placesFoundCoordinates = [];
  List<LatLng> get placesFoundCoordinates => _placesFoundCoordinates;
  set placesFoundCoordinates(List<LatLng> value) {
    _placesFoundCoordinates = value;
  }

  void addToPlacesFoundCoordinates(LatLng value) {
    placesFoundCoordinates.add(value);
  }

  void removeFromPlacesFoundCoordinates(LatLng value) {
    placesFoundCoordinates.remove(value);
  }

  void removeAtIndexFromPlacesFoundCoordinates(int index) {
    placesFoundCoordinates.removeAt(index);
  }

  void updatePlacesFoundCoordinatesAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    placesFoundCoordinates[index] = updateFn(_placesFoundCoordinates[index]);
  }

  void insertAtIndexInPlacesFoundCoordinates(int index, LatLng value) {
    placesFoundCoordinates.insert(index, value);
  }

  LatLng? _zoomToSwipe;
  LatLng? get zoomToSwipe => _zoomToSwipe;
  set zoomToSwipe(LatLng? value) {
    _zoomToSwipe = value;
  }

  int _scrolledToPlaceIndex = -1;
  int get scrolledToPlaceIndex => _scrolledToPlaceIndex;
  set scrolledToPlaceIndex(int value) {
    _scrolledToPlaceIndex = value;
  }

  bool _rebuildMap = false;
  bool get rebuildMap => _rebuildMap;
  set rebuildMap(bool value) {
    _rebuildMap = value;
  }

  bool _mapSheetOpen = false;
  bool get mapSheetOpen => _mapSheetOpen;
  set mapSheetOpen(bool value) {
    _mapSheetOpen = value;
  }

  List<LatLng> _selectedLocationFromSelector = [];
  List<LatLng> get selectedLocationFromSelector =>
      _selectedLocationFromSelector;
  set selectedLocationFromSelector(List<LatLng> value) {
    _selectedLocationFromSelector = value;
  }

  void addToSelectedLocationFromSelector(LatLng value) {
    selectedLocationFromSelector.add(value);
  }

  void removeFromSelectedLocationFromSelector(LatLng value) {
    selectedLocationFromSelector.remove(value);
  }

  void removeAtIndexFromSelectedLocationFromSelector(int index) {
    selectedLocationFromSelector.removeAt(index);
  }

  void updateSelectedLocationFromSelectorAtIndex(
    int index,
    LatLng Function(LatLng) updateFn,
  ) {
    selectedLocationFromSelector[index] =
        updateFn(_selectedLocationFromSelector[index]);
  }

  void insertAtIndexInSelectedLocationFromSelector(int index, LatLng value) {
    selectedLocationFromSelector.insert(index, value);
  }

  LocationInfoStruct _selectedLocation = LocationInfoStruct();
  LocationInfoStruct get selectedLocation => _selectedLocation;
  set selectedLocation(LocationInfoStruct value) {
    _selectedLocation = value;
  }

  void updateSelectedLocationStruct(Function(LocationInfoStruct) updateFn) {
    updateFn(_selectedLocation);
  }

  final _allPlacesCacheManager = StreamRequestManager<List<PlacesRecord>>();
  Stream<List<PlacesRecord>> allPlacesCache({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<List<PlacesRecord>> Function() requestFn,
  }) =>
      _allPlacesCacheManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearAllPlacesCacheCache() => _allPlacesCacheManager.clear();
  void clearAllPlacesCacheCacheKey(String? uniqueKey) =>
      _allPlacesCacheManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
