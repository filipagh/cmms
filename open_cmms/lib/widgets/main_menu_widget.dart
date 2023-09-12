import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/pages/investment_contracts.dart';
import 'package:open_cmms/pages/issues.dart';
import 'package:open_cmms/pages/service_contracts.dart';
import 'package:open_cmms/pages/stations.dart';

import '../pages/config/config.dart';
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
            message: "Mapa",
            child: IconButton(
              icon: const Icon(Icons.map_outlined),
              onPressed: () => Get.offAllNamed("/"),
            ),
          ),
          Tooltip(
            message: "Ǔlohy",
            child: IconButton(
              icon: const Icon(Icons.task_outlined),
              onPressed: () => Get.offAllNamed("/Tasks"),
            ),
          ),
          Tooltip(
            message: "Hlásenia",
            child: IconButton(
              icon: const Icon(Icons.report_problem_outlined),
              onPressed: () => Get.offAllNamed(IssuesPage.ENDPOINT),
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
            message: "Stanice",
            child: IconButton(
              icon: const Icon(Icons.settings_input_component),
              onPressed: () => Get.offAllNamed(Stations.ENDPOINT),
            ),
          ),
          Tooltip(
            message: "Sklad",
            child: IconButton(
              icon: const Icon(Icons.storefront),
              onPressed: () => Get.offAllNamed("/Storage"),
            ),
          ),
          Tooltip(
            message: "Servisné zmluvy",
            child: IconButton(
              icon: const Icon(Icons.document_scanner),
              onPressed: () => Get.offAllNamed(ServiceContracts.ENDPOINT),
            ),
          ),
          Tooltip(
            message: "Investičné zmluvy",
            child: IconButton(
              icon: const Icon(Icons.account_balance_wallet),
              onPressed: () => Get.offAllNamed(InvestmentContracts.ENDPOINT),
            ),
          ),
          Container(
              width: 50,
              child: const Divider(
                thickness: 1.0,
              )),
          Tooltip(
            message: "Manažment komponentov",
            child: IconButton(
              icon: const Icon(Icons.post_add),
              onPressed: () => Get.offAllNamed("/AssetManagement"),
            ),
          ),
          if (authService.isAdmin.isTrue) ...[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Get.offAllNamed(Config.ENDPOINT),
            ),
            Tooltip(
              message: "Manažment používateľov",
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
