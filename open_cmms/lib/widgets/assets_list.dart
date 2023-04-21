import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/station/station_base_page.dart';
import 'package:open_cmms/states/asset_types_state_dummy.dart';

class AssetsList extends StatelessWidget {
  final List<StationSchema> list;

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
                        Get.toNamed(
                            StationBasePage.ENDPOINT + "/${list[index].id}");
                      },
                      hoverColor: Colors.blue.shade200,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Stanica: ${list[index].name}'),
                          if (list[index].isActive != true) ...[
                            Tooltip(
                                message: 'stanica je zmazaná',
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  color: Colors.red,
                                ))
                          ],
                        ],
                      ),
                      subtitle:
                          Center(child: Text('Stanica Id: ${list[index].id}')),
                    ),
                  );
                }),
          );
  }
}
