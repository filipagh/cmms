import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/station.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';

class AssetsList extends StatelessWidget {
  final List<Station> list;

  const AssetsList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssetTypesStateDummy cc= Get.find();
    return list.isEmpty
        ? Expanded(child: Center(child: Text("Žiadna stanica",textScaleFactor: 3,)))
        : Expanded(
            child: ListView.builder(
                addRepaintBoundaries: true,
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.toNamed(StationBasePage.ENDPOINT+"/${list[index].id}");
                      },
                      hoverColor: Colors.blue.shade200,
                      title:
                          Center(child: Text('Stanica: ${list[index].name}')),
                      subtitle:
                          Center(child: Text('Stanica Id: ${list[index].id}')),
                    ),
                  );
                }),
          );
  }
}
