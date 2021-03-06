import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jinya_app/home.dart';
import 'package:jinya_app/localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const JinyaLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('de'),
      ],
      title: 'Jinya CMS',
      theme: ThemeData(
        primaryColor: Color(0xFF504a56),
        accentColor: Color(0xFF966554),
        errorColor: Color(0xFF5C0B0B),
        primaryTextTheme:
            Typography.material2018(platform: TargetPlatform.android).white,
        accentTextTheme:
            Typography.material2018(platform: TargetPlatform.android).white,
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
