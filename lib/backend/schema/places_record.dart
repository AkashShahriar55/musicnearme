import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlacesRecord extends FirestoreRecord {
  PlacesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "coordinates" field.
  LatLng? _coordinates;
  LatLng? get coordinates => _coordinates;
  bool hasCoordinates() => _coordinates != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  bool hasCreatedBy() => _createdBy != null;

  // "bannerImg" field.
  String? _bannerImg;
  String get bannerImg => _bannerImg ?? '';
  bool hasBannerImg() => _bannerImg != null;

  // "markerIcon" field.
  String? _markerIcon;
  String get markerIcon => _markerIcon ?? '';
  bool hasMarkerIcon() => _markerIcon != null;

  // "websiteLink" field.
  String? _websiteLink;
  String get websiteLink => _websiteLink ?? '';
  bool hasWebsiteLink() => _websiteLink != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "placeType" field.
  String? _placeType;
  String get placeType => _placeType ?? '';
  bool hasPlaceType() => _placeType != null;

  // "favoritedBy" field.
  List<DocumentReference>? _favoritedBy;
  List<DocumentReference> get favoritedBy => _favoritedBy ?? const [];
  bool hasFavoritedBy() => _favoritedBy != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "nameSplit" field.
  List<String>? _nameSplit;
  List<String> get nameSplit => _nameSplit ?? const [];
  bool hasNameSplit() => _nameSplit != null;

  // "currentAdvertisement" field.
  String? _currentAdvertisement;
  String get currentAdvertisement => _currentAdvertisement ?? '';
  bool hasCurrentAdvertisement() => _currentAdvertisement != null;

  // "currentAdvertisementImg" field.
  String? _currentAdvertisementImg;
  String get currentAdvertisementImg => _currentAdvertisementImg ?? '';
  bool hasCurrentAdvertisementImg() => _currentAdvertisementImg != null;

  // "contact" field.
  String? _contact;
  String get contact => _contact ?? '';
  bool hasContact() => _contact != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  void _initializeFields() {
    _coordinates = snapshotData['coordinates'] as LatLng?;
    _createdBy = snapshotData['createdBy'] as DocumentReference?;
    _bannerImg = snapshotData['bannerImg'] as String?;
    _markerIcon = snapshotData['markerIcon'] as String?;
    _websiteLink = snapshotData['websiteLink'] as String?;
    _name = snapshotData['name'] as String?;
    _location = snapshotData['location'] as String?;
    _placeType = snapshotData['placeType'] as String?;
    _favoritedBy = getDataList(snapshotData['favoritedBy']);
    _images = getDataList(snapshotData['images']);
    _description = snapshotData['description'] as String?;
    _nameSplit = getDataList(snapshotData['nameSplit']);
    _currentAdvertisement = snapshotData['currentAdvertisement'] as String?;
    _currentAdvertisementImg =
        snapshotData['currentAdvertisementImg'] as String?;
    _contact = snapshotData['contact'] as String?;
    _address = snapshotData['address'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('places');

  static Stream<PlacesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlacesRecord.fromSnapshot(s));

  static Future<PlacesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlacesRecord.fromSnapshot(s));

  static PlacesRecord fromSnapshot(DocumentSnapshot snapshot) => PlacesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlacesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlacesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlacesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlacesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlacesRecordData({
  LatLng? coordinates,
  DocumentReference? createdBy,
  String? bannerImg,
  String? markerIcon,
  String? websiteLink,
  String? name,
  String? location,
  String? placeType,
  String? description,
  String? currentAdvertisement,
  String? currentAdvertisementImg,
  String? contact,
  String? address,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'coordinates': coordinates,
      'createdBy': createdBy,
      'bannerImg': bannerImg,
      'markerIcon': markerIcon,
      'websiteLink': websiteLink,
      'name': name,
      'location': location,
      'placeType': placeType,
      'description': description,
      'currentAdvertisement': currentAdvertisement,
      'currentAdvertisementImg': currentAdvertisementImg,
      'contact': contact,
      'address': address,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlacesRecordDocumentEquality implements Equality<PlacesRecord> {
  const PlacesRecordDocumentEquality();

  @override
  bool equals(PlacesRecord? e1, PlacesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.coordinates == e2?.coordinates &&
        e1?.createdBy == e2?.createdBy &&
        e1?.bannerImg == e2?.bannerImg &&
        e1?.markerIcon == e2?.markerIcon &&
        e1?.websiteLink == e2?.websiteLink &&
        e1?.name == e2?.name &&
        e1?.location == e2?.location &&
        e1?.placeType == e2?.placeType &&
        listEquality.equals(e1?.favoritedBy, e2?.favoritedBy) &&
        listEquality.equals(e1?.images, e2?.images) &&
        e1?.description == e2?.description &&
        listEquality.equals(e1?.nameSplit, e2?.nameSplit) &&
        e1?.currentAdvertisement == e2?.currentAdvertisement &&
        e1?.currentAdvertisementImg == e2?.currentAdvertisementImg &&
        e1?.contact == e2?.contact &&
        e1?.address == e2?.address;
  }

  @override
  int hash(PlacesRecord? e) => const ListEquality().hash([
        e?.coordinates,
        e?.createdBy,
        e?.bannerImg,
        e?.markerIcon,
        e?.websiteLink,
        e?.name,
        e?.location,
        e?.placeType,
        e?.favoritedBy,
        e?.images,
        e?.description,
        e?.nameSplit,
        e?.currentAdvertisement,
        e?.currentAdvertisementImg,
        e?.contact,
        e?.address
      ]);

  @override
  bool isValidKey(Object? o) => o is PlacesRecord;
}
