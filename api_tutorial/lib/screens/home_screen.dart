import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/album_provider.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final albumModel = useProvider(albumProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
      ),
      body: Center(
        child: albumModel.when(
          data: (value) => Text(value.title),
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) =>
              Text('Error: $error StackTrace: $stackTrace'),
        ),
      ),
    );
  }
}
