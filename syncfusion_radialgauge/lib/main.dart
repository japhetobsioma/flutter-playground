import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:confetti/confetti.dart';

import 'waterintake.dart';

void main() {
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}

final provider = StateNotifierProvider((ref) => WaterIntakeNotifier());

class App extends HookWidget {
  final ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));
  final ConfettiController _controllerBottomCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  @override
  Widget build(BuildContext context) {
    final waterIntakeModel = useProvider(provider.state);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Radial Gauge'),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    false, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                axes: <RadialAxis>[
                  RadialAxis(
                    interval: 10,
                    showTicks: false,
                    showLabels: false,
                    axisLineStyle: AxisLineStyle(
                      thickness: 20,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: waterIntakeModel.intakeValue.toDouble(),
                        width: 20,
                        color: Colors.blue,
                        enableAnimation: true,
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Text(
                          '${waterIntakeModel.intakeValue}%',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConfettiWidget(
                confettiController: _controllerBottomCenter,
                blastDirection: -pi / 2,
                emissionFrequency: 0.01,
                numberOfParticles: 20,
                maxBlastForce: 100,
                minBlastForce: 80,
                gravity: 0.3,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  context.read(provider).reset();
                },
                child: Icon(Icons.restore),
              ),
              FloatingActionButton(
                onPressed: () {
                  if (waterIntakeModel.intakeValue < 90) {
                    context.read(provider).increment();
                    _controllerCenter.play();
                  } else if (waterIntakeModel.intakeValue == 90) {
                    context.read(provider).increment();
                    _controllerCenter.play();
                    _controllerBottomCenter.play();
                  }
                },
                child: Icon(Icons.local_drink),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
