// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class EventObjStruct extends FFFirebaseStruct {
  EventObjStruct({
    bool? hasDate,
    DocumentReference? event,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _hasDate = hasDate,
        _event = event,
        super(firestoreUtilData);

  // "hasDate" field.
  bool? _hasDate;
  bool get hasDate => _hasDate ?? false;
  set hasDate(bool? val) => _hasDate = val;

  bool hasHasDate() => _hasDate != null;

  // "event" field.
  DocumentReference? _event;
  DocumentReference? get event => _event;
  set event(DocumentReference? val) => _event = val;

  bool hasEvent() => _event != null;

  static EventObjStruct fromMap(Map<String, dynamic> data) => EventObjStruct(
        hasDate: data['hasDate'] as bool?,
        event: data['event'] as DocumentReference?,
      );

  static EventObjStruct? maybeFromMap(dynamic data) =>
      data is Map ? EventObjStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'hasDate': _hasDate,
        'event': _event,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'hasDate': serializeParam(
          _hasDate,
          ParamType.bool,
        ),
        'event': serializeParam(
          _event,
          ParamType.DocumentReference,
        ),
      }.withoutNulls;

  static EventObjStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventObjStruct(
        hasDate: deserializeParam(
          data['hasDate'],
          ParamType.bool,
          false,
        ),
        event: deserializeParam(
          data['event'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['places', 'events'],
        ),
      );

  @override
  String toString() => 'EventObjStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EventObjStruct &&
        hasDate == other.hasDate &&
        event == other.event;
  }

  @override
  int get hashCode => const ListEquality().hash([hasDate, event]);
}

EventObjStruct createEventObjStruct({
  bool? hasDate,
  DocumentReference? event,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    EventObjStruct(
      hasDate: hasDate,
      event: event,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

EventObjStruct? updateEventObjStruct(
  EventObjStruct? eventObj, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    eventObj
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addEventObjStructData(
  Map<String, dynamic> firestoreData,
  EventObjStruct? eventObj,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (eventObj == null) {
    return;
  }
  if (eventObj.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && eventObj.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final eventObjData = getEventObjFirestoreData(eventObj, forFieldValue);
  final nestedData = eventObjData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = eventObj.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getEventObjFirestoreData(
  EventObjStruct? eventObj, [
  bool forFieldValue = false,
]) {
  if (eventObj == null) {
    return {};
  }
  final firestoreData = mapToFirestore(eventObj.toMap());

  // Add any Firestore field values
  eventObj.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getEventObjListFirestoreData(
  List<EventObjStruct>? eventObjs,
) =>
    eventObjs?.map((e) => getEventObjFirestoreData(e, true)).toList() ?? [];
