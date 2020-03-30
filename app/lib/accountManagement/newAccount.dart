import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/accountManagement/manageAccounts.dart';
import 'package:jinya_app/accountManagement/newAccountTwoFactor.dart';
import 'package:jinya_app/data/accountDatabase.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/authentication/login.dart' as network;
import 'package:validators/validators.dart';

class NewAccountPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewAccountPageState();
}

class NewAccountTransferObject {
  final String username;
  final String password;
  final String url;

  NewAccountTransferObject(this.username, this.password, this.url);
}

class NewAccountPageState extends State<NewAccountPage> {
  final _hostController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  void requestTwoFactorCode() async {
    if (_formKey.currentState.validate()) {
      final l10n = JinyaLocalizations.of(this.context);
      final host = _hostController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      final account = await getAccountByUrl(host);
      if (account != null && account.email == email) {
        final snackbar = SnackBar(
          content: Text(l10n.newAccountErrorExists),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      } else {
        try {
          await network.requestTwoFactorCode(email, password, host: host);
          final transferObject = NewAccountTransferObject(
            email,
            password,
            host,
          );
          Navigator.of(this.context).push(MaterialPageRoute(
            builder: (context) => NewAccountTwoFactorPage(transferObject),
          ));
        } catch (e) {
          final snackbar = SnackBar(
            content: Text(l10n.newAccountErrorInvalidCredentials),
          );
          _scaffoldKey.currentState.showSnackBar(snackbar);
        }
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
        automaticallyImplyLeading: false,
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
                controller: _hostController,
                autovalidate: true,
                keyboardType: TextInputType.url,
                autocorrect: false,
                validator: (value) {
                  if (!isURL(
                    value,
                    protocols: ['http', 'https'],
                    requireProtocol: true,
                  )) {
                    return l10n.newAccountErrorInvalidUrl;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: l10n.newAccountInputJinyaHost,
                ),
              ),
              TextFormField(
                controller: _emailController,
                autovalidate: true,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (!isEmail(value)) {
                    return l10n.newAccountErrorInvalidEmail;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: l10n.newAccountInputEmail,
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                autovalidate: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return l10n.newAccountErrorInvalidPassword;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: l10n.newAccountInputPassword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: requestTwoFactorCode,
                      color: Theme.of(context).primaryColor,
                      textColor: Color(0xFFFFFFFF),
                      child: Text(l10n.newAccountActionTwoFactorCode),
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
