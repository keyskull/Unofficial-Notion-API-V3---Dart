// @dart=2.9
// To parse this JSON data, do
//
//     final loadPageChunk = loadPageChunkFromJson(jsonString);

import 'dart:convert';

LoadPageChunk loadPageChunkFromJson(String str) => LoadPageChunk.fromJson(json.decode(str));

String loadPageChunkToJson(LoadPageChunk data) => json.encode(data.toJson());

class LoadPageChunk {
  LoadPageChunk({
    this.pageId,
    this.limit,
    this.cursor,
    this.chunkNumber,
    this.verticalColumns,
  });

  final String pageId;
  final int limit;
  final Cursor cursor;
  final int chunkNumber;
  final bool verticalColumns;

  factory LoadPageChunk.fromJson(Map<String, dynamic> json) => LoadPageChunk(
    pageId: json["pageId"] == null ? null : json["pageId"],
    limit: json["limit"] == null ? null : json["limit"],
    cursor: json["cursor"] == null ? null : Cursor.fromJson(json["cursor"]),
    chunkNumber: json["chunkNumber"] == null ? null : json["chunkNumber"],
    verticalColumns: json["verticalColumns"] == null ? null : json["verticalColumns"],
  );

  Map<String, dynamic> toJson() => {
    "pageId": pageId == null ? null : pageId,
    "limit": limit == null ? null : limit,
    "cursor": cursor == null ? null : cursor.toJson(),
    "chunkNumber": chunkNumber == null ? null : chunkNumber,
    "verticalColumns": verticalColumns == null ? null : verticalColumns,
  };
}

class Cursor {
  Cursor({
    this.stack,
  });

  final List<List<Stack>> stack;

  factory Cursor.fromJson(Map<String, dynamic> json) => Cursor(
    stack: json["stack"] == null ? null : List<List<Stack>>.from(json["stack"].map((x) => List<Stack>.from(x.map((x) => Stack.fromJson(x))))),
  );

  Map<String, dynamic> toJson() => {
    "stack": stack == null ? null : List<dynamic>.from(stack.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
  };
}

class Stack {
  Stack({
    this.table,
    this.id,
    this.index,
  });

  final String table;
  final String id;
  final int index;

  factory Stack.fromJson(Map<String, dynamic> json) => Stack(
    table: json["table"] == null ? null : json["table"],
    id: json["id"] == null ? null : json["id"],
    index: json["index"] == null ? null : json["index"],
  );

  Map<String, dynamic> toJson() => {
    "table": table == null ? null : table,
    "id": id == null ? null : id,
    "index": index == null ? null : index,
  };
}
