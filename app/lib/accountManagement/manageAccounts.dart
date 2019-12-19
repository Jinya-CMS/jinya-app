import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jinya_app/accountManagement/newAccount.dart';
import 'package:jinya_app/data/accountDatabase.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/shared/navDrawer.dart';

class ManageAccountsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageAccountsPageState();
  }
}

class ManageAccountsPageState extends State<ManageAccountsPage> {
  var accounts = List<Account>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void loadAccounts() async {
    final accs = await getAccounts();
    setState(() {
      accounts = accs;
    });
  }

  @override
  void initState() {
    loadAccounts();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(l10n.manageAccountsTitle),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewAccountPage(),
                ),
              );
            },
          )
        ],
      ),
      drawer: JinyaNavigationDrawer(),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: accounts.length,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          itemBuilder: (context, index) => Dismissible(
            background: Container(
              color: Theme.of(context).errorColor,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(right: 16.0),
                ),
              ),
            ),
            key: Key(accounts[index].id.toString()),
            onDismissed: (direction) {
              final account = accounts[index];
              deleteAccount(account.id).then((val) => this.loadAccounts());
              final snackbar = SnackBar(
                content: Text(l10n.manageAccountsDeleteSuccess(account.name)),
                action: SnackBarAction(
                  textColor: Theme.of(context).primaryColor,
                  label: l10n.actionUndo,
                  onPressed: () {
                    createAccount(account).then((val) => this.loadAccounts());
                  },
                ),
              );
              scaffoldKey.currentState.showSnackBar(snackbar);
            },
            child: ListTile(
              title: Text(accounts[index].name),
              subtitle: Text(
                '${accounts[index].email}\n${Uri.parse(accounts[index].url).host}',
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  '${accounts[index].url}/api/user/${accounts[index].jinyaId}/profilepicture',
                ),
              ),
              isThreeLine: true,
            ),
            direction: DismissDirection.endToStart,
          ),
        ),
      ),
    );
  }
}
