import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/content/media/mediaOverview.dart';
import 'package:jinya_app/controls/labeledRadioButton.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
import 'package:jinya_app/network/errors/NotEnoughPermissionsException.dart';
import 'package:jinya_app/network/media/galleries.dart' as network;

class NewGalleryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewGalleryPageState();
}

class NewGalleryPageState extends State<NewGalleryPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  network.Type _type = network.Type.sequence;
  network.Orientation _orientation = network.Orientation.horizontal;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  JinyaLocalizations l10n;

  Future<void> createGallery() async {
    try {
      await network.createGallery(
        _nameController.text,
        description: _descriptionController.text,
        type: _type,
        orientation: _orientation,
      );

      Navigator.of(this.context).push(MaterialPageRoute(
        builder: (context) => MediaOverviewPage(MediaTab.Galleries),
      ));
    } on ConflictException {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(l10n.newGalleryExistsError)));
    } on NotEnoughPermissionsException {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(l10n.newGalleryNotEnoughPermissionsError)));
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
        title: Text(l10n.newGalleryTitle),
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
                  keyboardType: TextInputType.url,
                  autocorrect: false,
                  validator: (value) {
                    if (value == '' && value == null) {
                      return l10n.newGalleryNameEmpty;
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: l10n.newGalleryName,
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
                            l10n.newGalleryOrientation,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                      LabeledRadio(
                        label: l10n.newGalleryOrientationVertical,
                        value: network.Orientation.vertical,
                        groupValue: _orientation,
                        onChanged: (value) {
                          setState(() {
                            _orientation = value;
                          });
                        },
                      ),
                      LabeledRadio(
                        label: l10n.newGalleryOrientationHorizontal,
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
                          l10n.newGalleryType,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    LabeledRadio(
                      label: l10n.newGalleryTypeMasonry,
                      value: network.Type.masonry,
                      groupValue: _type,
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      },
                    ),
                    LabeledRadio(
                      label: l10n.newGalleryTypeSequence,
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
                    labelText: l10n.newGalleryDescription,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: createGallery,
                        color: Theme.of(context).primaryColor,
                        textColor: Color(0xFFFFFFFF),
                        child: Text(l10n.newGalleryActionCreate),
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
