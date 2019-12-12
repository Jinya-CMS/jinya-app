import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/shared/navDrawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jinya CMS'),
      ),
      drawer: JinyaNavigationDrawer(),
    );
  }
}
