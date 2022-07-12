import 'package:flutter/material.dart';

class StationTabMenu extends StatelessWidget {
  StationTabMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildColumn();
  }

  Column buildColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: getButtons()
    );
  }

  List<Widget> getButtons() {
    List<Widget> list = [];
    buttonList.forEach((element) {
      list.add(ElevatedButton.icon(
        style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.all(10)),),
        onPressed: () {},
        label: Text(element.label),
        icon: element.icon,
      ));
      list.add(Divider());
    });
    return list;
  }

  List<StationButton> buttonList = [
    StationButton("Base Info", const Icon(Icons.info), ""),
    StationButton("Components", const Icon(Icons.settings), ""),
    StationButton("Tasks", const Icon(Icons.task), ""),
    StationButton("History", const Icon(Icons.history), ""),
  ];
}

class StationButton {
  late String label;
  late Icon icon;
  late String endpoint;

  StationButton(this.label, this.icon, this.endpoint);
}
