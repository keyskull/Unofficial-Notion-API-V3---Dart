// @dart=2.9
// To parse this JSON data, do
//
//     final loadPageChunk = loadPageChunkFromJson(jsonString);

import 'dart:convert';

import 'notion_api.dart';


QueryCollection queryCollectionFromJson(String str) =>
    QueryCollection.fromJson(json.decode(str));

String queryCollectionToJson(QueryCollection data) => json.encode(data.toJson());

class QueryCollection {
  QueryCollection({
    this.collectionId,
    this.collectionViewId,
    this.query,
    this.loader,
  });

  String collectionId;
  String collectionViewId;
  Query query;
  Loader loader;

  factory QueryCollection.fromJson(Map<String, dynamic> json) => QueryCollection(
        collectionId: json["collectionId"],
        collectionViewId: json["collectionViewId"],
        query: Query.fromJson(json["query"]),
        loader: Loader.fromJson(json["loader"]),
      );

  Map<String, dynamic> toJson() => {
        "collectionId": collectionId,
        "collectionViewId": collectionViewId,
        "query" : query == null ? null : query.toJson(),
        "loader" : loader != null ? null : loader.toJson(),
      };
}

class Loader {
  Loader({
    this.type,
    this.limit,
    this.searchQuery,
    this.userTimeZone,
    this.loadContentCover,
  });

  String type;
  int limit;
  String searchQuery;
  String userTimeZone;
  bool loadContentCover;

  factory Loader.fromJson(Map<String, dynamic> json) => Loader(
        type: json["type"],
        limit: json["limit"],
        searchQuery: json["searchQuery"],
        userTimeZone: json["userTimeZone"],
        loadContentCover: json["loadContentCover"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "limit": limit,
        "searchQuery": searchQuery,
        "userTimeZone": userTimeZone,
        "loadContentCover": loadContentCover,
      };
}

class Query {
  Query({
    this.sort,
    this.aggregations,
  });

  List<Sort> sort;
  List<Aggregation> aggregations;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        sort: List<Sort>.from(json["sort"].map((x) => Sort.fromJson(x))),
        aggregations: List<Aggregation>.from(
            json["aggregations"].map((x) => Aggregation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sort": List<dynamic>.from((sort ?? []).map((x) => x.toJson())),
        "aggregations": List<dynamic>.from((aggregations ?? []).map((x) => x.toJson())),
      };
}

class Aggregation {
  Aggregation({
    this.property,
    this.aggregator,
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


