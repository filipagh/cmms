import 'package:BackendAPI/api.dart';

class TaskStateCustom {
  TaskState state;

  TaskStateCustom(this.state);

  @override
  String toString() {
    {
      switch (state) {
        case TaskState.open:
          return "Vytvorená";

        case TaskState.ready:
          return "Pripravená";

        case TaskState.done:
          return "Dokončená";

        case TaskState.removed:
          return "Zrušená";

        default:
          return state.value;
      }
    }
  }
}
