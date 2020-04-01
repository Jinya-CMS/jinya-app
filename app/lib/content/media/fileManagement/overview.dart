import 'package:flutter/material.dart';
import 'package:jinya_app/content/media/fileManagement/fileDetailsPage.dart';
import 'package:jinya_app/content/media/fileManagement/newFile.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
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

  Future<void> refreshList() async {
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
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
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
              confirmDismiss: (direction) async {
                return showDialog<bool>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(l10n.manageMediaFilesDeleteTitle),
                      content: Text(
                        l10n.manageMediaFilesDeleteContent(files[index].name),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(l10n.actionDontDelete.toUpperCase()),
                          textColor: Theme.of(context).accentColor,
                          onPressed: () {
                            Navigator.pop(
                              context,
                              false,
                            );
                          },
                        ),
                        FlatButton(
                          child: Text(l10n.actionDelete.toUpperCase()),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () {
                            Navigator.pop(
                              context,
                              true,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              key: Key(files[index].id.toString()),
              onDismissed: (direction) async {
                final file = files[index];
                setState(() {
                  files.removeAt(index);
                });
                try {
                  await deleteFile(file.id);
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaFilesDeleteSuccess(file.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                } on ConflictException {
                  setState(() {
                    files.insert(index, file);
                  });
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaFilesDeleteConflict(file.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                } catch (e) {
                  setState(() {
                    files.insert(index, file);
                  });
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaFilesDeleteUnknown(file.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                }
              },
              child: ListTile(
                onTap: () async {
                  final reload = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => FileDetailsPage(files[index]),
                    ),
                  );

                  if (reload is bool && reload) {
                    loadFiles();
                  }
                },
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final reload = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewFilePage(),
            ),
          );

          if (reload is bool && reload) {
            await loadFiles();
          }
        },
      ),
    );
  }
}
