import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/media/galleries.dart';

class GalleryDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GalleryDetailsPageState(_gallery);

  Gallery _gallery;

  GalleryDetailsPage(this._gallery);
}

class GalleryDetailsPageState extends State<GalleryDetailsPage> {
  Gallery _gallery;
  bool _changed;

  GalleryDetailsPageState(this._gallery);

  @override
  Widget build(Object context) {
    final l10n = JinyaLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_gallery.name),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _changed),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Text(_gallery.description),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.actionEdit,
        onPressed: () async {
//          final file = await Navigator.of(context).push(MaterialPageRoute(
//            builder: (context) => EditFilePage(_file),
//          ));
//          if (file is File) {
//            setState(() {
//              _file = file;
//              _changed = true;
//            });
//          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
