import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/accountManagement/manageAccounts.dart';
import 'package:jinya_app/data/accountDatabase.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/login.dart';
import 'package:jinya_app/network/authentication/login.dart';
import 'package:jinya_app/shared/currentUser.dart';
import 'package:jinya_app/shared/navDrawer.dart';

const String homePageBackground = 'assets/home/background.jpg';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkAuth = () async {
      if (SettingsDatabase.selectedAccount == null) {
        final accounts = await getAccounts();
        if (accounts.length > 0) {
          SettingsDatabase.selectedAccount = accounts.first;
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ManageAccountsPage(),
            ),
          );
        }
      }

      if (!(await checkApiKey(SettingsDatabase.selectedAccount.apiKey))) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    };
    checkAuth();

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
