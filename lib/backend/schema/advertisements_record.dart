import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AdvertisementsRecord extends FirestoreRecord {
  AdvertisementsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  void _initializeFields() {
    _image = snapshotData['image'] as String?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('advertisements');

  static Stream<AdvertisementsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AdvertisementsRecord.fromSnapshot(s));

  static Future<AdvertisementsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AdvertisementsRecord.fromSnapshot(s));

  static AdvertisementsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AdvertisementsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AdvertisementsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AdvertisementsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AdvertisementsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AdvertisementsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAdvertisementsRecordData({
  String? image,
  String? title,
  String? description,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'image': image,
      'title': title,
      'description': description,
    }.withoutNulls,
  );

  return firestoreData;
}

class AdvertisementsRecordDocumentEquality
    implements Equality<AdvertisementsRecord> {
  const AdvertisementsRecordDocumentEquality();

  @override
  bool equals(AdvertisementsRecord? e1, AdvertisementsRecord? e2) {
    return e1?.image == e2?.image &&
        e1?.title == e2?.title &&
        e1?.description == e2?.description;
  }

  @override
  int hash(AdvertisementsRecord? e) =>
      const ListEquality().hash([e?.image, e?.title, e?.description]);

  @override
  bool isValidKey(Object? o) => o is AdvertisementsRecord;
}
