import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class FakeHttpClient {
  Future<String> get(String url) async {
    await Future.delayed(const Duration(seconds: 1));

    return 'Response from $url';
  }
}

final fakeHttpClientProvider = Provider((ref) => FakeHttpClient());
final responseProvider =
    FutureProvider.autoDispose.family<String, String>((ref, url) async {
  final httpClient = ref.read(fakeHttpClientProvider);

  return httpClient.get(url);
});

class MyApp extends StatelessWidget {
  const MyApp();
  static const myAppTitle = 'Riverpod Tutorial';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: myAppTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Riverpod Tutorial'),
        ),
        body: Center(
          child: Consumer(
            builder: (context, watch, child) {
              final responseAsyncValue =
                  watch(responseProvider('https://www.google.com/'));

              return responseAsyncValue.map(
                data: (_) => Text(_.value),
                loading: (_) => CircularProgressIndicator(),
                error: (_) => Text(
                  _.error.toString(),
                  style: TextStyle(color: Colors.red),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
