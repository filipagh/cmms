import 'package:BackendAPI/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/auth_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';

import '../../../snacbars.dart';

class ChangeRoleForm extends StatelessWidget implements hasFormTitle {
  final UserSchema user;

  late Rx<Role> role;

  ChangeRoleForm({Key? key, required this.user}) : super(key: key) {
    role = user.role.obs;
  }

  @override
  Widget build(BuildContext context) {
    var dropDownItems = prepareDropDownItems();

    return Column(
      children: [
        Text(user.name),

        Obx(() => DropdownButtonFormField(
            value: role.value,
            items: dropDownItems,
            onChanged: (value) {
              role.value = value as Role;
            })),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Zrušiť")),
            Spacer(),
            ElevatedButton(
                onPressed: () async {
                  if (role.value != user.role) {
                    await AuthService().updateUserRoleAuthUserUserIdRolePost(
                        user.id, role.value);
                    Get.back();
                    showOk("Role zmenená");
                    return;
                  }
                  Get.back();
                },
                child: const Text("Zmeniť")),
          ],
        )
        // Container(height: 600, width: 500, child: buildTaskActionList()),
      ],
    );
  }

  @override
  Widget getInstance() {
    return this;
  }

  @override
  String getTitle() {
    return "Zmena role";
  }

  prepareDropDownItems() {
    List<DropdownMenuItem<Role>> items = [];
    for (var item in Role.values) {
      items.add(DropdownMenuItem(
        child: Text(item.value),
        value: item,
      ));
    }

    return items;
  }
}
