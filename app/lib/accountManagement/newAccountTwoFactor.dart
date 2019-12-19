import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/accountManagement/manageAccounts.dart';
import 'package:jinya_app/accountManagement/newAccount.dart';
import 'package:jinya_app/data/accountDatabase.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/shared/navDrawer.dart';

class NewAccountTwoFactorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewAccountTwoFactorPageState();

  final NewAccountTransferObject newAccountTransferObject;

  NewAccountTwoFactorPage(this.newAccountTransferObject);
}

class NewAccountTwoFactorPageState extends State<NewAccountTwoFactorPage> {
  final _codeController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void login() async {
    if (_formKey.currentState.validate()) {
      final client = Dio();
      final l10n = JinyaLocalizations.of(context);
      final response = await client.post(
        '${widget.newAccountTransferObject.url}/api/login',
        data: jsonEncode({
          'username': widget.newAccountTransferObject.username,
          'password': widget.newAccountTransferObject.password,
          'twoFactorCode': _codeController.text,
        }),
        options: Options(
          responseType: ResponseType.json,
          contentType: 'application/json',
        ),
      );

      if (response.statusCode != 200) {
        final errorData = jsonDecode(response.toString());
        print(errorData);
        final snackbar = SnackBar(
          content: Text(l10n.newAccountErrorInvalidCredentials),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      } else {
        final currentUser = await client.get(
          '${widget.newAccountTransferObject.url}/api/account',
          options: Options(headers: {'JinyaApiKey': response.data['apiKey']}),
        );
        final account = Account(
          jinyaId: currentUser.data['id'],
          url: widget.newAccountTransferObject.url,
          email: widget.newAccountTransferObject.username,
          apiKey: response.data['apiKey'],
          deviceToken: response.data['deviceCode'],
          name: currentUser.data['artistName'],
        );

        await createAccount(account);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ManageAccountsPage(),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(l10n.newAccountTitle),
      ),
      drawer: JinyaNavigationDrawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 32.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _codeController,
                autovalidate: true,
                keyboardType: TextInputType.numberWithOptions(),
                autocorrect: false,
                validator: (value) {
                  if (value.length > 6 || value.length < 6) {
                    return l10n.newAccountTwoFactorErrorInvalidCode;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: l10n.newAccountTwoFactorInputCode,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: login,
                      color: Theme.of(context).primaryColor,
                      textColor: Color(0xFFFFFFFF),
                      child: Text(l10n.newAccountTwoFactorActionLogin),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
