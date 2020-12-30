// @dart=2.9

// To parse this JSON data, do
//
//     final resultLoadPageChunk = resultLoadPageChunkFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'notion_api.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.result,
    this.recordMap,
  });

  final Result result;
  final RecordMap recordMap;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        recordMap: json["recordMap"] == null
            ? null
            : RecordMap.fromJson(json["recordMap"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result.toJson(),
        "recordMap": recordMap == null ? null : recordMap.toJson(),
      };
}

class RecordMap {
  RecordMap({
    this.collection,
    this.collectionView,
    this.block,
    this.space,
  });

  final Collection collection;
  final CollectionView collectionView;
  final Block block;
  final Space space;

  factory RecordMap.fromJson(Map<String, dynamic> json) => RecordMap(
        collection: Collection.fromJson(json["collection"]),
        collectionView: CollectionView.fromJson(json["collection_view"]),
        block: Block.fromJson(json["block"]),
        space: Space.fromJson(json["space"]),
      );

  Map<String, dynamic> toJson() => {
        "collection": collection.toJson(),
        "collection_view": collectionView.toJson(),
        "block": block.toJson(),
        "space": space.toJson(),
      };
}

class Block {
  final Map<String, BlockData> blockData;

  Block({this.blockData});

  factory Block.fromJson(Map<String, dynamic> json) {
    Map<String, BlockData> data = Map();

    json.entries.forEach((map) {
      data[map.key] = BlockData(
          role: map.value["role"],
          value: map.value["value"] == null
              ? null
              : Properties.fromJson(map.value["value"]));
    });
    return Block(blockData: data);
  }

  Map<String, dynamic> toJson() =>
      (blockData ?? {}).map((key, value) => MapEntry(key, value.toJson()));
}

class BlockData {
  final String role;
  final Properties value;

  BlockData({
    this.role,
    this.value,
  });

  factory BlockData.fromJson(Map<String, dynamic> json) => BlockData(
        role: json["role"],
        value:
            json["value"] == null ? null : Properties.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "value": value.toJson(),
      };
}

class Properties {
  Properties({
    this.id,
    this.version,
    this.type,
    this.properties,
    this.createdTime,
    this.lastEditedTime,
    this.parentId,
    this.parentTable,
    this.alive,
    this.createdByTable,
    this.createdById,
    this.lastEditedByTable,
    this.lastEditedById,
    this.shardId,
    this.spaceId,
    this.viewIds,
    this.collectionId,
    this.permissions,
  });

