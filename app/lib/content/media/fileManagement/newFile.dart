import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/content/media/mediaOverview.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
import 'package:jinya_app/network/errors/NotEnoughPermissionsException.dart';
import 'package:jinya_app/network/media/files.dart' as network;
import 'package:path/path.dart';

class NewFilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewFilePageState();
}

class NewFilePageState extends State<NewFilePage> {
  final _nameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var _fileName = '';
  io.File _file;
  JinyaLocalizations l10n;

  Future<void> createFile() async {
    try {
      final file = await network.createFile(_nameController.text);
      await network.uploadFile(file.id, _file);

      Navigator.of(this.context).push(MaterialPageRoute(
        builder: (context) => MediaOverviewPage(MediaTab.Files),
      ));
    } on ConflictException {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(l10n.newFileExistsError)));
    } on NotEnoughPermissionsException {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(l10n.newFileNotEnoughPermissionsError)));
    } catch (e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void pickFile() async {
    final file = await FilePicker.getFile();
    if (file != null) {
      if (_nameController.text == '') {
        _nameController.text = basename(file.path);
        _formKey.currentState.validate();
      }

      setState(() {
        _file = file;
        _fileName = basename(file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    l10n = JinyaLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(l10n.newFileTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Container(
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
                    return l10n.newFileNameEmpty;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: l10n.newFileName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: pickFile,
                      color: Theme.of(context).primaryColor,
                      textColor: Color(0xFFFFFFFF),
                      child: Text(l10n.newFileActionPickFile),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        basename(_fileName),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: createFile,
                      color: Theme.of(context).primaryColor,
                      textColor: Color(0xFFFFFFFF),
                      child: Text(l10n.newFileActionCreate),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
