import 'dart:io';

import 'package:jinya_app/network/base/jinyaRequest.dart';

enum Orientation { horizontal, vertical }

enum Type { sequence, masonry }

class Gallery {
  int id;
  String name;
  String slug;
  String description;
  Orientation orientation;
  Type type;

  Gallery(this.id, this.name, this.slug, this.description, this.orientation,
      this.type);

  factory Gallery.fromMap(Map<String, dynamic> map) => Gallery(
        map['id'],
        map['name'],
        map['slug'],
        map['description'],
        map['orientation'] == 'horizontal'
            ? Orientation.horizontal
            : Orientation.vertical,
        map['type'] == 'masonry' ? Type.masonry : Type.sequence,
      );
}

Future<List<Gallery>> getGalleries() async {
  final response = await get('api/media/gallery');
  if (response.statusCode != HttpStatus.ok) {
    print(response.data.toString());
    throw Exception('This should not happen');
  } else {
    final data = response.data;
    return List.generate(
      data['count'],
      (i) => Gallery.fromMap(data['items'][i]),
    );
  }
}

Future<void> deleteGallery(String slug) async {
  final response = await delete('api/media/gallery/$slug');
  if (response.statusCode != HttpStatus.noContent) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }
}

Future<Gallery> createGallery(
  String name, {
  String description = '',
  Type type = Type.sequence,
  Orientation orientation = Orientation.vertical,
}) async {
  final response = await post('api/media/gallery', data: {
    'name': name,
    'description': description,
    'type': type == Type.sequence ? 'sequence' : 'masonry',
    'orientation':
        orientation == Orientation.vertical ? 'vertical' : 'horizontal',
  });
  if (response.statusCode != HttpStatus.created) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }

  return Gallery.fromMap(response.data);
}

Future<void> updateGallery(
  String slug, {
  String name,
  String description = '',
  Type type = Type.sequence,
  Orientation orientation = Orientation.vertical,
}) async {
  final response = await put('api/media/gallery/$slug', data: {
    'name': name,
    'description': description,
    'type': type == Type.sequence ? 'sequence' : 'masonry',
    'orientation':
        orientation == Orientation.vertical ? 'vertical' : 'horizontal',
  });
  if (response.statusCode != HttpStatus.noContent) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }
}

Future<Gallery> getGallery(String slug) async {
  final response = await get('api/media/gallery/$slug');
  if (response.statusCode != HttpStatus.ok) {
    print(response.data.toString());
    throw Exception('This should not happen');
  }

  return Gallery.fromMap(response.data);
}
