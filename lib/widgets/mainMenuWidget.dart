import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/dashboard.dart';
import 'package:open_cmms/pages/myTasks.dart';

class MainMenuWidget extends StatefulWidget {
  MainMenuWidget({
    Key? key,
  }) : super(key: key);
  String aa = "xxxx";
  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget> with AutomaticKeepAliveClientMixin<MainMenuWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Tooltip(
            message: "Dashboard",
            child: IconButton(
              icon: const Icon(Icons.widgets_outlined),
              onPressed: () =>
                  Get.off(() => Dashboard(), transition: Transition.noTransition),
            ),
          ),
          Tooltip(
            message: "My tasks",
            child: IconButton(
                icon: const Icon(Icons.note_outlined),
                onPressed: () => Get.off(() => MyTasks(),transition: Transition.noTransition)),
          ),
          Container(
              width: 50,
              child: const Divider(
                thickness: 1.0,
              )),
          Tooltip(
            message: "road segments",
            child: IconButton(
              icon: const Icon(Icons.edit_road),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: "assets",
            child: IconButton(
              icon: const Icon(Icons.settings_input_component),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: "storage",
            child: IconButton(
              icon: const Icon(Icons.storefront),
              onPressed: () {},
            ),
          ),
          Tooltip(
            message: "service contracts",
            child: IconButton(
              icon: const Icon(Icons.document_scanner),
              onPressed: () {},
            ),
          ),
          Container(
              width: 50,
              child: const Divider(
                thickness: 1.0,
              )),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {Get.defaultDialog(confirm: TextButton(onPressed: () {setState(() {
              widget.aa = "LLLLL";
            }); Get.back();}, child: Text("aaa")));},
          ),
          Text(widget.aa),
        ],
      ),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
