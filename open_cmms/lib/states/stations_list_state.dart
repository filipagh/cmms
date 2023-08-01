import 'dart:core';

import 'package:BackendAPI/api.dart';
import 'package:get/get.dart';

import '../service/backend_api/station_service.dart';

class StationsListState extends GetxController {
  final RxList<StationSchema> _stations = <StationSchema>[].obs;
  final RxBool _include_deleted_stations = false.obs;
  final RxInt _page = 1.obs;
  final RxBool _hasMoreData = true.obs;
  final RxnString _searchQuery = RxnString();

  @override
  void onInit() {
    _reload();
    super.onInit();
  }

  _reload() {
    _hasMoreData.value = true;
    _page.value = 1;
    if (_searchQuery.value != null) {
      StationService()
          .searchStationsStationStationsSearchGet(
              _searchQuery.value!, _page.value, 15,
              onlyActive: !_include_deleted_stations.value)
          .then((value) {
        _stations.clear();
        _stations.addAll(value ?? []);
        _stations.refresh();
        if (value == null || value.length < 15) {
          _hasMoreData.value = false;
        }
      });
    } else {
      StationService()
          .getAllStationStationsGet(_page.value, 15,
              onlyActive: !_include_deleted_stations.value)
          .then((value) {
        _stations.clear();
        _stations.addAll(value ?? []);
        _stations.refresh();
        if (value == null || value.length < 15) {
          _hasMoreData.value = false;
        }
      });
    }
  }

  loadMore() {
    if (!_hasMoreData.value) {
      return;
    }
    _page.value++;
    if (_searchQuery.value != null) {
      StationService()
          .searchStationsStationStationsSearchGet(
              _searchQuery.value!, _page.value, 10,
              onlyActive: !_include_deleted_stations.value)
          .then((value) {
        _stations.addAll(value ?? []);
        _stations.refresh();
        if (value == null || value.length < 10) {
          _hasMoreData.value = false;
        }
      });
    } else {
      StationService()
          .getAllStationStationsGet(_page.value, 10,
              onlyActive: !_include_deleted_stations.value)
          .then((value) {
        _stations.addAll(value ?? []);
        _stations.refresh();
        if (value == null || value.length < 10) {
          _hasMoreData.value = false;
        }
      });
    }
  }

  search(String? query) {
    if ((query == null || query.isEmpty) && _searchQuery.value == null) {
      return;
    }
    _searchQuery.value = query;
    _reload();
  }

  List<StationSchema> getStations() {
    return _stations.toList();
  }

  bool getIncludeDeleted() {
    return _include_deleted_stations.value;
  }

  void setIncludeDeleted(bool value) {
    _include_deleted_stations.value = value;
    _reload();
  }
}
