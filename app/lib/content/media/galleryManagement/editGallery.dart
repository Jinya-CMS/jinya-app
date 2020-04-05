import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/content/media/mediaOverview.dart';
import 'package:jinya_app/controls/labeledRadioButton.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
import 'package:jinya_app/network/errors/NotEnoughPermissionsException.dart';
import 'package:jinya_app/network/media/galleries.dart' as network;

class EditGalleryPage extends StatefulWidget {
  network.Gallery _gallery;

  @override
  State<StatefulWidget> createState() => EditGalleryPageState(_gallery);

  EditGalleryPage(this._gallery);
}

class EditGalleryPageState extends State<EditGalleryPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  network.Type _type = network.Type.sequence;
  network.Orientation _orientation = network.Orientation.horizontal;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  JinyaLocalizations l10n;
  network.Gallery _gallery;

  EditGalleryPageState(this._gallery) {
    _type = _gallery.type;
    _orientation = _gallery.orientation;
    _descriptionController.text = _gallery.description;
    _nameController.text = _gallery.name;
  }

  Future<void> updateGallery() async {
    try {
      await network.updateGallery(
        _gallery.slug,
        name: _nameController.text,
        description: _descriptionController.text,
        type: _type,
        orientation: _orientation,
      );

      Navigator.of(this.context).push(MaterialPageRoute(
        builder: (context) => MediaOverviewPage(MediaTab.Galleries),
      ));
    } on ConflictException {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(l10n.editGalleryExistsError)));
    } on NotEnoughPermissionsException {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(l10n.editGalleryNotEnoughPermissionsError)));
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_gallery.name),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  autovalidate: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  autocorrect: true,
                  validator: (value) {
                    if (value == '' && value == null) {
                      return l10n.editGalleryNameEmpty;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: l10n.editGalleryName,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            l10n.editGalleryOrientation,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      LabeledRadio(
                        label: l10n.editGalleryOrientationVertical,
                        value: network.Orientation.vertical,
                        groupValue: _orientation,
                        onChanged: (value) {
                          setState(() {
                            _orientation = value;
                          });
                        },
                      ),
                      LabeledRadio(
                        label: l10n.editGalleryOrientationHorizontal,
                        value: network.Orientation.horizontal,
                        groupValue: _orientation,
                        onChanged: (value) {
                          setState(() {
                            _orientation = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.editGalleryType,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    LabeledRadio(
                      label: l10n.editGalleryTypeMasonry,
                      value: network.Type.masonry,
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                    LabeledRadio(
                      label: l10n.editGalleryTypeSequence,
                      value: network.Type.sequence,
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                  ],
                ),
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  autocorrect: true,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: l10n.editGalleryDescription,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: updateGallery,
                        color: Theme.of(context).primaryColor,
                        textColor: Color(0xFFFFFFFF),
                        child: Text(l10n.editGalleryActionUpdate),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
