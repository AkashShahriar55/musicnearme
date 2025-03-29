// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// for fetching different location info
class LocationInfoStruct extends FFFirebaseStruct {
  LocationInfoStruct({
    /// this is latitude and longitude of the selected location
    LatLongDataStruct? latlng,

    /// this is full address of the location
    String? address,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _latlng = latlng,
        _address = address,
        super(firestoreUtilData);

  // "latlng" field.
  LatLongDataStruct? _latlng;
  LatLongDataStruct get latlng => _latlng ?? LatLongDataStruct();
  set latlng(LatLongDataStruct? val) => _latlng = val;

  void updateLatlng(Function(LatLongDataStruct) updateFn) {
    updateFn(_latlng ??= LatLongDataStruct());
  }

  bool hasLatlng() => _latlng != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  set address(String? val) => _address = val;

  bool hasAddress() => _address != null;

  static LocationInfoStruct fromMap(Map<String, dynamic> data) =>
      LocationInfoStruct(
        latlng: data['latlng'] is LatLongDataStruct
            ? data['latlng']
            : LatLongDataStruct.maybeFromMap(data['latlng']),
        address: data['address'] as String?,
      );

  static LocationInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? LocationInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'latlng': _latlng?.toMap(),
        'address': _address,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'latlng': serializeParam(
          _latlng,
          ParamType.DataStruct,
        ),
        'address': serializeParam(
          _address,
          ParamType.String,
        ),
      }.withoutNulls;

  static LocationInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      LocationInfoStruct(
        latlng: deserializeStructParam(
          data['latlng'],
          ParamType.DataStruct,
          false,
          structBuilder: LatLongDataStruct.fromSerializableMap,
        ),
        address: deserializeParam(
          data['address'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LocationInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LocationInfoStruct &&
        latlng == other.latlng &&
        address == other.address;
  }

  @override
  int get hashCode => const ListEquality().hash([latlng, address]);
}

LocationInfoStruct createLocationInfoStruct({
  LatLongDataStruct? latlng,
  String? address,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LocationInfoStruct(
      latlng: latlng ?? (clearUnsetFields ? LatLongDataStruct() : null),
      address: address,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LocationInfoStruct? updateLocationInfoStruct(
  LocationInfoStruct? locationInfo, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    locationInfo
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLocationInfoStructData(
  Map<String, dynamic> firestoreData,
  LocationInfoStruct? locationInfo,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (locationInfo == null) {
    return;
  }
  if (locationInfo.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && locationInfo.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final locationInfoData =
      getLocationInfoFirestoreData(locationInfo, forFieldValue);
  final nestedData =
      locationInfoData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = locationInfo.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLocationInfoFirestoreData(
  LocationInfoStruct? locationInfo, [
  bool forFieldValue = false,
]) {
  if (locationInfo == null) {
    return {};
  }
  final firestoreData = mapToFirestore(locationInfo.toMap());

  // Handle nested data for "latlng" field.
  addLatLongDataStructData(
    firestoreData,
    locationInfo.hasLatlng() ? locationInfo.latlng : null,
    'latlng',
    forFieldValue,
  );

  // Add any Firestore field values
  locationInfo.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLocationInfoListFirestoreData(
  List<LocationInfoStruct>? locationInfos,
) =>
    locationInfos?.map((e) => getLocationInfoFirestoreData(e, true)).toList() ??
    [];
