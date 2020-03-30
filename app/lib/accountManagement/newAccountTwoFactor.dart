import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/accountManagement/manageAccounts.dart';
import 'package:jinya_app/accountManagement/newAccount.dart';
import 'package:jinya_app/data/accountDatabase.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/artist/account.dart' as accountClient;
import 'package:jinya_app/network/authentication/login.dart' as loginClient;
import 'package:jinya_app/shared/currentUser.dart';

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
      final l10n = JinyaLocalizations.of(context);
      try {
        final result = await loginClient.login(
          widget.newAccountTransferObject.username,
          widget.newAccountTransferObject.password,
          host: widget.newAccountTransferObject.url,
          twoFactorCode: _codeController.text,
        );
        final account = Account(
          url: widget.newAccountTransferObject.url,
          email: widget.newAccountTransferObject.username,
          apiKey: result.apiKey,
          deviceToken: result.deviceCode,
        );
        SettingsDatabase.selectedAccount = account;
        final currentUser = await accountClient.getAccount();
        account.name = currentUser.artistName;
        account.jinyaId = currentUser.id;

        await createAccount(account);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ManageAccountsPage(),
        ));
      } catch (e) {
        final snackbar = SnackBar(
          content: Text(l10n.newAccountErrorInvalidCredentials),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => ManageAccountsPage(),
            ),
          ),
        ),
      ),
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
