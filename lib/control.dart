import 'package:countdown/model.dart';
import 'package:elegant_spring_animation/elegant_spring_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Control extends StatelessWidget {
  const Control({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);

    return CupertinoButton(
      onPressed: model.toggle,
      child: AnimatedRotation(
        turns: model.playing ? 1 / 4 : 0,
        curve: ElegantSpring.mediumBounce,
        duration: ElegantSpring.mediumBounce.recommendedDuration,
        child: AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: const Icon(CupertinoIcons.play_fill, size: 80),
          secondChild: const Icon(CupertinoIcons.stop_fill, size: 80),
          crossFadeState: model.playing
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
        ),
      ),
    );
  }
}
