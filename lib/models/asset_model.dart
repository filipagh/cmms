class AssetModel {
  late String id;
  late String name;
  late String text;

  AssetModel(this.id,[this.name = "name", this.text = "text"]);
}



List<AssetModel> dummyAssets = [AssetModel("1"), AssetModel("2")];

AssetModel? getDummyRoadSegmentsById(String id) {
  var i = dummyAssets.where((element) => element.id == id);
  if (i.isEmpty) {
    return null;
  }
  return i.first;
}
