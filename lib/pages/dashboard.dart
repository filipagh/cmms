import 'package:flutter/material.dart';

import '../widgets/customAppBar.dart';
import '../widgets/mainMenuWidget.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, }) : super(key: key);



  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
                Text("DashBoard",textScaleFactor: 5,),
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
