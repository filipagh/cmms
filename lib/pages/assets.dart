import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/models/asset_model.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class Assets extends StatefulWidget {
  const Assets({
    Key? key,
  }) : super(key: key);

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          VerticalDivider(),
          Expanded(
            child: Column(
              children: [
                Text(
                  "Assets",
                  textScaleFactor: 5,
                ),
                Row(
                  children: [
                    Placeholder(
                      child: SizedBox(width: 300, child: Text("searchbar")),
                    ),
                    Placeholder(
                      child: Icon(Icons.filter_list_alt),
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("add asset"),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    addRepaintBoundaries: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: dummyAssets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(

                          child: ListTile(
                            onTap: () {Get.toNamed("/Assets/${dummyAssets[index].id}");},
                            hoverColor: Colors.blue.shade200,
                            title: Container(
                              child: Center(
                                  child:
                                      Text('asset id: ${dummyAssets[index].id}')),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
