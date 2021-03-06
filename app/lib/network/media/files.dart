import 'dart:io' as io;
import 'dart:typed_data';

import 'package:jinya_app/network/base/jinyaRequest.dart';

class File {
  int id;
  String name;
  String path;
  String type;

  File({this.id, this.name, this.path, this.type});

  factory File.fromMap(Map<String, dynamic> json) {
    final file = File();
    if (json.containsKey('id')) {
      file.id = json['id'];
    }
    if (json.containsKey('name')) {
      file.name = json['name'];
    }
    if (json.containsKey('path')) {
      file.path = json['path'];
    }
    if (json.containsKey('type')) {
      file.type = json['type'];
    }

    return file;
  }
}

Future<List<File>> getFiles() async {
  final response = await get('api/media/file');
  if (response.statusCode != io.HttpStatus.ok) {
    print(response.data.toString());
    throw Exception('This should not happen');
  } else {
    final data = response.data;
    return List.generate(data['count'], (i) => File.fromMap(data['items'][i]));
  }
}

Future<File> getFile(int id) async {
  final response = await get('api/media/file/$id');
  if (response.statusCode != io.HttpStatus.ok) {
    print(response.data.toString());
    throw Exception('This should not happen');
  } else {
    final data = response.data;
    return File.fromMap(data);
  }
}

Future<File> createFile(String name) async {
  final response = await post('api/media/file', data: {'name': name});
  if (response.statusCode != io.HttpStatus.created) {
    print(response.data.toString());
    throw Exception('This should not happen');
  } else {
    return File.fromMap(response.data);
  }
}

Future<void> updateFile(int id, String name) async {
  final response = await put('api/media/file/$id', data: {'name': name});
  if (response.statusCode != io.HttpStatus.noContent) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }
}

Future<void> deleteFile(int id) async {
  final response = await delete('api/media/file/$id');
  if (response.statusCode != io.HttpStatus.noContent) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }
}

Future<void> startUpload(int id) async {
  final response = await post('api/media/file/$id/content');
  if (response.statusCode != io.HttpStatus.noContent) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }
}

Future<void> uploadChunk(int id, int position, Uint8List chunk) async {
  final response =
      await put('api/media/file/$id/content/$position', data: chunk);
  if (response.statusCode != io.HttpStatus.noContent) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }
}

Future<void> finishUpload(int id) async {
  final response = await put('api/media/file/$id/content/finish');
  if (response.statusCode != io.HttpStatus.noContent) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }
}

Future<void> uploadFile(int id, io.File file) async {
  await startUpload(id);
  await uploadChunk(id, 0, await file.readAsBytes());
  await finishUpload(id);
}
