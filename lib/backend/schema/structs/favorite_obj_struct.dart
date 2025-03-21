// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class FavoriteObjStruct extends FFFirebaseStruct {
  FavoriteObjStruct({
    DocumentReference? placeRef,
    String? type,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _placeRef = placeRef,
        _type = type,
        super(firestoreUtilData);

  // "placeRef" field.
  DocumentReference? _placeRef;
  DocumentReference? get placeRef => _placeRef;
  set placeRef(DocumentReference? val) => _placeRef = val;

  bool hasPlaceRef() => _placeRef != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  static FavoriteObjStruct fromMap(Map<String, dynamic> data) =>
      FavoriteObjStruct(
        placeRef: data['placeRef'] as DocumentReference?,
        type: data['type'] as String?,
      );

  static FavoriteObjStruct? maybeFromMap(dynamic data) => data is Map
      ? FavoriteObjStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'placeRef': _placeRef,
        'type': _type,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'placeRef': serializeParam(
          _placeRef,
          ParamType.DocumentReference,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
      }.withoutNulls;

  static FavoriteObjStruct fromSerializableMap(Map<String, dynamic> data) =>
      FavoriteObjStruct(
        placeRef: deserializeParam(
          data['placeRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['places'],
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FavoriteObjStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FavoriteObjStruct &&
        placeRef == other.placeRef &&
        type == other.type;
  }

  @override
  int get hashCode => const ListEquality().hash([placeRef, type]);
}

FavoriteObjStruct createFavoriteObjStruct({
  DocumentReference? placeRef,
  String? type,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FavoriteObjStruct(
      placeRef: placeRef,
      type: type,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FavoriteObjStruct? updateFavoriteObjStruct(
  FavoriteObjStruct? favoriteObj, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    favoriteObj
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFavoriteObjStructData(
  Map<String, dynamic> firestoreData,
  FavoriteObjStruct? favoriteObj,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (favoriteObj == null) {
    return;
  }
  if (favoriteObj.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && favoriteObj.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final favoriteObjData =
      getFavoriteObjFirestoreData(favoriteObj, forFieldValue);
  final nestedData =
      favoriteObjData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = favoriteObj.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFavoriteObjFirestoreData(
  FavoriteObjStruct? favoriteObj, [
  bool forFieldValue = false,
]) {
  if (favoriteObj == null) {
    return {};
  }
  final firestoreData = mapToFirestore(favoriteObj.toMap());

  // Add any Firestore field values
  favoriteObj.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFavoriteObjListFirestoreData(
  List<FavoriteObjStruct>? favoriteObjs,
) =>
    favoriteObjs?.map((e) => getFavoriteObjFirestoreData(e, true)).toList() ??
    [];
