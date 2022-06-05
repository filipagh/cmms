import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_model.dart';

class AssetsList extends StatelessWidget {
  final List<AssetModel> list;

  const AssetsList({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
        ? Expanded(child: Center(child: Text("no stations",textScaleFactor: 3,)))
        : Expanded(
            child: ListView.builder(
                addRepaintBoundaries: true,
                padding: const EdgeInsets.all(8),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Get.toNamed("/Assets/${list[index].id}");
                      },
                      hoverColor: Colors.blue.shade200,
                      title:
                          Center(child: Text('station: ${list[index].name}')),
                      subtitle:
                          Center(child: Text('station Id: ${list[index].id}')),
                    ),
                  );
                }),
          );
  }
}
