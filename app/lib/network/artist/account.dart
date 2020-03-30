import 'package:jinya_app/network/artist/artist.dart';
import 'package:jinya_app/network/base/jinyaRequest.dart';

Future<Artist> getAccount() async {
  final response = await get('api/account');

  return Artist.fromMap(response.data);
}
