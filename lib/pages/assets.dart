import 'package:flutter/material.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class Assets extends StatefulWidget {
  const Assets({Key? key, }) : super(key: key);



  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children:  [
          MainMenuWidget(),
          VerticalDivider(),

          Expanded(
            child: Column(
              children: [
                Text("Assets",textScaleFactor: 5,),
                Text("mapa"),
                Expanded(child: Placeholder()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
