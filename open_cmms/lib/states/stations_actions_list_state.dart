import 'dart:core';

import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/action_hisotry_service.dart';

class StationsActionListState extends GetxController {
  late StationSchema _station;
  final RxList<ActionHistorySchema> _stationsActions =
      <ActionHistorySchema>[].obs;
  final RxInt _page = 1.obs;
  final RxBool _hasMoreData = true.obs;

  final pagesize = 15;

  StationsActionListState(this._station);

  @override
  void onInit() {
    _reload();
    super.onInit();
  }

  _reload() {
    _hasMoreData.value = true;
    _page.value = 1;
    ActionHistoryService()
        .getByStationActionHistoryByStationGet(
            _page.value, pagesize, _station.id)
        .then((value) {
      _stationsActions.clear();
      _stationsActions.addAll(value ?? []);
      _stationsActions.refresh();
      if (value == null || value.length < pagesize) {
        _hasMoreData.value = false;
      }
    });
  }

  loadMore() {
    if (!_hasMoreData.value) {
      return;
    }
    _page.value++;
    ActionHistoryService()
        .getByStationActionHistoryByStationGet(
            _page.value, pagesize, _station.id)
        .then((value) {
      _stationsActions.addAll(value ?? []);
      _stationsActions.refresh();
      if (value == null || value.length < pagesize) {
        _hasMoreData.value = false;
      }
    });
  }

  List<ActionHistorySchema> getStationsHistory() {
    return _stationsActions.toList();
  }
}
