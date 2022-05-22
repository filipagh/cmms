import 'package:flutter/material.dart';

import '../widgets/customAppBar.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: const Center(
        child: Text(
          "404 not found",
          textScaleFactor: 5,
        ),
      ),
    );
  }
}
