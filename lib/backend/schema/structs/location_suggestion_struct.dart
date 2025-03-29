// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LocationSuggestionStruct extends FFFirebaseStruct {
  LocationSuggestionStruct({
    String? name,
    String? mapboxId,
    String? placeFormatted,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _mapboxId = mapboxId,
        _placeFormatted = placeFormatted,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "mapbox_id" field.
  String? _mapboxId;
  String get mapboxId => _mapboxId ?? '';
  set mapboxId(String? val) => _mapboxId = val;

  bool hasMapboxId() => _mapboxId != null;

  // "place_formatted" field.
  String? _placeFormatted;
  String get placeFormatted => _placeFormatted ?? '';
  set placeFormatted(String? val) => _placeFormatted = val;

  bool hasPlaceFormatted() => _placeFormatted != null;

  static LocationSuggestionStruct fromMap(Map<String, dynamic> data) =>
      LocationSuggestionStruct(
        name: data['name'] as String?,
        mapboxId: data['mapbox_id'] as String?,
        placeFormatted: data['place_formatted'] as String?,
      );

  static LocationSuggestionStruct? maybeFromMap(dynamic data) => data is Map
      ? LocationSuggestionStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'mapbox_id': _mapboxId,
        'place_formatted': _placeFormatted,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'mapbox_id': serializeParam(
          _mapboxId,
          ParamType.String,
        ),
        'place_formatted': serializeParam(
          _placeFormatted,
          ParamType.String,
        ),
      }.withoutNulls;

  static LocationSuggestionStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      LocationSuggestionStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        mapboxId: deserializeParam(
          data['mapbox_id'],
          ParamType.String,
          false,
        ),
        placeFormatted: deserializeParam(
          data['place_formatted'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LocationSuggestionStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LocationSuggestionStruct &&
        name == other.name &&
        mapboxId == other.mapboxId &&
        placeFormatted == other.placeFormatted;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, mapboxId, placeFormatted]);
}

LocationSuggestionStruct createLocationSuggestionStruct({
  String? name,
  String? mapboxId,
  String? placeFormatted,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LocationSuggestionStruct(
      name: name,
      mapboxId: mapboxId,
      placeFormatted: placeFormatted,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LocationSuggestionStruct? updateLocationSuggestionStruct(
  LocationSuggestionStruct? locationSuggestion, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    locationSuggestion
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLocationSuggestionStructData(
  Map<String, dynamic> firestoreData,
  LocationSuggestionStruct? locationSuggestion,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (locationSuggestion == null) {
    return;
  }
  if (locationSuggestion.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && locationSuggestion.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final locationSuggestionData =
      getLocationSuggestionFirestoreData(locationSuggestion, forFieldValue);
  final nestedData =
      locationSuggestionData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields =
      locationSuggestion.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLocationSuggestionFirestoreData(
  LocationSuggestionStruct? locationSuggestion, [
  bool forFieldValue = false,
]) {
  if (locationSuggestion == null) {
    return {};
  }
  final firestoreData = mapToFirestore(locationSuggestion.toMap());

  // Add any Firestore field values
  locationSuggestion.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLocationSuggestionListFirestoreData(
  List<LocationSuggestionStruct>? locationSuggestions,
) =>
    locationSuggestions
        ?.map((e) => getLocationSuggestionFirestoreData(e, true))
        .toList() ??
    [];
