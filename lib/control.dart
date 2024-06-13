import 'package:countdown/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Control extends StatelessWidget {
  const Control({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);

    return IconButton(
      color: Theme.of(context).colorScheme.primary,
      iconSize: 80,
      onPressed: model.toggle,
      icon: AnimatedRotation(
        turns: model.playing ? 1 / 4 : 0,
        duration: Durations.medium2,
        child: AnimatedCrossFade(
            duration: Durations.medium2,
            firstChild: const Icon(Icons.play_arrow_rounded),
            secondChild: const Icon(Icons.stop_rounded),
            crossFadeState: model.playing
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst),
      ),
    );
  }
}