  final String id;
  final int version;
  final String type;
  final BlockProperties properties;
  final int createdTime;
  final int lastEditedTime;
  final String parentId;
  final String parentTable;
  final bool alive;
  final String createdByTable;
  final String createdById;
  final String lastEditedByTable;
  final String lastEditedById;
  final int shardId;
  final String spaceId;
  final List<String> viewIds;
  final String collectionId;
  final List<Permission> permissions;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        id: json["id"] == null ? null : json["id"],
        version: json["version"] == null ? null : json["version"],
        type: json["type"] == null ? null : json["type"],
        properties: json["properties"] == null
            ? null
            : BlockProperties.fromJson(json["properties"]),
        createdTime: json["created_time"] == null ? null : json["created_time"],
        lastEditedTime:
            json["last_edited_time"] == null ? null : json["last_edited_time"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        parentTable: json["parent_table"] == null ? null : json["parent_table"],
        alive: json["alive"] == null ? null : json["alive"],
        createdByTable:
            json["created_by_table"] == null ? null : json["created_by_table"],
        createdById:
            json["created_by_id"] == null ? null : json["created_by_id"],
        lastEditedByTable: json["last_edited_by_table"] == null
            ? null
            : json["last_edited_by_table"],
        lastEditedById: json["last_edited_by_id"] == null
            ? null
            : json["last_edited_by_id"],
        shardId: json["shard_id"] == null ? null : json["shard_id"],
        spaceId: json["space_id"] == null ? null : json["space_id"],
        viewIds: json["view_ids"] == null
            ? null
            : List<String>.from(json["view_ids"].map((x) => x)),
        collectionId:
            json["collection_id"] == null ? null : json["collection_id"],
        permissions: json["permissions"] == null
            ? null
            : List<Permission>.from(
                json["permissions"].map((x) => Permission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "type": type,
        "properties": properties == null ? null : properties.toJson(),
        "created_time": createdTime,
        "last_edited_time": lastEditedTime,
        "parent_id": parentId,
        "parent_table": parentTable,
        "alive": alive,
        "created_by_table": createdByTable,
        "created_by_id": createdById,
        "last_edited_by_table": lastEditedByTable,
        "last_edited_by_id": lastEditedById,
        "shard_id": shardId,
        "space_id": spaceId,
        "view_ids": List<dynamic>.from((viewIds ?? []).map((x) => x)),
        "collection_id": collectionId == null ? null : collectionId,
        "permissions": permissions == null
            ? null
            : List<dynamic>.from(permissions.map((x) => x.toJson())),
      };
}

class Permission {
  Permission({
    this.role,
    this.type,
    this.userId,
    this.allowDuplicate,
  });

  String role;
  String type;
  String userId;
  bool allowDuplicate;

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        role: json["role"],
        type: json["type"],
        userId: json["user_id"],
        allowDuplicate: json["allow_duplicate"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "type": type,
        "user_id": userId,
        "allow_duplicate": allowDuplicate,
      };
}

class BlockProperties {
  Map<String, List<dynamic>> blockProperties;

  BlockProperties({this.blockProperties});

  factory BlockProperties.fromJson(Map<String, dynamic> json) {
    Map<String, List<dynamic>> data = Map();
    json.forEach((key, value) {
      data[key] = value;
    });
    return BlockProperties(blockProperties: data);
  }

  Map<String, dynamic> toJson() => blockProperties ?? {};
}

class DateRange {
  DateRange({
    this.type,
    this.endDate,
    this.startDate,
  });

  String type;
  DateTime endDate;
  DateTime startDate;

  factory DateRange.fromJson(Map<String, dynamic> json) => DateRange(
        type: json["type"],
        endDate: DateTime.parse(json["end_date"]),
        startDate: DateTime.parse(json["start_date"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "end_date": endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_date": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      };
}

class Collection {
  final Map<String, CollectionData> collectionData;

  Collection({
    this.collectionData,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    Map<String, CollectionData> data = Map();

    json.entries.forEach((map) {
      data[map.key] = CollectionData(
          role: map.value["role"],
          value: map.value["value"] == null
              ? null
              : CollectionDataProperties.fromJson(map.value["value"]));
    });

    return Collection(collectionData: data);
  }

  Map<String, dynamic> toJson() =>
      collectionData.map((key, value) => MapEntry(key, value.toJson()));
}

class CollectionData {
  CollectionData({
    this.role,
    this.value,
  });

  String role;
  CollectionDataProperties value;

  factory CollectionData.fromJson(Map<String, dynamic> json) => CollectionData(
        role: json["role"],
        value: CollectionDataProperties.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "value": value == null ? null : value.toJson(),
      };
}

class CollectionDataProperties {
  CollectionDataProperties({
    this.id,
    this.version,
    this.name,
    this.schema,
    this.parentId,
    this.parentTable,
    this.alive,
    this.migrated,
  });

  String id;
  int version;
  List<List<String>> name;
  Schema schema;
  String parentId;
  String parentTable;
  bool alive;
  bool migrated;

  factory CollectionDataProperties.fromJson(Map<String, dynamic> json) =>
      CollectionDataProperties(
        id: json["id"],
        version: json["version"],
        name: List<List<String>>.from(
            json["name"].map((x) => List<String>.from(x.map((x) => x)))),
        schema: Schema.fromJson(json["schema"]),
        parentId: json["parent_id"],
        parentTable: json["parent_table"],
        alive: json["alive"],
        migrated: json["migrated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "name": List<dynamic>.from((name ?? [])
            .map((x) => List<dynamic>.from((x ?? []).map((x) => x)))),
        "schema": schema.toJson(),
        "parent_id": parentId,
        "parent_table": parentTable,
        "alive": alive,
        "migrated": migrated,
      };
}

class Schema {
  Schema({this.schemaData});

  final Map<String, SchemaData> schemaData;

  factory Schema.fromJson(Map<String, dynamic> json) {
    Map<String, SchemaData> data = Map();
    json.entries.forEach((map) {
      List<dynamic> list =
          map.value['options'] == null ? [] : map.value['options'];
      data[map.key] = SchemaData(
          name: map.value["name"],
          type: map.value["type"],
          property: map.value["property"],
          options: list
              .map((e) =>
                  Option(id: e['id'], color: e['color'], value: e['value']))
              .toList(),
          collectionId: map.value['collection_id']);
    });

    return Schema(schemaData: data);
  }

  Map<String, dynamic> toJson() =>
      schemaData.map((key, value) => MapEntry(key, value.toJson()));
}

class Option {
  Option({
    this.id,
    this.color,
    this.value,
  });

  String id;
  String color;
  String value;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        color: json["color"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "color": color,
        "value": value,
      };
}

class SchemaData {
  SchemaData({
    this.name,
    this.type,
    this.property,
    this.options,
    this.collectionId,
  });

  String name;
  String type;
  String property;
  String collectionId;
  List<Option> options;

  factory SchemaData.fromJson(Map<String, dynamic> json) => SchemaData(
        name: json["name"],
        type: json["type"],
        property: json["property"],
        collectionId: json["collection_id"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "property": property,
        "collection_id": collectionId,
        "options": options.map((e) => e.toJson())
      };
}

class CollectionView {
  final Map<String, CollectionViewData> collectionViewData;

  CollectionView({
    this.collectionViewData,
  });

  factory CollectionView.fromJson(Map<String, dynamic> json) {
    Map<String, CollectionViewData> data = Map();
    json.entries.forEach((map) {
      data[map.key] = CollectionViewData(
          role: map.value["role"],
          value: CollectionViewDataValue(
            id: map.value["id"],
            version: map.value["version"],
            type: map.value["type"],
            name: map.value["name"],
            format: map.value["format"] == null
                ? null
                : Format.fromJson(map.value["format"]),
            parentId: map.value["parent_id"],
            parentTable: map.value["parent_table"],
            alive: map.value["alive"],
            pageSort: map.value["page_sort"] == null
                ? null
                : List<String>.from(map.value["page_sort"].map((x) => x)),
            query2: map.value["query2"] == null
                ? null
                : Query2.fromJson(map.value["query2"]),
            shardId: map.value["shard_id"],
            spaceId: map.value["space_id"],
          ));
    });
    return CollectionView(collectionViewData: data);
  }

  Map<String, dynamic> toJson() =>
      collectionViewData.map((key, value) => MapEntry(key, value.toJson()));
}

class CollectionViewData {
  CollectionViewData({
    this.role,
    this.value,
  });

  String role;
  CollectionViewDataValue value;

  factory CollectionViewData.fromJson(Map<String, dynamic> json) =>
      CollectionViewData(
        role: json["role"],
        value: CollectionViewDataValue.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "value": value.toJson(),
      };
}

class CollectionViewDataValue {
  CollectionViewDataValue({
    this.id,
    this.version,
    this.type,
    this.name,
    this.format,
    this.parentId,
    this.parentTable,
    this.alive,
    this.pageSort,
    this.query2,
    this.shardId,
    this.spaceId,
  });

  String id;
  int version;
  String type;
  String name;
  Format format;
  String parentId;
  String parentTable;
  bool alive;
  List<String> pageSort;
  Query2 query2;
  int shardId;
  String spaceId;

  factory CollectionViewDataValue.fromJson(Map<String, dynamic> json) =>
      CollectionViewDataValue(
        id: json["id"],
        version: json["version"],
        type: json["type"],
        name: json["name"],
        format: Format.fromJson(json["format"]),
        parentId: json["parent_id"],
        parentTable: json["parent_table"],
        alive: json["alive"],
        pageSort: List<String>.from(json["page_sort"].map((x) => x)),
        query2: Query2.fromJson(json["query2"]),
        shardId: json["shard_id"],
        spaceId: json["space_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "type": type,
        "name": name,
        "format": format == null ? null : format.toJson(),
        "parent_id": parentId,
        "parent_table": parentTable,
        "alive": alive,
        "page_sort": pageSort == null
            ? null
            : List<dynamic>.from(pageSort.map((x) => x)),
        "query2": query2 == null ? null : query2.toJson(),
        "shard_id": shardId,
        "space_id": spaceId,
      };
}

class Format {
  Format({
    this.tableWrap,
    this.tableProperties,
  });

  bool tableWrap;
  List<TableProperty> tableProperties;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        tableWrap: json["table_wrap"],
        tableProperties: List<TableProperty>.from(
            json["table_properties"].map((x) => TableProperty.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "table_wrap": tableWrap,
        "table_properties":
            List<dynamic>.from(tableProperties.map((x) => x.toJson())),
      };
}

class TableProperty {
  TableProperty({
    this.width,
    this.visible,
    this.property,
  });

  int width;
  bool visible;
  String property;

  factory TableProperty.fromJson(Map<String, dynamic> json) => TableProperty(
        width: json["width"] == null ? null : json["width"],
        visible: json["visible"],
        property: json["property"],
      );

  Map<String, dynamic> toJson() => {
        "width": width == null ? null : width,
        "visible": visible,
        "property": property,
      };
}

class Query2 {
  Query2({
    this.sort,
    this.aggregations,
  });

  List<Sort> sort;
  List<Aggregation> aggregations;

  factory Query2.fromJson(Map<String, dynamic> json) => Query2(
        sort: json["sort"] == null
            ? null
            : List<Sort>.from(json["sort"].map((x) => Sort.fromJson(x))),
        aggregations: List<Aggregation>.from(
            json["aggregations"].map((x) => Aggregation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sort": List<dynamic>.from(sort.map((x) => x.toJson())),
        "aggregations": List<dynamic>.from(aggregations.map((x) => x.toJson())),
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

class Space {
  final Map<String, SpaceData> spaceData;

  Space({
    this.spaceData,
  });

  factory Space.fromJson(Map<String, dynamic> json) {
    Map<String, SpaceData> data = Map();

    json.entries.forEach((map) {
      data[map.key] = SpaceData(role: map.value["role"]);
    });

    return Space(spaceData: data);
  }

  Map<String, dynamic> toJson() => spaceData;
}

class SpaceData {
  SpaceData({
    this.role,
  });

  String role;

  factory SpaceData.fromJson(Map<String, dynamic> json) => SpaceData(
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
      };
}

class Result {
  Result({
    this.type,
    this.blockIds,
    this.aggregationResults,
    this.total,
  });

  String type;
  List<String> blockIds;
  List<AggregationResult> aggregationResults;
  int total;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        type: json["type"],
        blockIds: json["blockIds"] == null
            ? null
            : List<String>.from(json["blockIds"].map((x) => x)),
        aggregationResults: List<AggregationResult>.from(
            json["aggregationResults"]
                .map((x) => AggregationResult.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "blockIds": List<dynamic>.from(blockIds.map((x) => x)),
        "aggregationResults":
            List<dynamic>.from(aggregationResults.map((x) => x.toJson())),
        "total": total,
      };
}

class AggregationResult {
  AggregationResult({
    this.type,
    this.value,
  });

  String type;
  int value;

  factory AggregationResult.fromJson(Map<String, dynamic> json) =>
      AggregationResult(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
