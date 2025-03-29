// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LatLongDataStruct extends FFFirebaseStruct {
  LatLongDataStruct({
    double? latitude,
    double? longitude,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _latitude = latitude,
        _longitude = longitude,
        super(firestoreUtilData);

  // "latitude" field.
  double? _latitude;
  double get latitude => _latitude ?? 0.0;
  set latitude(double? val) => _latitude = val;

  void incrementLatitude(double amount) => latitude = latitude + amount;

  bool hasLatitude() => _latitude != null;

  // "longitude" field.
  double? _longitude;
  double get longitude => _longitude ?? 0.0;
  set longitude(double? val) => _longitude = val;

  void incrementLongitude(double amount) => longitude = longitude + amount;

  bool hasLongitude() => _longitude != null;

  static LatLongDataStruct fromMap(Map<String, dynamic> data) =>
      LatLongDataStruct(
        latitude: castToType<double>(data['latitude']),
        longitude: castToType<double>(data['longitude']),
      );

  static LatLongDataStruct? maybeFromMap(dynamic data) => data is Map
      ? LatLongDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'latitude': _latitude,
        'longitude': _longitude,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'latitude': serializeParam(
          _latitude,
          ParamType.double,
        ),
        'longitude': serializeParam(
          _longitude,
          ParamType.double,
        ),
      }.withoutNulls;

  static LatLongDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      LatLongDataStruct(
        latitude: deserializeParam(
          data['latitude'],
          ParamType.double,
          false,
        ),
        longitude: deserializeParam(
          data['longitude'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'LatLongDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LatLongDataStruct &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode => const ListEquality().hash([latitude, longitude]);
}

LatLongDataStruct createLatLongDataStruct({
  double? latitude,
  double? longitude,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LatLongDataStruct(
      latitude: latitude,
      longitude: longitude,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LatLongDataStruct? updateLatLongDataStruct(
  LatLongDataStruct? latLongData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    latLongData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLatLongDataStructData(
  Map<String, dynamic> firestoreData,
  LatLongDataStruct? latLongData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (latLongData == null) {
    return;
  }
  if (latLongData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && latLongData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final latLongDataData =
      getLatLongDataFirestoreData(latLongData, forFieldValue);
  final nestedData =
      latLongDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = latLongData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLatLongDataFirestoreData(
  LatLongDataStruct? latLongData, [
  bool forFieldValue = false,
]) {
  if (latLongData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(latLongData.toMap());

  // Add any Firestore field values
  latLongData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLatLongDataListFirestoreData(
  List<LatLongDataStruct>? latLongDatas,
) =>
    latLongDatas?.map((e) => getLatLongDataFirestoreData(e, true)).toList() ??
    [];
