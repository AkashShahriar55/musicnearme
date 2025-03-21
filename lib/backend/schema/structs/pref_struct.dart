// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PrefStruct extends FFFirebaseStruct {
  PrefStruct({
    String? name,
    bool? value,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _value = value,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "value" field.
  bool? _value;
  bool get value => _value ?? false;
  set value(bool? val) => _value = val;

  bool hasValue() => _value != null;

  static PrefStruct fromMap(Map<String, dynamic> data) => PrefStruct(
        name: data['name'] as String?,
        value: data['value'] as bool?,
      );

  static PrefStruct? maybeFromMap(dynamic data) =>
      data is Map ? PrefStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'value': _value,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.bool,
        ),
      }.withoutNulls;

  static PrefStruct fromSerializableMap(Map<String, dynamic> data) =>
      PrefStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'PrefStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PrefStruct && name == other.name && value == other.value;
  }

  @override
  int get hashCode => const ListEquality().hash([name, value]);
}

PrefStruct createPrefStruct({
  String? name,
  bool? value,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PrefStruct(
      name: name,
      value: value,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PrefStruct? updatePrefStruct(
  PrefStruct? pref, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    pref
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPrefStructData(
  Map<String, dynamic> firestoreData,
  PrefStruct? pref,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (pref == null) {
    return;
  }
  if (pref.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields = !forFieldValue && pref.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final prefData = getPrefFirestoreData(pref, forFieldValue);
  final nestedData = prefData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = pref.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPrefFirestoreData(
  PrefStruct? pref, [
  bool forFieldValue = false,
]) {
  if (pref == null) {
    return {};
  }
  final firestoreData = mapToFirestore(pref.toMap());

  // Add any Firestore field values
  pref.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPrefListFirestoreData(
  List<PrefStruct>? prefs,
) =>
    prefs?.map((e) => getPrefFirestoreData(e, true)).toList() ?? [];
