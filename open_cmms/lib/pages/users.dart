import 'package:BackendAPI/api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_cmms/service/backend_api/auth_service.dart';
import 'package:open_cmms/widgets/dialog_form.dart';
import 'package:open_cmms/widgets/forms/users/change_role.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class Users extends StatelessWidget {
  static const ENDPOINT = '/users';

  RxList<UserSchema> users = <UserSchema>[].obs;

  Users({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadUsers();
    return Scaffold(
      appBar: CustomAppBar(
        pageText: Text("Manažment používateľov"),
      ),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 500,
                    child: Obx(() {
                      return ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          thickness: 4,
                        ),
                        itemCount: users.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(users[index].name),
                            trailing: SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        showFormDialog(ChangeRoleForm(
                                                user: users[index]))
                                            .then((value) => loadUsers());
                                      },
                                      icon: Icon(Icons.edit)),
                                  Text("rola: " + users[index].role.value),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void loadUsers() async {
    AuthService().getAllAuthUsersGet().then((value) {
      users.clear();
      users.addAll(value!);
    });
  }
}
