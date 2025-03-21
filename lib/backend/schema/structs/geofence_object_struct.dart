// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GeofenceObjectStruct extends FFFirebaseStruct {
  GeofenceObjectStruct({
    String? name,
    DocumentReference? placeRef,
    String? message,
    String? messageImg,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _placeRef = placeRef,
        _message = message,
        _messageImg = messageImg,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "placeRef" field.
  DocumentReference? _placeRef;
  DocumentReference? get placeRef => _placeRef;
  set placeRef(DocumentReference? val) => _placeRef = val;

  bool hasPlaceRef() => _placeRef != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  set message(String? val) => _message = val;

  bool hasMessage() => _message != null;

  // "messageImg" field.
  String? _messageImg;
  String get messageImg => _messageImg ?? '';
  set messageImg(String? val) => _messageImg = val;

  bool hasMessageImg() => _messageImg != null;

  static GeofenceObjectStruct fromMap(Map<String, dynamic> data) =>
      GeofenceObjectStruct(
        name: data['name'] as String?,
        placeRef: data['placeRef'] as DocumentReference?,
        message: data['message'] as String?,
        messageImg: data['messageImg'] as String?,
      );

  static GeofenceObjectStruct? maybeFromMap(dynamic data) => data is Map
      ? GeofenceObjectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'placeRef': _placeRef,
        'message': _message,
        'messageImg': _messageImg,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'placeRef': serializeParam(
          _placeRef,
          ParamType.DocumentReference,
        ),
        'message': serializeParam(
          _message,
          ParamType.String,
        ),
        'messageImg': serializeParam(
          _messageImg,
          ParamType.String,
        ),
      }.withoutNulls;

  static GeofenceObjectStruct fromSerializableMap(Map<String, dynamic> data) =>
      GeofenceObjectStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        placeRef: deserializeParam(
          data['placeRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['places'],
        ),
        message: deserializeParam(
          data['message'],
          ParamType.String,
          false,
        ),
        messageImg: deserializeParam(
          data['messageImg'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GeofenceObjectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GeofenceObjectStruct &&
        name == other.name &&
        placeRef == other.placeRef &&
        message == other.message &&
        messageImg == other.messageImg;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([name, placeRef, message, messageImg]);
}

GeofenceObjectStruct createGeofenceObjectStruct({
  String? name,
  DocumentReference? placeRef,
  String? message,
  String? messageImg,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    GeofenceObjectStruct(
      name: name,
      placeRef: placeRef,
      message: message,
      messageImg: messageImg,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

GeofenceObjectStruct? updateGeofenceObjectStruct(
  GeofenceObjectStruct? geofenceObject, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    geofenceObject
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addGeofenceObjectStructData(
  Map<String, dynamic> firestoreData,
  GeofenceObjectStruct? geofenceObject,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (geofenceObject == null) {
    return;
  }
  if (geofenceObject.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && geofenceObject.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final geofenceObjectData =
      getGeofenceObjectFirestoreData(geofenceObject, forFieldValue);
  final nestedData =
      geofenceObjectData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = geofenceObject.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getGeofenceObjectFirestoreData(
  GeofenceObjectStruct? geofenceObject, [
  bool forFieldValue = false,
]) {
  if (geofenceObject == null) {
    return {};
  }
  final firestoreData = mapToFirestore(geofenceObject.toMap());

  // Add any Firestore field values
  geofenceObject.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getGeofenceObjectListFirestoreData(
  List<GeofenceObjectStruct>? geofenceObjects,
) =>
    geofenceObjects
        ?.map((e) => getGeofenceObjectFirestoreData(e, true))
        .toList() ??
    [];
