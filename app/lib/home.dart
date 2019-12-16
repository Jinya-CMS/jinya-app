import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/shared/navDrawer.dart';

const String homePageBackground = 'assets/home/background.jpg';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(JinyaLocalizations.of(context).appName),
      ),
      drawer: JinyaNavigationDrawer(),
      body: Image.asset(
        homePageBackground,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
