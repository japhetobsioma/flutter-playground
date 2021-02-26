import 'package:http/http.dart' as http;

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'album.dart';

class AlbumNotifier extends StateNotifier<AsyncValue<Album>> {
  AlbumNotifier() : super(const AsyncValue.loading()) {
    fetchAlbum();
  }

  Future<void> fetchAlbum() async {
    try {
      final response =
          await http.get(Uri.https('jsonplaceholder.typicode.com', 'posts/1'));
      state = AsyncValue.data(Album.fromJson(response.body));
    } on Exception catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
