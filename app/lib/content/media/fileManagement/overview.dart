import 'package:flutter/material.dart';
import 'package:jinya_app/content/media/fileManagement/newFile.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/media/files.dart';
import 'package:jinya_app/shared/currentUser.dart';

class FilesOverviewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilesOverviewWidgetState();
  }
}

class FilesOverviewWidgetState extends State<FilesOverviewWidget> {
  var files = List<File>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void loadFiles() async {
    final fileList = await getFiles();
    setState(() {
      files = fileList;
    });
  }

  @override
  void initState() {
    loadFiles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: scaffoldKey,
      body: Scrollbar(
        child: ListView.builder(
          itemCount: files.length,
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
            key: Key(files[index].id.toString()),
            onDismissed: (direction) {
              final account = files[index];
//    deleteAccount(account.id).then((val) => this.loadFiles()));
              final snackbar = SnackBar(
                content: Text(l10n.manageAccountsDeleteSuccess(account.name)),
                action: SnackBarAction(
                  textColor: Theme.of(context).primaryColor,
                  label: l10n.actionUndo,
                  onPressed: () {
//    createAccount(account).then((val) => this.loadAccounts());
                  },
                ),
              );
              scaffoldKey.currentState.showSnackBar(snackbar);
            },
            child: ListTile(
              title: Text(files[index].name),
              subtitle: Text(
                '${files[index].name}',
              ),
              leading: Container(
                width: 72,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '${SettingsDatabase.selectedAccount.url}/${files[index].path}',
                    ),
                  ),
                ),
              ),
            ),
            direction: DismissDirection.endToStart,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewFilePage(),
            ),
          );
        },
      ),
    );
  }
}
