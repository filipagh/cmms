import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/main_menu_widget.dart';

class News extends StatelessWidget {
  static const ENDPOINT = '/news';

  RxString news = "".obs;

  News({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    loadNews();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          MainMenuWidget(),
          const VerticalDivider(),
          Expanded(
            child: Obx(() {
              return Markdown(data: news.value);
            }),
          )
        ],
      ),
    );
  }

  void loadNews() async {
    rootBundle.loadString('news.md').then((value) => news.value = value);
  }
}
