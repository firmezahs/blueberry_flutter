import 'package:blueberry/main.dart';
import 'package:blueberry/utils/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  LanguagesScreenState createState() => LanguagesScreenState();
}

class LanguagesScreenState extends State<LanguagesScreen> {
  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
  }

  Future<void> init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        context.translate.appName,
        textColor: white,
        elevation: 0.0,
        color: context.primaryColor,
      ),
      body: LanguageListWidget(
        widgetType: WidgetType.LIST,
        onLanguageChange: (v) {
          appStore.setLanguage(v.languageCode!);
          setState(() {});
          finish(context);
        },
      ),
    );
  }
}
