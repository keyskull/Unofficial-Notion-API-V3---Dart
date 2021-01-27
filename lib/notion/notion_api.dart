// @dart=2.9

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'response.dart';


class NotionApiAgent {
  static Future<Response> _call(String name, json) async => await _convert(http.post(
          "https://autumn-meadow-bdd9.cullen.workers.dev/cors/?apiurl=https://www.notion.so/api/v3/$name",
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json))
      .then((value) => Response.fromJson(jsonDecode(value)));

  static Future<String> _convert(Future<http.Response> response) async =>
      await response.then<String>((_response) {
        if (_response.statusCode == 200) {
          return _response.body;
        } else
          throw Exception(
              "Request failed with status: ${_response.statusCode}" +
                  _response.body);
      }, onError: (e) => throw Exception("$e"));

  static Future<Response> getActivityLog(dynamic json) async => await _call("getActivityLog", json);

  static Future<Response> getAssetsJson(dynamic json) async => await _call("getAssetsJson", json);

  static Future<Response> getRecordValues(dynamic json) async => await _call("getRecordValues", json);

  static Future<Response> getSnapshotsList(dynamic json) async => await _call("getSnapshotsList", json);

  static Future<Response> getUserSharedPages(dynamic json) async => await _call("getUserSharedPages", json);

  static Future<Response> loadPageChunk(dynamic json) async => await _call("loadPageChunk", json);

  static Future<Response> loadUserContent(dynamic json) async => await _call("loadUserContent", json);

  static Future<Response> queryCollection(dynamic json) async => await _call("queryCollection", json);

  static Future<Response> submitTransaction(dynamic json) async => await _call("submitTransaction", json);
}



class Sort {
  Sort({
    this.property,
    this.direction,
  });

  String property;
  String direction;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    property: json["property"],
    direction: json["direction"],
  );

  Map<String, dynamic> toJson() => {
    "property": property,
    "direction": direction,
  };
}

class Aggregation {
  Aggregation({
    this.property = "title",
    this.aggregator = "count",
  });

  String property;
  String aggregator;

  factory Aggregation.fromJson(Map<String, dynamic> json) => Aggregation(
    property: json["property"],
    aggregator: json["aggregator"],
  );

  Map<String, dynamic> toJson() => {
    "property": property,
    "aggregator": aggregator,
  };
}