import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/RoadSegmentManager.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

class RoadSegmentPickerForm extends StatelessWidget implements hasFormTitle {
  RoadSegmentPickerForm({Key? key}) : super(key: key);

  String getTitle() {
    return "Vybrat cestny usek";
  }

  @override
  Widget getInstance() {
    return this;
  }

  final RxList<RoadSegmentSchema> _road_segments = <RoadSegmentSchema>[].obs;
  final RxnString _query = RxnString();

  @override
  Widget build(BuildContext context) {
    load();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          child: TextField(
            autofocus: true,
            onChanged: (v) {
              if (v.length >= 3) {
                _query.value = v;
                load();
              }
              if (v.length < 3 && _query.value != null) {
                _query.value = null;
                load();
              }
            },
            decoration: InputDecoration(
              hintText: "Hľadať",
            ),
          ),
        ),
        Obx(() {
          var items = _road_segments.toList();
          return SizedBox(
            width: 500,
            height: Get.height - 300,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                var i = items[index];
                return Card(
                  child: ListTile(
                    onTap: () => Get.back(result: i),
                    title: Center(
                      child: Text(i.name),
                    ),
                  ),
                );
              },
            ),
          );
        })
      ],
    );
  }

  load() {
    if (_query.value != null) {
      RoadSegmentService()
          .searchRoadSegmentManagerSegmentsSearchGet(_query.value!,
              onlyActive: true)
          .then((value) => _road_segments.value = (value ?? []));
    } else {
      RoadSegmentService()
          .getAllRoadSegmentManagerSegmentsGet(onlyActive: true)
          .then((value) => _road_segments.value = (value ?? []));
    }
  }
}
