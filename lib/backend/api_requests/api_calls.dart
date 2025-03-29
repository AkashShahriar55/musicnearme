import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ForwardGeocode';

class ForwardGeocodeCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? encodedQuery = '',
    String? encodedCoordinates = '',
    String? language = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Forward Geocode',
      apiUrl:
          'https://api.mapbox.com/search/geocode/v6/forward?q=${encodedQuery}&country=CA,US&proximity=${encodedCoordinates}&language=${language}&types=place&access_token=${token}',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? name(dynamic response) => (getJsonField(
        response,
        r'''$.features[:].properties.name_preferred''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? regionName(dynamic response) => (getJsonField(
        response,
        r'''$.features[:].properties.context.region.name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? regionCode2(dynamic response) => (getJsonField(
        response,
        r'''$.features[:].properties.context.region.region_code''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? regionCode3(dynamic response) => (getJsonField(
        response,
        r'''$.features[:].properties.context.country.country_code_alpha_3''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<double>? longitudes(dynamic response) => (getJsonField(
        response,
        r'''$.features[:].properties.coordinates.longitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<double>? latitudes(dynamic response) => (getJsonField(
        response,
        r'''$.features[:].properties.coordinates.latitude''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<double>(x))
          .withoutNulls
          .toList();
  static List<String>? fullAddress(dynamic response) => (getJsonField(
        response,
        r'''$.features[:].properties.full_address''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ReverseGeocodeCall {
  static Future<ApiCallResponse> call({
    double? longitude,
    double? latitude,
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Reverse Geocode',
      apiUrl: 'https://api.mapbox.com/search/geocode/v6/reverse',
      callType: ApiCallType.GET,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
      params: {
        'longitude': longitude,
        'latitude': latitude,
        'access_token': token,
        'types': "place",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? name(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.features[:].properties.name_preferred''',
      ));
  static String? regionCode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.features[:].properties.context.region.region_code''',
      ));
  static String? countryCode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.features[:].properties.context.country.country_code''',
      ));
  static String? fullAddress(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.features[:].properties.full_address''',
      ));
  static dynamic? currentLatLong(dynamic response) => getJsonField(
        response,
        r'''$.features[:].properties.coordinates''',
      );
  static String? currentMapBoxId(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.features[:].properties.mapbox_id''',
      ));
}

class LocationSuggestCall {
  static Future<ApiCallResponse> call({
    String? q = '',
    String? accessToken = '',
    String? sessionToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Location suggest',
      apiUrl:
          'https://api.mapbox.com/search/searchbox/v1/suggest?q=${q}&access_token=${accessToken}&session_token=${sessionToken}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<LocationSuggestionStruct>? suggestionMap(dynamic response) =>
      (getJsonField(
        response,
        r'''$.suggestions''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => LocationSuggestionStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class LocationRetreiveCall {
  static Future<ApiCallResponse> call({
    String? id = '',
    String? sessionToken = '',
    String? accessToken = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Location retreive',
      apiUrl:
          'https://api.mapbox.com/search/searchbox/v1/retrieve/${id}?session_token=${sessionToken}&access_token=${accessToken}',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static LatLongDataStruct? locationlatlong(dynamic response) =>
      LatLongDataStruct.maybeFromMap(getJsonField(
        response,
        r'''$.features[:].properties.coordinates''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
