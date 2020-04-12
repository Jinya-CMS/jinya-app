import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/media/files.dart';
import 'package:jinya_app/network/media/galleries.dart';
import 'package:jinya_app/shared/currentUser.dart';

class GalleryDesignerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GalleryDesignerPageState(_gallery);

  final Gallery _gallery;

  GalleryDesignerPage(this._gallery);
}

class GalleryDesignerPageState extends State<GalleryDesignerPage> {
  Gallery _gallery;
  List<File> _files;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<GalleryFilePosition> _galleryFilePositions = [];

  GalleryDesignerPageState(this._gallery);

  void loadPositions() async {
    final galleryFilePositions = await getPositions(_gallery.id);
    setState(() {
      _galleryFilePositions = galleryFilePositions;
    });

    getFiles().then((value) => setState(() {
          _files = value;
        }));
  }

  @override
  void initState() {
    loadPositions();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_gallery.name),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final file = await showDialog<File>(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                      title: Text(l10n.manageGalleriesDesignerAddFile),
                      children: _files
                          .map(
                            (e) => SimpleDialogOption(
                              key: Key(e.id.toString()),
                              onPressed: () {
                                Navigator.pop(context, e);
                              },
                              child: ListTile(
                                title: Text(e.name),
                                leading: Container(
                                  height: 64,
                                  width: 64,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Image.network(
                                      '${SettingsDatabase.selectedAccount.url}/${e.path}',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList());
                },
              );

              if (file != null) {
                final lastPosition = _galleryFilePositions.length > 0
                    ? _galleryFilePositions.last.position
                    : 0;

                final position = await addPosition(
                  _gallery.id,
                  file.id,
                  lastPosition + 1,
                );

                setState(() {
                  _galleryFilePositions.add(position);
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
      body: ReorderableListView(
        children: _galleryFilePositions
            .map(
              (item) => Dismissible(
                key: Key("${item.file.id}"),
                background: Container(
                  color: Theme.of(context).errorColor,
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.delete),
                    ],
                  ),
                ),
                child: ListTile(
                  leading: Container(
                    width: 64,
                    height: 64,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Image.network(
                        '${SettingsDatabase.selectedAccount.url}/${item.file.path}',
                      ),
                    ),
                  ),
                  title: Text("${item.file.name}"),
                  trailing: Icon(Icons.drag_handle),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  setState(() {
                    _galleryFilePositions.remove(item);
                  });

                  await removePosition(_gallery.id, item.id);
                },
              ),
            )
            .toList(),
        onReorder: (int start, int current) async {
          var startItem = _galleryFilePositions[start];
          if (start < current) {
            var end = current - 1;
            var i = 0;
            var local = start;
            do {
              _galleryFilePositions[local] = _galleryFilePositions[++local];
              i++;
            } while (i < end - start);
            _galleryFilePositions[end] = startItem;
          } else if (start > current) {
            // dragging from bottom to top
            for (var i = start; i > current; i--) {
              _galleryFilePositions[i] = _galleryFilePositions[i - 1];
            }
            _galleryFilePositions[current] = startItem;
          }
          setState(() {});
          await updatePosition(startItem.id, _gallery.id, start, current);
        },
      ),
    );
  }
}
