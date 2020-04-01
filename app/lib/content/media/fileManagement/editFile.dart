import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/localizations.dart';
import 'package:jinya_app/network/errors/ConflictException.dart';
import 'package:jinya_app/network/errors/NotEnoughPermissionsException.dart';
import 'package:jinya_app/network/media/files.dart' as network;
import 'package:path/path.dart';

class EditFilePage extends StatefulWidget {
  final network.File _file;

  @override
  State<StatefulWidget> createState() => EditFilePageState(_file);

  EditFilePage(this._file);
}

class EditFilePageState extends State<EditFilePage> {
  final _nameController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  var _fileName = '';
  final network.File _jinyaFile;
  io.File _file;
  JinyaLocalizations l10n;

  EditFilePageState(this._jinyaFile) {
    _fileName = _jinyaFile.name;
    _nameController.text = _fileName;
  }

  Future<void> updateFile() async {
    try {
      await network.updateFile(_jinyaFile.id, _nameController.text);
      if (_file != null) {
        await network.uploadFile(_jinyaFile.id, _file);
      }
      final file = await network.getFile(_jinyaFile.id);

      Navigator.of(this.context).pop(file);
    } on ConflictException {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(l10n.editFileExistsError)));
    } on NotEnoughPermissionsException {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(l10n.editFileNotEnoughPermissionsError)));
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
        title: Text(_jinyaFile.name),
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
                    return l10n.editFileNameEmpty;
                  }

                  return null;
                },
                decoration: InputDecoration(
                  labelText: l10n.editFileName,
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
                      child: Text(l10n.editFileActionPickFile),
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
                      onPressed: updateFile,
                      color: Theme.of(context).primaryColor,
                      textColor: Color(0xFFFFFFFF),
                      child: Text(l10n.editFileActionUpdate),
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
