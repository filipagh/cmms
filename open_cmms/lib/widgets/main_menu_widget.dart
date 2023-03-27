import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/service_contracts.dart';
import 'package:open_cmms/pages/stations.dart';
import 'package:open_cmms/snacbars.dart';

import '../pages/news.dart';
import '../pages/users.dart';
import '../states/auth_state.dart';

class MainMenuWidget extends StatefulWidget {
  MainMenuWidget({
    Key? key,
  }) : super(key: key);
  String aa = "xxxx";

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
}

class _MainMenuWidgetState extends State<MainMenuWidget>
    with AutomaticKeepAliveClientMixin<MainMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final authService = Get.find<AuthState>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Tooltip(
            message: "Dashboard",
            child: IconButton(
              icon: const Icon(Icons.widgets_outlined),
              onPressed: () => Get.offAllNamed("/"),
            ),
          ),
          Tooltip(
            message: "My tasks",
            child: IconButton(
              icon: const Icon(Icons.note_outlined),
              onPressed: () => Get.offAllNamed("/Tasks"),
            ),
          ),
          Container(
              width: 50,
              child: const Divider(
                thickness: 1.0,
              )),
          Tooltip(
            message: "Cestné úseky",
            child: IconButton(
              icon: const Icon(Icons.edit_road),
              onPressed: () => Get.offAllNamed("/RoadSegments"),
            ),
          ),
          Tooltip(
            message: "Stations",
            child: IconButton(
              icon: const Icon(Icons.settings_input_component),
              onPressed: () => Get.offAllNamed(Stations.ENDPOINT),
            ),
          ),
          Tooltip(
            message: "storage",
            child: IconButton(
              icon: const Icon(Icons.storefront),
              onPressed: () => Get.offAllNamed("/Storage"),
            ),
          ),
          Tooltip(
            message: "service contracts",
            child: IconButton(
              icon: const Icon(Icons.document_scanner),
              onPressed: () => Get.offAllNamed(ServiceContracts.ENDPOINT),
            ),
          ),
          Container(
              width: 50,
              child: const Divider(
                thickness: 1.0,
              )),
          Tooltip(
            message: "asset management",
            child: IconButton(
              icon: const Icon(Icons.post_add),
              onPressed: () => Get.offAllNamed("/AssetManagement"),
            ),
          ),
          if (authService.isAdmin.isTrue) ...[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                showInfo("zatial nic nerobim");
              },
            ),
            Tooltip(
              message: "manazment pouzivatelov",
              child: IconButton(
                icon: const Icon(Icons.person),
                onPressed: () => Get.offAllNamed(Users.ENDPOINT),
              ),
            ),
          ],
          Spacer(),
          Tooltip(
            message: "novinky",
            child: IconButton(
              icon: const Icon(Icons.new_releases),
              onPressed: () {
                Get.offAllNamed(News.ENDPOINT);
              },
            ),
          ),
          // GetX<StateAssetTypes>(
          //     builder: (_) => Text(
          //       'clicks: ${ctrl.getll().toString()} ${ctrl2.counter.toString()}',
          //     )),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
