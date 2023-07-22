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

  @override
  Widget build(BuildContext context) {
    RoadSegmentService()
        .getAllRoadSegmentManagerSegmentsGet(onlyActive: true)
        .then((value) => _road_segments.addAll(value ?? []));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 200,
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Hľadať (WIP)",
              enabled: false,
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
}
