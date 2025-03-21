import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  bool hasDate() => _date != null;

  // "startTime" field.
  DateTime? _startTime;
  DateTime? get startTime => _startTime;
  bool hasStartTime() => _startTime != null;

  // "dateAsString" field.
  String? _dateAsString;
  String get dateAsString => _dateAsString ?? '';
  bool hasDateAsString() => _dateAsString != null;

  // "placeRef" field.
  DocumentReference? _placeRef;
  DocumentReference? get placeRef => _placeRef;
  bool hasPlaceRef() => _placeRef != null;

  // "placeType" field.
  String? _placeType;
  String get placeType => _placeType ?? '';
  bool hasPlaceType() => _placeType != null;

  // "coordinates" field.
  LatLng? _coordinates;
  LatLng? get coordinates => _coordinates;
  bool hasCoordinates() => _coordinates != null;

  // "markerIcon" field.
  String? _markerIcon;
  String get markerIcon => _markerIcon ?? '';
  bool hasMarkerIcon() => _markerIcon != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _image = snapshotData['image'] as String?;
    _date = snapshotData['date'] as DateTime?;
    _startTime = snapshotData['startTime'] as DateTime?;
    _dateAsString = snapshotData['dateAsString'] as String?;
    _placeRef = snapshotData['placeRef'] as DocumentReference?;
    _placeType = snapshotData['placeType'] as String?;
    _coordinates = snapshotData['coordinates'] as LatLng?;
    _markerIcon = snapshotData['markerIcon'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('events')
          : FirebaseFirestore.instance.collectionGroup('events');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('events').doc(id);

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  String? name,
  String? image,
  DateTime? date,
  DateTime? startTime,
  String? dateAsString,
  DocumentReference? placeRef,
  String? placeType,
  LatLng? coordinates,
  String? markerIcon,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'image': image,
      'date': date,
      'startTime': startTime,
      'dateAsString': dateAsString,
      'placeRef': placeRef,
      'placeType': placeType,
      'coordinates': coordinates,
      'markerIcon': markerIcon,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.image == e2?.image &&
        e1?.date == e2?.date &&
        e1?.startTime == e2?.startTime &&
        e1?.dateAsString == e2?.dateAsString &&
        e1?.placeRef == e2?.placeRef &&
        e1?.placeType == e2?.placeType &&
        e1?.coordinates == e2?.coordinates &&
        e1?.markerIcon == e2?.markerIcon;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.image,
        e?.date,
        e?.startTime,
        e?.dateAsString,
        e?.placeRef,
        e?.placeType,
        e?.coordinates,
        e?.markerIcon
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
