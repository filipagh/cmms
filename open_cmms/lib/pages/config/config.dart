import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/back_end_service.dart';
import 'package:open_cmms/service/backend_api/redmine_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/config/redmine_auth.dart';

import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_menu_widget.dart';

class Config extends StatelessWidget {
  static const String ENDPOINT = '/config';

  final Rxn<List<SettingSchema>> settings = Rxn<List<SettingSchema>>();

  Config({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadSettings();

    return Scaffold(
      appBar: CustomAppBar(
        pageText: Text("Nastavenia"),
      ),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () {
                    if (settings.value == null) {
                      return const CircularProgressIndicator();
                    } else if (settings.value!.isEmpty) {
                      return const Text("Nastavenia nie sú k dispozícii");
                    } else {
                      return Expanded(
                        child: SizedBox(
                          width: 600,
                          child: ListView(children: getSettings()),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  getSettings() {
    return [
      ...getRedmine(),
    ];
  }

  List<ListTile> getRedmine() {
    var redmineUrl = getSetting(SettingsEnum.url);
    List<ListTile> list = [];
    list.add(ListTile(
      title: const Text("Redmine"),
      subtitle: redmineUrl.enabled
          ? Text(redmineUrl.value)
          : const Text("Redmine nie je integrovaný"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (redmineUrl.enabled) ...[
            ElevatedButton(
                onPressed: () {
                  RedmineService()
                      .removeIntegrationRedmineSetupDelete()
                      .then((value) => loadSettings());
                },
                child: const Text("Zrušiť integrovanie"))
          ],
          ElevatedButton(
              onPressed: () {
                showFormDialog(Redmine_auth_form())
                    .then((value) => loadSettings());
              },
              child: const Text("Integrovať"))
        ],
      ),
    ));
    return list;
  }

  SettingSchema getSetting(SettingsEnum setting) {
    return settings.value!.firstWhere((element) => element.key == setting);
  }

  void loadSettings() {
    BackEndService().settingsSettingsGet().then((value) {
      settings.value?.clear();
      settings.value = value!;
      settings.refresh();
    });
  }
}
