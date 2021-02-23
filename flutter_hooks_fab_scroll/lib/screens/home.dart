import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends HookWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    final _animationController = useAnimationController(
      duration: kThemeAnimationDuration,
      initialValue: 1,
    );
    final _scrollController = useScrollController();
    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        case ScrollDirection.forward:
          _animationController.forward();
          break;
        case ScrollDirection.reverse:
          _animationController.reverse();
          break;
        case ScrollDirection.idle:
          break;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s Scroll'),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          for (int i = 0; i < 5; i++)
            Card(
              child: const FittedBox(
                child: FlutterLogo(),
              ),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FadeTransition(
        opacity: _animationController,
        child: ScaleTransition(
          scale: _animationController,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text('Useless Floating Action Button'),
          ),
        ),
      ),
    );
  }
}
