import 'dart:convert';

import 'package:test/test.dart';

import '../lib/notion/notion_api.dart';

import '../lib/notion/load_page_chunk.dart';
import '../lib/notion/query_collection.dart';
import '../sample/constants.dart';


void main() {
  test('adds one to input values', () async {
    final queryCollectionInput = jsonEncode(QueryCollection(
        collectionId: PrivateConstants.collectionId,
        collectionViewId: PrivateConstants.collectionViewId,
        query: Query(
            sort: [Sort(property: "QglH", direction: "descending")],
            aggregations: [Aggregation(property: "title",aggregator: "count")]),
        loader: Loader(type: "table")));


    var loadPageChunk = jsonEncode(LoadPageChunk(
        pageId: PrivateConstants.pageId,
        limit: 50,
        chunkNumber: 0,
        verticalColumns: true));

    print(queryCollectionInput);
    final jsonResponse = await NotionApiAgent.queryCollection(queryCollectionInput);
    // print("$jsonResponse");
    final data = jsonResponse;
    final blockMap = data.recordMap.block.blockData;
    data.result.blockIds.forEach((element) {
      print(blockMap[element]!.value.properties.blockProperties.values);
    });

    data.recordMap.collectionView.collectionViewData.values.forEach((element) {
      print(element.value.toJson());
    });

    print((await NotionApiAgent.loadPageChunk(loadPageChunk)).toJson().toString());

    expect(() => "", throwsNoSuchMethodError);
  });
}
