import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/content/media/galleryManagement/designer.dart';
import 'package:jinya_app/content/media/galleryManagement/editGallery.dart';
import 'package:jinya_app/content/media/galleryManagement/newGallery.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
import 'package:jinya_app/network/media/galleries.dart';
import 'package:jinya_app/network/media/galleries.dart' as network;

class GalleriesOverviewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GalleriesOverviewWidgetState();
  }
}

class GalleriesOverviewWidgetState extends State<GalleriesOverviewWidget> {
  var galleries = List<Gallery>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  JinyaLocalizations l10n;

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

  Column _getGalleryColumn(Gallery gallery) {
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          gallery.name,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );

    if (gallery.description != null && gallery.description != '') {
      column.children.add(Text(
        gallery.description,
        style: Theme.of(context).textTheme.bodyText2,
      ));
    }

    var caption = Theme.of(context).textTheme.caption;
    column.children.add(
      Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          l10n.manageGalleriesOrientation,
          style: caption,
        ),
      ),
    );
    column.children.add(
      Text(
        gallery.orientation == network.Orientation.horizontal
            ? l10n.manageGalleriesOrientationHorizontal
            : l10n.manageGalleriesOrientationVertical,
      ),
    );
    column.children.add(
      Text(
        l10n.manageGalleriesType,
        style: caption,
      ),
    );
    column.children.add(
      Text(
        gallery.type == network.Type.sequence
            ? l10n.manageGalleriesTypeSequence
            : l10n.manageGalleriesTypeMasonry,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: column,
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => GalleryDesignerPage(gallery),
                  ),
                );
              },
              child: Text(l10n.manageGalleriesActionDesigner.toUpperCase()),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton(
              onPressed: () async {
                final reload = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditGalleryPage(gallery),
                  ),
                );

                if (reload is bool && reload) {
                  loadGalleries();
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
                      title: Text(l10n.manageMediaGalleriesDeleteTitle),
                      content: Text(
                        l10n.manageMediaGalleriesDeleteContent(gallery.name),
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
                    await deleteGallery(gallery.slug);
                    final snackbar = SnackBar(
                      content: Text(
                        l10n.manageMediaGalleriesDeleteSuccess(gallery.name),
                      ),
                    );
                    scaffoldKey.currentState.showSnackBar(snackbar);

                    setState(() {
                      galleries.remove(gallery);
                    });
                  } on ConflictException {
                    final snackbar = SnackBar(
                      content: Text(
                        l10n.manageMediaGalleriesDeleteConflict(gallery.name),
                      ),
                    );
                    scaffoldKey.currentState.showSnackBar(snackbar);
                  } catch (e) {
                    final snackbar = SnackBar(
                      content: Text(
                        l10n.manageMediaGalleriesDeleteUnknown(gallery.name),
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
      ],
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
            itemCount: galleries.length,
            itemBuilder: (context, index) => Padding(
              key: Key(galleries[index].slug),
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: 8,
                      child: _getGalleryColumn(galleries[index]),
                    ),
                  ),
                ],
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
