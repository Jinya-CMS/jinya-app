import 'package:flutter/widgets.dart';
import 'package:jinya_app/network/media/galleries.dart';

class GalleryDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GalleryDetailsPageState(_gallery);

  Gallery _gallery;

  GalleryDetailsPage(this._gallery);
}

class GalleryDetailsPageState extends State<GalleryDetailsPage> {
  Gallery _gallery;

  GalleryDetailsPageState(this._gallery);

  @override
  Widget build(Object context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
