import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_cmms/helper.dart';
import 'package:open_cmms/models/task.dart';

class TestState extends GetxController {
  int cislo = 0;


  int getAndInc() {
    cislo = cislo+1;
    return cislo;
  }
}
