import 'package:flutter/material.dart';
import 'package:jinya_app/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jinya CMS',
      theme: ThemeData(
        primaryColor: Color(0xFFda9c8a),
        accentColor: Color(0xFF8ac8da),
        primaryTextTheme: Typography(platform: TargetPlatform.android).white,
        accentTextTheme: Typography(platform: TargetPlatform.android).white,
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        accentIconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
        primaryIconTheme: Theme.of(context).iconTheme.copyWith(
              color: Colors.white,
            ),
      ),
      home: HomePage(),
    );
  }
}
