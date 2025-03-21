// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PlaceDataStruct extends FFFirebaseStruct {
  PlaceDataStruct({
    LatLng? coordinates,
    DocumentReference? createdBy,
    String? bannerImg,
    String? markerIcon,
    String? websiteLink,
    String? name,
    DocumentReference? ref,
    String? location,
    String? placeType,
    int? index,
    String? description,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _coordinates = coordinates,
        _createdBy = createdBy,
        _bannerImg = bannerImg,
        _markerIcon = markerIcon,
        _websiteLink = websiteLink,
        _name = name,
        _ref = ref,
        _location = location,
        _placeType = placeType,
        _index = index,
        _description = description,
        super(firestoreUtilData);

  // "coordinates" field.
  LatLng? _coordinates;
  LatLng? get coordinates => _coordinates;
  set coordinates(LatLng? val) => _coordinates = val;

  bool hasCoordinates() => _coordinates != null;

  // "createdBy" field.
  DocumentReference? _createdBy;
  DocumentReference? get createdBy => _createdBy;
  set createdBy(DocumentReference? val) => _createdBy = val;

  bool hasCreatedBy() => _createdBy != null;

  // "bannerImg" field.
  String? _bannerImg;
  String get bannerImg => _bannerImg ?? '';
  set bannerImg(String? val) => _bannerImg = val;

  bool hasBannerImg() => _bannerImg != null;

  // "markerIcon" field.
  String? _markerIcon;
  String get markerIcon => _markerIcon ?? '';
  set markerIcon(String? val) => _markerIcon = val;

  bool hasMarkerIcon() => _markerIcon != null;

  // "websiteLink" field.
  String? _websiteLink;
  String get websiteLink => _websiteLink ?? '';
  set websiteLink(String? val) => _websiteLink = val;

  bool hasWebsiteLink() => _websiteLink != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "ref" field.
  DocumentReference? _ref;
  DocumentReference? get ref => _ref;
  set ref(DocumentReference? val) => _ref = val;

  bool hasRef() => _ref != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  // "placeType" field.
  String? _placeType;
  String get placeType => _placeType ?? '';
  set placeType(String? val) => _placeType = val;

  bool hasPlaceType() => _placeType != null;

  // "index" field.
  int? _index;
  int get index => _index ?? 0;
  set index(int? val) => _index = val;

  void incrementIndex(int amount) => index = index + amount;

  bool hasIndex() => _index != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  static PlaceDataStruct fromMap(Map<String, dynamic> data) => PlaceDataStruct(
        coordinates: data['coordinates'] as LatLng?,
        createdBy: data['createdBy'] as DocumentReference?,
        bannerImg: data['bannerImg'] as String?,
        markerIcon: data['markerIcon'] as String?,
        websiteLink: data['websiteLink'] as String?,
        name: data['name'] as String?,
        ref: data['ref'] as DocumentReference?,
        location: data['location'] as String?,
        placeType: data['placeType'] as String?,
        index: castToType<int>(data['index']),
        description: data['description'] as String?,
      );

  static PlaceDataStruct? maybeFromMap(dynamic data) => data is Map
      ? PlaceDataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'coordinates': _coordinates,
        'createdBy': _createdBy,
        'bannerImg': _bannerImg,
        'markerIcon': _markerIcon,
        'websiteLink': _websiteLink,
        'name': _name,
        'ref': _ref,
        'location': _location,
        'placeType': _placeType,
        'index': _index,
        'description': _description,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'coordinates': serializeParam(
          _coordinates,
          ParamType.LatLng,
        ),
        'createdBy': serializeParam(
          _createdBy,
          ParamType.DocumentReference,
        ),
        'bannerImg': serializeParam(
          _bannerImg,
          ParamType.String,
        ),
        'markerIcon': serializeParam(
          _markerIcon,
          ParamType.String,
        ),
        'websiteLink': serializeParam(
          _websiteLink,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'ref': serializeParam(
          _ref,
          ParamType.DocumentReference,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'placeType': serializeParam(
          _placeType,
          ParamType.String,
        ),
        'index': serializeParam(
          _index,
          ParamType.int,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
      }.withoutNulls;

  static PlaceDataStruct fromSerializableMap(Map<String, dynamic> data) =>
      PlaceDataStruct(
        coordinates: deserializeParam(
          data['coordinates'],
          ParamType.LatLng,
          false,
        ),
        createdBy: deserializeParam(
          data['createdBy'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        bannerImg: deserializeParam(
          data['bannerImg'],
          ParamType.String,
          false,
        ),
        markerIcon: deserializeParam(
          data['markerIcon'],
          ParamType.String,
          false,
        ),
        websiteLink: deserializeParam(
          data['websiteLink'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        ref: deserializeParam(
          data['ref'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['places'],
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        placeType: deserializeParam(
          data['placeType'],
          ParamType.String,
          false,
        ),
        index: deserializeParam(
          data['index'],
          ParamType.int,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PlaceDataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PlaceDataStruct &&
        coordinates == other.coordinates &&
        createdBy == other.createdBy &&
        bannerImg == other.bannerImg &&
        markerIcon == other.markerIcon &&
        websiteLink == other.websiteLink &&
        name == other.name &&
        ref == other.ref &&
        location == other.location &&
        placeType == other.placeType &&
        index == other.index &&
        description == other.description;
  }

  @override
  int get hashCode => const ListEquality().hash([
        coordinates,
        createdBy,
        bannerImg,
        markerIcon,
        websiteLink,
        name,
        ref,
        location,
        placeType,
        index,
        description
      ]);
}

PlaceDataStruct createPlaceDataStruct({
  LatLng? coordinates,
  DocumentReference? createdBy,
  String? bannerImg,
  String? markerIcon,
  String? websiteLink,
  String? name,
  DocumentReference? ref,
  String? location,
  String? placeType,
  int? index,
  String? description,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    PlaceDataStruct(
      coordinates: coordinates,
      createdBy: createdBy,
      bannerImg: bannerImg,
      markerIcon: markerIcon,
      websiteLink: websiteLink,
      name: name,
      ref: ref,
      location: location,
      placeType: placeType,
      index: index,
      description: description,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

PlaceDataStruct? updatePlaceDataStruct(
  PlaceDataStruct? placeData, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    placeData
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addPlaceDataStructData(
  Map<String, dynamic> firestoreData,
  PlaceDataStruct? placeData,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (placeData == null) {
    return;
  }
  if (placeData.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && placeData.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final placeDataData = getPlaceDataFirestoreData(placeData, forFieldValue);
  final nestedData = placeDataData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = placeData.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getPlaceDataFirestoreData(
  PlaceDataStruct? placeData, [
  bool forFieldValue = false,
]) {
  if (placeData == null) {
    return {};
  }
  final firestoreData = mapToFirestore(placeData.toMap());

  // Add any Firestore field values
  placeData.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getPlaceDataListFirestoreData(
  List<PlaceDataStruct>? placeDatas,
) =>
    placeDatas?.map((e) => getPlaceDataFirestoreData(e, true)).toList() ?? [];
