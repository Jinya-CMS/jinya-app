import 'package:chewie/chewie.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/content/media/fileManagement/editFile.dart';
import 'package:jinya_app/content/media/fileManagement/newFile.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
import 'package:jinya_app/network/media/files.dart';
import 'package:jinya_app/shared/currentUser.dart';
import 'package:video_player/video_player.dart';

class FilesOverviewWidget extends StatefulWidget {
  FilesOverviewWidgetState _state;

  @override
  State<StatefulWidget> createState() {
    return _state = FilesOverviewWidgetState();
  }

  Future<void> executeNew() async {
    await _state.executeNew();
  }
}

class FilesOverviewWidgetState extends State<FilesOverviewWidget> {
  var files = List<File>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<ChewieAudioController> _audioControllers = [];
  final List<VideoPlayerController> _videoControllers = [];
  final List<ChewieController> _chewieControllers = [];
  JinyaLocalizations l10n;

  Future<void> executeNew() async {
    final reload = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewFilePage(),
      ),
    );

    if (reload is bool && reload) {
      loadFiles();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _audioControllers.forEach((element) {
      element?.dispose();
    });
    _chewieControllers.forEach((element) {
      element?.dispose();
    });
    _videoControllers.forEach((element) {
      element?.dispose();
    });
  }

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
    super.initState();
    loadFiles();
  }

  Card _getCard(File file) {
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[],
    );

    if (file.type.startsWith('image/')) {
      column.children.add(Image.network(
        '${SettingsDatabase.selectedAccount.url}/${file.path}',
      ));
    } else if (file.type.startsWith('video/')) {
      final videoPlayerController = VideoPlayerController.network(
          '${SettingsDatabase.selectedAccount.url}/${file.path}');

      final chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        aspectRatio: 1.77,
      );
      _chewieControllers.add(chewieController);

      column.children.add(Chewie(
        controller: chewieController,
      ));
    } else if (file.type.startsWith('audio/')) {
      final videoPlayerController = VideoPlayerController.network(
        '${SettingsDatabase.selectedAccount.url}/${file.path}',
      );

      final chewieAudioController = ChewieAudioController(
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
      );

      column.children.add(
        ChewieAudio(
          controller: chewieAudioController,
        ),
      );
    }

    column.children.add(
      Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          file.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
    column.children.add(
      ButtonBar(
        children: <Widget>[
          FlatButton(
            onPressed: () async {
              final reload = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditFilePage(file),
                ),
              );

              if (reload is bool && reload) {
                loadFiles();
              }
            },
            child: Text(l10n.actionEdit.toUpperCase()),
            textColor: Theme.of(context).accentColor,
          ),
          FlatButton(
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(l10n.manageMediaFilesDeleteTitle),
                    content: Text(
                      l10n.manageMediaFilesDeleteContent(file.name),
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

              if (result) {
                try {
                  await deleteFile(file.id);
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaFilesDeleteSuccess(file.name),
                    ),
                  );
                  setState(() {
                    files.remove(file);
                  });
                  scaffoldKey.currentState.showSnackBar(snackbar);
                } on ConflictException {
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaFilesDeleteConflict(file.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                } catch (e) {
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaFilesDeleteUnknown(file.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                }
              }
            },
            child: Text(l10n.actionDelete.toUpperCase()),
            textColor: Theme.of(context).errorColor,
          ),
        ],
      ),
    );

    return Card(
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      child: column,
    );
  }

  @override
  Widget build(BuildContext context) {
    l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: scaffoldKey,
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: files.length,
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemBuilder: (context, index) => Padding(
              key: Key(files[index].id.toString()),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: _getCard(files[index]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
