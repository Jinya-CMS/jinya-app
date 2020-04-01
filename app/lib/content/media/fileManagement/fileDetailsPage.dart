import 'package:chewie/chewie.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jinya_app/content/media/fileManagement/editFile.dart';
import 'package:jinya_app/network/media/files.dart';
import 'package:jinya_app/shared/currentUser.dart';
import 'package:video_player/video_player.dart';

class FileDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FileDetailsPageState(_file);

  File _file;

  FileDetailsPage(this._file);
}

class FileDetailsPageState extends State<FileDetailsPage> {
  File _file;
  bool _changed;
  ChewieAudioController _chewieAudioController;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  FileDetailsPageState(this._file);

  @override
  void dispose() {
    _chewieAudioController?.dispose();
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final column = Column(
      children: <Widget>[],
    );
    if (_file.type.startsWith('image/')) {
      column.children.addAll(
        [
          Image(
            image: NetworkImage(
              '${SettingsDatabase.selectedAccount.url}/${_file.path}',
            ),
          ),
        ],
      );
    } else if (_file.type.startsWith('video/')) {
      _videoPlayerController = VideoPlayerController.network(
          '${SettingsDatabase.selectedAccount.url}/${_file.path}');

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoInitialize: true,
      );

      column.children.addAll([
        Chewie(
          controller: _chewieController,
        ),
      ]);
    } else if (_file.type.startsWith('audio/')) {
      _videoPlayerController = VideoPlayerController.network(
          'https://www.w3schools.com/tags/horse.mp3');

      _chewieAudioController = ChewieAudioController(
        videoPlayerController: _videoPlayerController,
        autoInitialize: true,
      );

      column.children.addAll([
        ChewieAudio(
          controller: _chewieAudioController,
        ),
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_file.name),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, _changed),
        ),
      ),
      body: column,
      floatingActionButton: FloatingActionButton(
        tooltip: "Edit",
        onPressed: () async {
          final file = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditFilePage(_file),
          ));
          if (file is File) {
            setState(() {
              _file = file;
              _changed = true;
            });
          }
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
