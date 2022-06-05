class RoadSegmentAssetConnectorModel {
  late String assetId;
  late String roadSegmentId;


  RoadSegmentAssetConnectorModel(this.assetId,this.roadSegmentId);
}



List<RoadSegmentAssetConnectorModel> dummyRoadAssetConnectorSegments = [RoadSegmentAssetConnectorModel("1","1"),RoadSegmentAssetConnectorModel("2","1"),];

RoadSegmentAssetConnectorModel? getDummyRoadAssetConnectorSegmentsByAssetId(String id) {
  var i = dummyRoadAssetConnectorSegments.where((element) => element.roadSegmentId == id);
  if (i.isEmpty) {
    return null;
  }
  return i.first;
}

List<String> getAssetsIdsByRoadSegmentId(String id) {
  List<String> l = [];
  var i = dummyRoadAssetConnectorSegments.where((element) => element.roadSegmentId == id);
  i.toList();
  for (var element in i) {l.add(element.assetId);}
  if (l.isEmpty) {
    return [];
  } else {
    return l;
  }
}
