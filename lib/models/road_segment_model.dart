class RoadSegmentModel {
  late String id;
  late String name;
  late String text;
  late String ssud;

  RoadSegmentModel(this.id,this.name,this.text,[this.ssud = "ssud"]);
}



List<RoadSegmentModel> dummyRoadSegments = [RoadSegmentModel("1","aaa", "text"), RoadSegmentModel("2","BBB", "text")];

RoadSegmentModel? getDummyRoadSegmentsById(String id) {
  var i = dummyRoadSegments.where((element) => element.id == id);
  if (i.isEmpty) {
    return null;
  }
  return i.first;
}
