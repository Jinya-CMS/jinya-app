import 'package:flutter/material.dart';
import 'package:jinya_app/content/media/galleryManagement/newGallery.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
import 'package:jinya_app/network/media/galleries.dart';

class GalleriesOverviewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GalleriesOverviewWidgetState();
  }
}

class GalleriesOverviewWidgetState extends State<GalleriesOverviewWidget> {
  var galleries = List<Gallery>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void loadGalleries() async {
    final galleryList = await getGalleries();
    setState(() {
      galleries = galleryList;
    });
  }

  Future<void> refreshList() async {
    final galleryList = await getGalleries();
    setState(() {
      galleries = galleryList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadGalleries();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: scaffoldKey,
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: refreshList,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: galleries.length,
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
                      title: Text(l10n.manageMediaGalleriesDeleteTitle),
                      content: Text(
                        l10n.manageMediaGalleriesDeleteContent(
                          galleries[index].name,
                        ),
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
              key: Key(galleries[index].slug),
              onDismissed: (direction) async {
                final gallery = galleries[index];
                setState(() {
                  galleries.removeAt(index);
                });
                try {
                  await deleteGallery(gallery.slug);
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaGalleriesDeleteSuccess(gallery.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                } on ConflictException {
                  setState(() {
                    galleries.insert(index, gallery);
                  });
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaGalleriesDeleteConflict(gallery.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                } catch (e) {
                  setState(() {
                    galleries.insert(index, gallery);
                  });
                  final snackbar = SnackBar(
                    content: Text(
                      l10n.manageMediaGalleriesDeleteUnknown(gallery.name),
                    ),
                  );
                  scaffoldKey.currentState.showSnackBar(snackbar);
                }
              },
              child: ListTile(
                onTap: () async {
//                  final reload = await Navigator.of(context).push(
//                    MaterialPageRoute(
//                      builder: (context) =>
//                          GalleryDetailsPage(galleries[index]),
//                    ),
//                  );
//
//                  if (reload is bool && reload) {
//                    loadGalleries();
//                  }
                },
                title: Text(galleries[index].name),
                subtitle: Text(
                  '${galleries[index].description}',
                ),
              ),
              direction: DismissDirection.endToStart,
            ),
            separatorBuilder: (BuildContext context, int index) => Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Divider(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final reload = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewGalleryPage(),
            ),
          );

          if (reload is bool && reload) {
            loadGalleries();
          }
        },
      ),
    );
  }
}
